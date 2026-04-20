import { defineCollection } from "astro:content";
import { glob } from "astro/loaders";
import { z } from "astro/zod";
import { docsLoader } from "@astrojs/starlight/loaders";
import { docsSchema } from "@astrojs/starlight/schema";

const docs = defineCollection({
  loader: docsLoader(),
  schema: docsSchema({
    // Accept legacy frontmatter keys from pre-Starlight docs so existing files
    // keep working. Ordering is driven by Starlight's `sidebar.order` field;
    // `section` is informational only.
    extend: z.object({
      section: z.string().optional(),
      order: z.number().optional(),
    }),
  }),
});

const blog = defineCollection({
  loader: glob({
    base: "./src/content/blog",
    pattern: "**/*.{md,mdx}",
  }),
  schema: z.object({
    title: z.string(),
    description: z.string().optional(),
    date: z.string(),
    author: z.string().optional(),
  }),
});

export const collections = { docs, blog };
