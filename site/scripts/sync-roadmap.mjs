import { writeFile } from "node:fs/promises";
import { fileURLToPath } from "node:url";

const LINEAR_ENDPOINT = "https://api.linear.app/graphql";
const TEAM_KEY = "SFN";
const PUBLIC_LABEL = "roadmap:public";
const HORIZON_LABELS = new Map([
  ["horizon:1.0", "1.0"],
  ["horizon:later", "later"],
  ["horizon:exploration", "exploration"],
]);
const OUTPUT_PATH = fileURLToPath(
  new URL("../src/data/roadmap.json", import.meta.url),
);

const query = `
  query PublicRoadmapProjects($after: String) {
    projects(first: 50, after: $after) {
      nodes {
        name
        summary
        state
        archivedAt
        canceledAt
        teams {
          nodes {
            key
          }
        }
        initiatives {
          nodes {
            name
          }
        }
        labels {
          nodes {
            name
          }
        }
      }
      pageInfo {
        hasNextPage
        endCursor
      }
    }
  }
`;

function requireApiKey() {
  const apiKey = process.env.LINEAR_API_KEY;
  if (!apiKey) {
    throw new Error("LINEAR_API_KEY is required to synchronize the roadmap");
  }
  return apiKey;
}

async function fetchProjectPage(apiKey, after) {
  const response = await fetch(LINEAR_ENDPOINT, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: apiKey,
    },
    body: JSON.stringify({ query, variables: { after } }),
  });

  if (!response.ok) {
    throw new Error(
      `Linear API returned HTTP ${response.status} ${response.statusText}`,
    );
  }

  const payload = await response.json();
  if (payload.errors?.length) {
    throw new Error(
      `Linear GraphQL error: ${payload.errors
        .map((error) => error.message)
        .join("; ")}`,
    );
  }

  if (!payload.data?.projects) {
    throw new Error("Linear response did not contain projects");
  }

  return payload.data.projects;
}

async function fetchProjects(apiKey) {
  const projects = [];
  let after = null;

  do {
    const page = await fetchProjectPage(apiKey, after);
    projects.push(...page.nodes);
    after = page.pageInfo.hasNextPage ? page.pageInfo.endCursor : null;
  } while (after);

  return projects;
}

function statusFor(project) {
  if (project.state === "completed") return "completed";
  if (project.state === "started") return "in-progress";
  if (project.state === "paused") return "paused";
  return "planned";
}

function toPublicProject(project) {
  const labelNames = new Set(project.labels.nodes.map((label) => label.name));
  if (!labelNames.has(PUBLIC_LABEL)) return null;

  if (project.archivedAt || project.canceledAt || project.state === "canceled") {
    throw new Error(
      `Public roadmap Project "${project.name}" is archived or canceled; remove ${PUBLIC_LABEL}`,
    );
  }

  const horizons = [...HORIZON_LABELS.entries()].filter(([label]) =>
    labelNames.has(label),
  );
  if (horizons.length !== 1) {
    throw new Error(
      `Public roadmap Project "${project.name}" must have exactly one horizon label`,
    );
  }

  const initiatives = project.initiatives.nodes.map(
    (initiative) => initiative.name,
  );
  if (initiatives.length !== 1) {
    throw new Error(
      `Public roadmap Project "${project.name}" must belong to exactly one Initiative`,
    );
  }

  const summary = project.summary?.trim();
  if (!summary) {
    throw new Error(
      `Public roadmap Project "${project.name}" needs a reviewed public summary`,
    );
  }

  return {
    name: project.name,
    summary,
    initiative: initiatives[0],
    horizon: horizons[0][1],
    status: statusFor(project),
  };
}

async function main() {
  const apiKey = requireApiKey();
  const projects = await fetchProjects(apiKey);
  const publicProjects = projects
    .filter((project) =>
      project.teams.nodes.some((team) => team.key === TEAM_KEY),
    )
    .map(toPublicProject)
    .filter(Boolean)
    .sort(
      (a, b) =>
        a.horizon.localeCompare(b.horizon) ||
        a.initiative.localeCompare(b.initiative) ||
        a.name.localeCompare(b.name),
    );

  const snapshot = {
    schemaVersion: 1,
    syncedAt: new Date().toISOString(),
    projects: publicProjects,
  };

  await writeFile(OUTPUT_PATH, `${JSON.stringify(snapshot, null, 2)}\n`);
  console.log(`Wrote ${publicProjects.length} public roadmap Projects`);
}

await main();
