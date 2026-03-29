import { defineConfig } from "astro/config";
import mdx from "@astrojs/mdx";
import sitemap from "@astrojs/sitemap";

import cloudflare from "@astrojs/cloudflare";

export default defineConfig({
  site: "https://sailfin.dev",
  integrations: [mdx(), sitemap()],

  markdown: {
    shikiConfig: {
      theme: "github-dark",
    },
  },

  adapter: cloudflare()
});