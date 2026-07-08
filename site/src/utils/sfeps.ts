import type { CollectionEntry } from "astro:content";

export type SfepEntry = CollectionEntry<"sfep">;

export interface SfepSummary {
  entry: SfepEntry;
  id: string;
  number: string;
  title: string;
  status: string;
  type: string;
  created?: string;
  updated?: string;
  author?: string;
  tracking?: string;
  slug: string;
  href: string;
  searchableText: string;
}

const SKIPPED_PREFIXES = ["archive/", "design-notes/"];
const SKIPPED_IDS = new Set(["README", "template"]);

export function isCanonicalSfepEntry(entry: SfepEntry): boolean {
  if (SKIPPED_IDS.has(entry.id)) return false;
  if (SKIPPED_PREFIXES.some((prefix) => entry.id.startsWith(prefix))) {
    return false;
  }
  if (entry.id.includes("/")) {
    return /^\d{4}-[^/]+\/00-overview$/.test(entry.id);
  }
  if (entry.id.startsWith("draft-")) return true;
  if (/^\d{4}-/.test(entry.id)) return true;
  return false;
}

export function slugForSfep(entry: SfepEntry): string {
  const sourceStem = (entry.filePath?.replace(/^.*\/docs\/proposals\//, "") ?? `${entry.id}.md`)
    .replace(/\.md$/, "");
  if (sourceStem.endsWith("/00-overview")) {
    return sourceStem.replace(/\/00-overview$/, "");
  }
  return sourceStem;
}

export function labelForSfepNumber(value: SfepEntry["data"]["sfep"]): string {
  if (typeof value === "number") {
    return `SFEP-${String(value).padStart(4, "0")}`;
  }
  if (typeof value === "string" && value.trim().length > 0) {
    const normalized = value.trim();
    return /^\d+$/.test(normalized)
      ? `SFEP-${normalized.padStart(4, "0")}`
      : `SFEP-${normalized}`;
  }
  return "SFEP";
}

function sortableNumber(value: SfepEntry["data"]["sfep"]): number {
  if (typeof value === "number") return value;
  if (typeof value === "string") {
    const parsed = Number.parseInt(value, 10);
    return Number.isNaN(parsed) ? Number.POSITIVE_INFINITY : parsed;
  }
  return Number.POSITIVE_INFINITY;
}

export function toSfepSummary(entry: SfepEntry): SfepSummary {
  const slug = slugForSfep(entry);
  const number = labelForSfepNumber(entry.data.sfep);
  const title = entry.data.title ?? entry.id;
  const status = entry.data.status ?? "Unknown";
  const type = entry.data.type ?? "proposal";
  const fields = [
    number,
    title,
    status,
    type,
    entry.data.author,
    entry.data.tracking,
    slug,
  ];

  return {
    entry,
    id: entry.id,
    number,
    title,
    status,
    type,
    created: entry.data.created,
    updated: entry.data.updated,
    author: entry.data.author,
    tracking: entry.data.tracking,
    slug,
    href: `/sfep/${slug}`,
    searchableText: fields.filter(Boolean).join(" ").toLowerCase(),
  };
}

export function sortSfeps(a: SfepSummary, b: SfepSummary): number {
  const byNumber = sortableNumber(a.entry.data.sfep) - sortableNumber(b.entry.data.sfep);
  if (byNumber !== 0) return byNumber;
  return a.title.localeCompare(b.title);
}
