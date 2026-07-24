# Public Roadmap Publication

Linear is Sailfin's maintainer planning source of truth. The public roadmap is a
reviewed projection of that planning data, not a second planning surface and not
an automatic dump of every Initiative or Project.

## Publication contract

A Linear Project is eligible for the public roadmap only when all of these are
true:

1. It belongs to the Sailfin (`SFN`) team and exactly one Initiative.
2. It has the Project label `roadmap:public`.
3. It has exactly one Project horizon label:
   - `horizon:1.0` — work currently inside the stable-1.0 maturity boundary.
     This is not a release date, launch deadline, or immutable checklist.
   - `horizon:later` — an approved direction outside the current 1.0 boundary.
     It is not a rejection; projects may move as evidence, dependencies, and
     priorities change.
   - `horizon:exploration` — a concept worth preserving publicly while its
     design, sequencing, or fit remains open. It is not a delivery promise.
4. Its Project summary is written and reviewed as public-facing copy.
5. It is not archived or canceled.

The `roadmap:public` and `horizon:*` labels are publication metadata. They do
not replace Linear's native Project status, issue priority, estimate, blockers,
or Cycle. Releases remain Cycles across Projects; issue-level release gates
remain separate from the Project-level public horizon.

Adding, removing, or changing either publication label requires explicit owner
approval. Agents must not infer public status or a horizon from Initiative
membership, Project status, priority, target date, issue count, an SFEP, or
prose such as "future" or "post-1.0".

Completed public Projects are shown separately as **Delivered Foundations**.
This is a presentation derived from Linear's native completed state, not another
label or planning category.

## Publication flow

The site renders `site/src/data/roadmap.json`, a sanitized snapshot containing
only the public Project name, reviewed summary, Initiative name, horizon, and
native status. It deliberately contains no Linear URLs, descriptions, comments,
member data, issue data, or private identifiers.

After an approved Linear change:

```sh
cd site
LINEAR_API_KEY=... npm run sync:roadmap
npm run build
```

Review and commit the snapshot diff like any other public documentation change.
A normal site build never calls Linear and never needs a Linear API key. If a
sync fails, the last reviewed snapshot remains intact.

The sync fails rather than guessing when a public Project has conflicting or
missing horizon metadata, no public summary, no Initiative, multiple
Initiatives, or a canceled/archived state.

## Links

The public page does not link to Linear. Project names are rendered as text with
stable page context. A public SFEP or GitHub issue may be linked elsewhere in
the site when it is independently useful, but Sailfin does not create GitHub
mirrors merely to make internal planning clickable.
