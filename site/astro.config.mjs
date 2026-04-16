import { defineConfig } from "astro/config";
import mdx from "@astrojs/mdx";
import sitemap from "@astrojs/sitemap";

export default defineConfig({
  site: "https://sailfin.dev",
  integrations: [mdx(), sitemap()],
  output: "static",

  redirects: {
    "/docs/contributing/roadmap": "/roadmap",
  },

  markdown: {
    shikiConfig: {
      theme: "github-dark",
    },
  }
});