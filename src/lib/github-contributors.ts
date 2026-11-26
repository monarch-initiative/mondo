// Pulls contributors to the monarch-initiative/mondo repository from the GitHub API at build time,
// so the Contribute page picks up new people without hand edits. If GitHub can't be reached
// (offline, rate limit), the page falls back to the hand-kept list in src/data/contributors.yaml.
//
// Set GITHUB_TOKEN for a higher API rate limit (the deploy workflow does this).

const REPO = "monarch-initiative/mondo";

// Accounts that commit to the repo but aren't people.
const AUTOMATION_ACCOUNTS = new Set(["bbopjenkins", "dragon-ai-agent", "actions-user", "copilot"]);

export interface GithubPerson { login: string; name?: string }

const headers: Record<string, string> = {
  Accept: "application/vnd.github+json",
  "User-Agent": "mondo-website-build",
  ...(process.env.GITHUB_TOKEN ? { Authorization: `Bearer ${process.env.GITHUB_TOKEN}` } : {}),
};

async function getJson(path: string) {
  const res = await fetch(`https://api.github.com/${path}`, { headers });
  if (!res.ok) throw new Error(`GitHub API ${res.status} for ${path}`);
  return res.json();
}

/** People (not bots or automation accounts) who have committed to the Mondo repository. */
async function fetchContributors(): Promise<GithubPerson[]> {
  const people: GithubPerson[] = [];
  for (let page = 1; page <= 10; page++) {
    const batch = await getJson(`repos/${REPO}/contributors?per_page=100&page=${page}`);
    for (const c of batch) {
      const login: string = c.login;
      if (c.type !== "User" || login.endsWith("[bot]") || AUTOMATION_ACCOUNTS.has(login.toLowerCase())) continue;
      people.push({ login });
    }
    if (batch.length < 100) break;
  }
  return people;
}

/** Display name from a GitHub profile, if the person has set one. */
export async function githubName(login: string): Promise<string | undefined> {
  try {
    const user = await getJson(`users/${login}`);
    return user.name?.trim() || undefined;
  } catch {
    return undefined;
  }
}

// Cache for the life of the build (and the dev server), so pages don't refetch.
let cached: Promise<GithubPerson[]> | undefined;
export function githubContributors(): Promise<GithubPerson[]> {
  cached ??= fetchContributors().catch((err) => {
    console.warn(`[contributors] Using the hand-kept list only: ${err.message}`);
    return [];
  });
  return cached;
}
