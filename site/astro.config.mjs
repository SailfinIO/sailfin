import { createRequire } from "node:module";
import { defineConfig } from "astro/config";
import mdx from "@astrojs/mdx";
import sitemap from "@astrojs/sitemap";
import starlight from "@astrojs/starlight";

// Custom TextMate grammar so `sfn` code blocks are syntax-highlighted.
// Loaded via createRequire for Node-version-agnostic JSON import.
const require = createRequire(import.meta.url);
const sailfinGrammar = require("./src/grammars/sailfin.tmLanguage.json");

export default defineConfig({
  site: "https://sailfin.dev",
  output: "static",

  integrations: [
    starlight({
      title: "Sailfin",
      logo: {
        src: "./public/images/sfn_lang_logo_256.svg",
        replacesTitle: false,
      },
      social: [
        { icon: "github", label: "GitHub", href: "https://github.com/sailfinio/sailfin" },
      ],
      customCss: ["./src/styles/starlight-theme.css"],
      head: [
        // Match the font stack used by the marketing BaseLayout so the
        // `sfn` wordmark in SiteHeader and any Inter/JetBrains Mono prose
        // render consistently across marketing and docs surfaces.
        { tag: "link", attrs: { rel: "preconnect", href: "https://fonts.googleapis.com" } },
        { tag: "link", attrs: { rel: "preconnect", href: "https://fonts.gstatic.com", crossorigin: "" } },
        {
          tag: "link",
          attrs: {
            rel: "stylesheet",
            href: "https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500;700&display=swap",
          },
        },
      ],
      components: {
        Header: "./src/components/starlight/Header.astro",
        MobileMenuFooter: "./src/components/starlight/MobileMenuFooter.astro",
      },
      sidebar: [
        {
          label: "Getting Started",
          items: [{ autogenerate: { directory: "docs/getting-started" } }],
        },
        {
          label: "Learning Sailfin",
          items: [{ autogenerate: { directory: "docs/learn" } }],
        },
        {
          label: "Reference",
          items: [
            { label: "Overview", link: "/docs/reference/" },
            {
              label: "Language Spec",
              collapsed: false,
              items: [{ autogenerate: { directory: "docs/reference/spec" } }],
            },
            {
              label: "Design Preview",
              collapsed: true,
              items: [{ autogenerate: { directory: "docs/reference/preview" } }],
            },
            { label: "Grammar (EBNF)", link: "/docs/reference/grammar" },
            { label: "Keywords", link: "/docs/reference/keywords" },
            { label: "Effect System", link: "/docs/reference/effects" },
            { label: "Standard Library", link: "/docs/reference/standard-library" },
            { label: "CLI Reference", link: "/docs/reference/cli" },
              { label: "Benchmarking", link: "/docs/reference/bench" },
            { label: "Runtime ABI", link: "/docs/reference/runtime-abi" },
          ],
        },
        {
          label: "Advanced",
          items: [{ autogenerate: { directory: "docs/advanced" } }],
        },
        {
          label: "Contributing",
          items: [{ autogenerate: { directory: "docs/contributing" } }],
        },
      ],
      pagefind: true,
    }),
    mdx(),
    sitemap(),
  ],

  redirects: {
    "/docs/contributing/roadmap": "/roadmap",
  },

  markdown: {
    shikiConfig: {
      theme: "github-dark",
      langs: [{ ...sailfinGrammar, aliases: ["sfn"] }],
    },
  },
});
