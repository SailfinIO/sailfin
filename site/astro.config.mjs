import { defineConfig } from "astro/config";
import mdx from "@astrojs/mdx";
import sitemap from "@astrojs/sitemap";
import starlight from "@astrojs/starlight";

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
      components: {
        SiteTitle: "./src/components/starlight/SiteTitle.astro",
      },
      sidebar: [
        {
          label: "Getting Started",
          autogenerate: { directory: "docs/getting-started" },
        },
        {
          label: "Learning Sailfin",
          autogenerate: { directory: "docs/learn" },
        },
        {
          label: "Reference",
          items: [
            { label: "Overview", link: "/docs/reference/" },
            {
              label: "Language Spec",
              collapsed: false,
              autogenerate: { directory: "docs/reference/spec" },
            },
            {
              label: "Design Preview",
              collapsed: true,
              autogenerate: { directory: "docs/reference/preview" },
            },
            { label: "Grammar (EBNF)", link: "/docs/reference/grammar" },
            { label: "Keywords", link: "/docs/reference/keywords" },
            { label: "Effect System", link: "/docs/reference/effects" },
            { label: "Standard Library", link: "/docs/reference/standard-library" },
            { label: "CLI Reference", link: "/docs/reference/cli" },
            { label: "Runtime ABI", link: "/docs/reference/runtime-abi" },
          ],
        },
        {
          label: "Advanced",
          autogenerate: { directory: "docs/advanced" },
        },
        {
          label: "Contributing",
          autogenerate: { directory: "docs/contributing" },
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
    },
  },
});
