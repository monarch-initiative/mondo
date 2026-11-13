// @ts-check
import { defineConfig } from "astro/config";

export default defineConfig({
  site: "https://mondo.monarchinitiative.org",
  trailingSlash: "ignore",
  build: { format: "directory" },
  // Keep old links working after the reorganization.
  redirects: {
    "/pages/resources": "/pages/publications/",
    "/pages/about": "/",
    "/pages/outreach-calls": "/pages/community-calls/",
    // Pages retired in the redesign.
    "/pages/editors": "/pages/contributors/",
    "/pages/faq": "/",
    "/pages/analysis": "/pages/rare-disease/",
    "/pages/disease-naming": "/pages/publications/",
    "/pages/howToMakeAGoodTermRequest": "/pages/contributors/",
  },
});
