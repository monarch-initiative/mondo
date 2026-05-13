---
name: odk
description: Use when running any ODK-backed command in this repo — owltools, robot, make NORM,
  robot verify, or any other tool that lives inside the ODK docker image
---

# Running ODK commands in this repo

## TL;DR

`src/ontology/run.sh` is the official wrapper, but it ends in `docker run -ti` so it **fails silently in any non-TTY context** (Claude Code, CI, non-interactive shells) with `the input device is not a TTY` and exits without running the command.

If you have a TTY, prefer `run.sh`. If you don't, call docker directly with `-i` only.

## When you have a TTY (interactive terminal)

```bash
cd src/ontology && sh run.sh <command> <args...>
```

Examples:
```bash
sh run.sh make NORM
sh run.sh owltools --use-catalog mondo-edit.obo --obsolete-replace MONDO:A MONDO:B -o -f obo mondo-edit.obo
sh run.sh robot verify --catalog catalog-v001.xml -i mondo-edit.obo --queries ../sparql/qc/general/qc-foo.sparql -O reports/
```

## When you don't have a TTY (Claude Code, CI, scripts)

Symptom: `sh run.sh <anything>` prints `the input device is not a TTY` and exits with no further output, no file changes.

Workaround — invoke docker directly using the same image and mounts as `run.sh`, but with `-i` only:

```bash
docker run --memory=8g \
  -v /ABSOLUTE/PATH/TO/REPO:/work \
  -w /work/src/ontology \
  -e ROBOT_JAVA_ARGS=-Xmx8G -e JAVA_OPTS=-Xmx8G \
  --rm -i obolibrary/odkfull:<TAG-FROM-RUN.SH> \
  <command> <args...>
```

Where:
- `/ABSOLUTE/PATH/TO/REPO` = the repo root (the parent of `src/`).
- `<TAG-FROM-RUN.SH>` = whatever tag is set in `IMAGE=` in `src/ontology/run.sh`. **Always read `run.sh` first to look up the current tag** — do not hardcode `v1.6` or any other version.

## Reading the right image tag

Don't memorize the version. The line in `run.sh` is the source of truth:

```bash
grep '^IMAGE=' src/ontology/run.sh
# IMAGE=${IMAGE:-odkfull:v1.6}
```

## Common ODK commands you'll need

| What | Command body (after `run.sh` or after the `docker run ... -i obolibrary/odkfull:<TAG>` prefix) |
|---|---|
| Normalize edit file | `make NORM` then `mv NORM mondo-edit.obo` (run from `src/ontology`) |
| Convert / syntax check | `robot convert --catalog catalog-v001.xml -i mondo-edit.obo -f obo -o mondo-edit.TMP.obo` |
| Run a QC query | `robot verify --catalog catalog-v001.xml -i mondo-edit.obo --queries ../sparql/qc/general/qc-X.sparql -O reports/` |
| Merge / obsolete with replacement | `owltools --use-catalog mondo-edit.obo --obsolete-replace MONDO:A MONDO:B -o -f obo mondo-edit.obo` |

## Notes

- All ODK commands assume CWD is `src/ontology/`.
- `make NORM` writes to a file called `NORM` in `src/ontology/`. You must `mv NORM mondo-edit.obo` afterward.
- `robot verify` exits non-zero on QC failures and writes one TSV per failing query under `-O reports/`. Empty exit + `PASS Rule ... 0 violation(s)` = clean.
- If `run.sh` reports `the input device is not a TTY`, do **not** retry the same command — it will keep failing. Switch to the docker-direct invocation.
