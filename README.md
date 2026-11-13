# Mondo Website (Prototype)

A redesign of [mondo.monarchinitiative.org](https://mondo.monarchinitiative.org/) built with [Astro](https://astro.build/), a static site generator. The look follows [monarchinitiative.org](https://monarchinitiative.org/): teal `#008c99`, Poppins, pill buttons, light-teal footer.

## Run It Locally

Requires Node.js 20 or newer. No Ruby, Jekyll or Docker needed.

```bash
npm install
npm run dev      # live preview at http://localhost:4321
npm run build    # static site written to dist/
```

## Where Content Lives

Most updates are a single entry in a YAML (a plain-text data format) file. No HTML needed.

| To update... | Edit |
| --- | --- |
| Community calls | `src/data/community-calls.yaml` (add new calls at the top) |
| Publications and blogs | `src/data/publications.yaml` |
| Presentations and posters | `src/data/presentations.yaml` |
| Who uses Mondo | `src/data/users.yaml` |
| Sources (also drives the homepage ring diagram) | `src/data/sources.yaml` |
| Homepage stats and charts | `src/data/stats.md` (see below) |
| Workshops | `src/data/workshops.yaml` |
| Rare Diseases | `src/pages/pages/rare-disease.md` |
| Top navigation and footer links | `src/lib/nav.ts` |
| Contributor acknowledgement list | `src/data/contributors.yaml` (set `last_confirmed` after the yearly review) |
| Governance site links | `src/lib/governance.ts` (set `GOVERNANCE_LIVE = true` when it launches) |

## Summary Statistics

`src/data/stats.md` keeps the same `<!-- START:TABLE1 -->` / `<!-- END:TABLE2 -->` markers as the old `index.md`. The existing "Update The Stats for Mondo Website" GitHub Action (`.github/workflows/update-stats-mondo-web.yaml` in the mondo repo) only needs its target path changed from `index.md` to `src/data/stats.md`. The homepage stat cards and bar chart are generated from these tables at build time.

## Old URLs

Every existing page URL keeps working. Retired pages redirect (see `astro.config.mjs`):

- `/pages/resources/` goes to Publications
- `/pages/editors/` and `/pages/howToMakeAGoodTermRequest/` go to Contribute (`/pages/contributors/`)
- `/pages/outreach-calls/` goes to Community Calls (`/pages/community-calls/`)
- `/pages/faq/` and `/pages/about/` go to the homepage
- `/pages/analysis/` goes to Rare Diseases
- `/pages/disease-naming/` goes to Publications

## Deploying

Pushing to the `gh-pages` branch runs `.github/workflows/deploy-site.yml`, which builds the site and publishes `dist/` to GitHub Pages. `public/CNAME` keeps the custom domain.

This needs **Settings > Pages > Source** set to **GitHub Actions** (instead of "Deploy from a branch"). Change it when this site first merges, or GitHub's legacy Jekyll build will try to build these files and fail.

After the first deploy, update the "Update The Stats for Mondo Website" workflow on `master` to write to `src/data/stats.md` instead of `index.md`.
