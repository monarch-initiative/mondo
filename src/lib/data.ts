import fs from "node:fs";
import path from "node:path";
import { load as yamlLoad } from "js-yaml";

const DATA_DIR = path.resolve("src/data");

/** Load a YAML file from src/data at build time. */
export function loadYaml<T = any>(name: string): T {
  return yamlLoad(fs.readFileSync(path.join(DATA_DIR, name), "utf8")) as T;
}

export interface StatRow {
  label: string;
  count: number;
  depth: number; // indentation level in the source table (0 = top)
}

/**
 * Parse the markdown tables in src/data/stats.md.
 * The tables are rewritten by the "Update The Stats for Mondo Website" GitHub Action,
 * so we read them as-is and derive indentation from the leading &nbsp; entities.
 */
export function loadStats(): { metrics: StatRow[]; types: StatRow[] } {
  const md = fs.readFileSync(path.join(DATA_DIR, "stats.md"), "utf8");
  const table = (n: number) => {
    const m = md.match(new RegExp(`<!-- START:TABLE${n} -->([\\s\\S]*?)<!-- END:TABLE${n} -->`));
    if (!m) throw new Error(`stats.md is missing TABLE${n} markers`);
    return m[1]
      .split("\n")
      .filter((l) => l.trim().startsWith("|") && !/^\|\s*:?-+/.test(l.trim()))
      .slice(1) // header row
      .map((l) => {
        const [rawLabel, rawCount] = l.split("|").slice(1, 3);
        const nbsp = (rawLabel.match(/&nbsp;/g) || []).length;
        const label = rawLabel
          .replace(/&nbsp;/g, "")
          .replace(/<sup>.*?<\/sup>/g, "")
          .replace(/\*\*/g, "")
          .trim();
        return { label, count: Number(rawCount.trim()), depth: Math.round(nbsp / 4) };
      });
  };
  return { metrics: table(1), types: table(2) };
}

export const fmt = (n: number) => n.toLocaleString("en-US");

/** Resolve a site-internal path against the configured base. */
export const url = (p: string) => {
  if (/^(https?:|mailto:|#)/.test(p)) return p;
  const base = import.meta.env.BASE_URL.replace(/\/$/, "");
  return base + p;
};
