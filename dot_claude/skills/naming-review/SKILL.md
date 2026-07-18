---
name: naming-review
description: >-
  Fix names in recently-changed code. Catch drift: identifiers that stopped
  matching what they hold, one concept named two ways, one name hiding two, UI or
  wire words in domain names. Simplify to shortest clear consistent vocab.
  Trigger on "review vocab", "simplify the names", "check naming", "are these
  names consistent", or after any rename or refactor. Propose concrete renames,
  preserve behavior.
---

# Naming review

A name is a claim about what a thing is. Code changes silently turn some of
those claims false, and every future reader pays the comprehension tax. This
skill re-reads recently-changed names, finds the ones that now mislead or read
clumsily, and proposes concrete, behavior-preserving renames.

Two lenses. **Drift**: the name was once right, then the code moved and it wasn't
updated. **Simplicity**: the name was never the plainest one that fits. Most
sessions want both.

## Scope

Default to the recently-changed surface — run `git diff` (and `git diff
--staged`), or focus on the files touched this session. Names outside the diff
are usually not the job unless the user asks for a whole-codebase sweep; renaming
untouched code balloons the blast radius for little gain.

Read enough of the surrounding code to know what each name actually holds and how
the local code already talks. You are matching this codebase's idiom, not
imposing a house style.

## What to look for

### Drift — names that stopped matching

- **Stale after a rename or refactor.** The value's meaning changed; the label
  didn't. A type `StatusBadge` that is now keyed by a `state` (not a status)
  should be `StateBadge`. This is the single most common finding right after a
  refactor — look hardest here.
- **One concept, two names.** The same thing is `user` in one file and `account`
  in another; `fetch` / `get` / `load` name the same operation. Pick one word and
  use it everywhere on the changed surface. Divergent names read as different
  things and send readers hunting.
- **One name, two concepts.** A single word (`status`, `data`, `value`) covers
  two genuinely different ideas — e.g. one `status` field for a lifecycle and
  another for a review outcome. Split them so each name carries one idea.
- **Layer leak.** Presentation or transport words in domain names: a domain enum
  whose values are CSS `variant`s, a business type named after its JSON wire
  shape, a model method named for the button that calls it. Each name should
  speak its own layer's language.
- **Name/behavior divergence.** `isValid` that also writes to a cache; a `get`
  that mutates. When the name promises less (or other) than the code does, the
  name is lying — rename to the truth (or, if the behavior is the bug, flag it).

### Simplicity — names that were never neat

- **Wordy where short is unambiguous *in context*.** `SellerListingState` reads
  the same as `SellerState` when "listing" is obvious from the module;
  `computeTheResult` → `compute`. Aim for the shortest name an experienced dev
  understands instantly *here* — scope decides how short. `i` is fine in a tight
  loop; a module-level export must stand on its own.
- **Awkward identifier for a plain idea.** Prefer the word the team says out
  loud: `notApproved` → `rejected`, `didFinishLoading` → `loaded`.
- **Noise qualifiers.** `listingData`, `userObject`, `dataManager`, `theList`,
  `myValue` — the suffix adds no information. Drop it.
- **Double negatives.** `isNotDisabled` → `isEnabled`; `!isInvalid` → `isValid`.
- **Inconsistent family.** Related names should share a root: `STATE_BADGES`,
  `badgeForState`, and `StateBadge` are a consistent set; a stray `StatusBadge`
  among them is not.
- **Non-standard abbreviations.** `usr`, `calc`, `mgr` — expand them, unless the
  codebase already uses that abbreviation, in which case match local idiom.

## How to propose

Produce a compact list, not an essay. One line per rename:

```
old → new    — why (the false claim removed, ambiguity resolved, or noise cut)
```

Group related renames (a whole `Status*` → `State*` family is one decision, not
five). Lead with the highest-signal ones.

Separate two kinds:

- **Safe local renames** — the identifier lives entirely within the changed code.
  Apply these, moving *every* reference together.
- **Contract changes** — exported/public names, serialized keys (JSON fields, DB
  columns, API params, env var names), route names, or anything crossing a module
  boundary. These are promises to callers or to stored data; a rename can break
  them. Flag separately and get confirmation before touching.

## Guardrails

- **Behavior must not change.** A rename is only safe if every reference moves
  with it. After applying, run the project's typecheck/build and grep for the old
  name — a rename that strands a dangling reference is worse than no rename.
- **Only rename when clearly better.** The bar is a fixed false claim, a resolved
  real ambiguity, or genuine noise removed — not "I'd have picked a different
  word." Merely-different is churn; leave it. Silence means the name was fine.
- **Context beats rules.** Everything above is a heuristic, not a mandate. The
  surrounding code's conventions win over any general preference here.

## Example

**Input:** a diff that refactored a badge component so the mapping is now keyed by
a derived `state` rather than the raw `status`, but some names weren't updated.

**Output:**
```
StatusBadge (type)      → StateBadge      — keyed by state now, not status; stale after refactor
notApproved (enum val)  → rejected        — plain domain word; label copy can stay "Not approved"
LIFECYCLE_STATES (map)  → STATE_BY_STATUS — names what it maps: status → state
```
Then apply the safe local ones together and re-run typecheck to confirm nothing
dangles.
