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

const optionalFrontmatterString = z.preprocess((value) => {
  if (value === null || value === undefined) return undefined;
  if (value instanceof Date) return value.toISOString().slice(0, 10);
  return String(value);
}, z.string().optional());

const sfep = defineCollection({
  loader: glob({
    base: "../docs/proposals",
    pattern: "**/*.md",
  }),
  schema: z.object({
    sfep: z.union([z.number(), z.string()]).optional(),
    title: z.string().optional(),
    status: z.string().optional(),
    type: z.string().optional(),
    created: optionalFrontmatterString,
    updated: optionalFrontmatterString,
    author: z.string().optional(),
    tracking: optionalFrontmatterString,
    supersedes: optionalFrontmatterString,
    "superseded-by": optionalFrontmatterString,
    "graduates-to": optionalFrontmatterString,
  }),
});

export const collections = { docs, blog, sfep };
