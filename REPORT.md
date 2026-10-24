# MCP-PUB report

Public docs for the SVCZZ people MCP server, a public plugin repo, and
directory listing drafts. Nothing pushed, nothing submitted. The admin MCP
server (`/admin/mcp`) is not mentioned anywhere public.

## Part 1: site docs (`svczz.com`, branch `mcpdoc`)

Worktree `~/projects/svczz/wt/web-mcpdoc`, from `main` at `cf38dbb`. Merging
`main` again was a no-op ("Already up to date").

| Commit | What |
|---|---|
| `002997d` feat(site): full MCP server documentation on /ai | `apps/site/app/routes/ai.tsx` and the `ai.*` strings in `packages/i18n/src/locales/en.json` |
| `991b5bb` feat(site): redirect /mcp-documentation to /ai | `routes/mcp-documentation.ts`, one line in `routes.ts` |
| `4382c92` test(e2e): cover the MCP docs page, its tools and the redirect | `e2e/w21.spec.ts`, `docs/screenshots/mcpdoc/` |

`/ai` now has the same sections as Lipi's `mcp-documentation` page:

- Header: H1 "SVCZZ MCP server", last-updated date, short summary, the server
  URL with a copy button, a free/no-account line, and an "On this page" list.
- What it does, and what it can't do. It can't play video or sell tickets,
  delete titles or lists, use social features yet, see other people's private
  data, or touch the account or password.
- Connect: Claude (claude.ai, Desktop, mobile, using the current "Customize →
  Connectors → Add custom connector" labels from Claude's docs), Claude Code
  (the two plugin commands, plus `claude mcp add`), ChatGPT (developer mode),
  VS Code, Cursor, Codex, Gemini CLI, and any other client.
- Access and permissions: no account, `read`, `library:write` and
  `social:write`, each with what it allows. Plan limits.
- Tools: all 29, in three tables by access, each with a Reads, Changes or
  Removes badge taken from the server's hints. Also resources and prompts.
- Example prompts, sign-in and security (OAuth 2.1, PKCE, DCR, token lifetimes,
  discovery URLs), rate limits (60, 60 and 120 a minute; 429 with
  `Retry-After`).
- Data and privacy, with links to `/privacy#ai-assistants` and `/terms`.
- See and disconnect apps, linking to `/settings/apps`.
- Troubleshooting, five Q&As.
- Support: support@lipi.com.np, and Lipi Technology as operator, using
  `content/legal/facts.json`.
- SEO: the title is "SVCZZ MCP server for Claude, ChatGPT and AI assistants",
  with a new description. Canonical and OG tags come from `pageMeta`. JSON-LD
  is a `TechArticle` (with `dateModified`, a free `SoftwareApplication` and the
  publisher) plus a `FAQPage` covering setup and troubleshooting, and the
  breadcrumb is automatic. `/ai` was already in the sitemap and the footer
  ("SVCZZ in your AI"); both are unchanged.
- Stable URL: `/ai` stays. `/mcp-documentation` is a 301 to it, for listings.

Checks, all in Docker (`COMPOSE_PROJECT_NAME=svczz-web-mcpdoc`, ports
5222/5223):

| Check | Result |
|---|---|
| `npm run typecheck` | pass |
| `npm run lint` | pass |
| `npm run format:check` | pass |
| `npm test` | pass (53 files, 469 tests) |
| `npm run build` | pass |
| e2e `w21.spec.ts` + `a11y.spec.ts`, filtered to `/ai` and the redirect | 4 passed, 4 skipped. The skips are the `mobile` project, which these specs skip by design; the a11y spec runs its own phone and desktop viewports |
| axe on `/ai` (phone and desktop) | 0 serious or critical |

The e2e test now checks the H1, server URL copy, plugin command, 29 tool rows,
`remove_from_list` as Removes, the privacy link, the support email and the 301.

Screenshots, from Playwright in Docker:
`docs/screenshots/mcpdoc/ai-mobile.png` (390 px) and `ai-desktop.png`
(1400 px). The old W21 mobile shot caught the menu sheet sliding in after the
resize, so the test now reloads at phone size and dismisses the cookie banner
first. The fixed bottom nav still shows mid-page in the full-page phone shot,
as in every other full-page shot in the repo.

The copy went through the human:unslop rules: no dashes, straight quotes, and
plain verbs.

## Part 2: plugin repo (`~/projects/svczz/svczz-mcp-plugin`)

A new standalone repo on branch `main` with 6 commits (7 with this report),
using the global git identity.

**Name: `LipiTechnology/svczz-watchlist`** (plugin `svczz-watchlist`,
marketplace `svczz`). This follows Lipi's pattern of brand plus the generic
term people search for (`lipi-expense-tracker`). "Watchlist" is the word people
use when they look for this kind of tool: watchlist app, TV watchlist, movie
watchlist. "watch-tracker" can be read as wristwatches, and "tv-tracker" leaves
out movies. The keywords cover the rest: `tv-tracker`, `movies`,
`streaming`, `what-to-watch`.

Layout mirrors `lipi-expense-tracker`:

- `.claude-plugin/plugin.json` (version 1.0.0, docs `https://svczz.com/ai`,
  privacy, terms and support URLs) and `marketplace.json`.
- `.mcp.json` pointing at `https://api.svczz.com/mcp`.
- `assets/logo.png`, the 512 × 512 SVCZZ mark from
  `packages/ui/public/icons/android-icon-512x512.png`.
- `chatgpt/`: `plugin.json` in Agent Plugins format, with listing text, 5
  positive and 3 negative test cases, and release notes. Also `mcp.json` and
  `assets/logo.png`. `composerIcon` is set because OpenAI's errors page now
  requires it.
- `scripts/zip.sh chatgpt` builds `dist/svczz-chatgpt-plugin.zip`. Unlike
  Lipi's script, it also copies `skills/` into the ZIP, because the portal
  wants at least one skill in a public ZIP (`plugin_runtime_surface_missing`).
  The script was run and the ZIP lists all files. `dist/` is ignored.
- `README.md`: Claude Code with two copyable commands, claude.ai and Claude
  Desktop, ChatGPT, a table of six other agents, how to install the skills,
  privacy, and maintainer notes.
- Eight skills in Agent Skills format. Each uses only tools that exist on the
  server, with argument names and enum values checked against the Rust inputs:

| Skill | Tools |
|---|---|
| `svczz-tonight` (includes a random "roulette" pick) | `continue_watching`, `my_library`, `title_details`, `where_to_watch`, `recommend_for_me`, `save_title` |
| `svczz-catch-up` | `my_library`, `continue_watching`, `title_details`, `episodes`, `my_calendar`, `set_progress`, `mark_watched`, `save_title`, `search_titles` |
| `svczz-taste-picks` | `my_library`, `recommend_for_me`, `similar_titles`, `where_to_watch`, `save_title`, `hide_title` |
| `svczz-whats-new` | `my_calendar`, `my_notifications`, `friends_activity`, `calendar_upcoming`, `trending` |
| `svczz-year-in-review` | `my_stats`, `my_library`, `get_profile` |
| `svczz-movie-night` | `discover`, `recommend_for_me`, `my_library`, `title_details`, `where_to_watch`, `my_lists`, `create_list`, `add_to_list` |
| `svczz-import-list` | `search_titles`, `save_title`, `rate_title`, `my_lists`, `create_list`, `add_to_list` |
| `svczz-tidy-library` | `my_library`, `continue_watching`, `title_details`, `my_lists`, `list_get`, `save_title`, `rate_title`, `hide_title`, `add_to_list`, `remove_from_list` |

Watch Roulette exists in the API (A25) but has no MCP tool. "Roulette" is
therefore a random pick inside `svczz-tonight`, made by the assistant from the
user's own shortlist, not a call to the Roulette feature.

`claude plugin validate .` passes. `claude plugin validate . --profile directory`
fails with one problem, `LICENSE_MISSING`. As asked, the repo follows Lipi's
licensing, and Lipi has no LICENSE file and no `license` field, so there is no
license here either. The plugin bundle can't be submitted to Claude's directory
until the owner picks a license. The ChatGPT package and the connector listing
don't need one.

## Part 3: listing drafts

`LISTING.md` covers:

- The shared facts.
- Logo sizes, and the screenshots each form needs: none for either, since
  SVCZZ has no MCP App UI. It suggests five for marketing.
- A 29-row tool table with title, scope, read or write, and a justification
  line for OpenAI's annotation form.
- Step-by-step answers for Claude's developer portal (all 10 steps; lengths
  checked: one-liner 75 of 200, description 1,059 of 2,000).
- Answers for OpenAI's plugin portal (field limits checked in
  `chatgpt/plugin.json`).

Both forms' current rules were read on the web, read-only. Sources are linked
at the top of `LISTING.md`.

API follow-ups, from the code (nothing changed):

1. Serve `/.well-known/openai-apps-challenge`. It's not built.
2. Deploy and check production URLs, then run a real Claude and ChatGPT round
   trip.
3. Create the reviewer test account.
4. The 401 challenge has no `scope` parameter, so Claude asks for all scopes,
   including the unused `social:write`. Add `scope`, or drop `social:write`
   until a tool uses it.
5. A missing scope comes back as a `200` tool error. Claude only re-asks on an
   HTTP `403` with `insufficient_scope`.
6. Add CIMD support. Claude prefers it to DCR for directory traffic.
7. Add top-level `securitySchemes` on tools. Today they are in `_meta` only.
8. Optional: an `Origin` check on `/mcp`.

Already in place: every tool has a title and all four hints, and
`remove_from_list` is the only destructive one. Also OAuth 2.1, PKCE S256, DCR,
RFC 9728/8414 discovery, resource binding, refresh rotation, lazy auth (401 on
account tools without a token), and the privacy policy's AI section.

## Open points for the owner

- The `/ai` page and README link to `github.com/LipiTechnology/svczz-watchlist`,
  which returns 404 until the repo is published under that name. If you pick
  another name, change `PLUGIN_REPO` in `ai.tsx`, the e2e plugin command, and
  the repo's manifests, README and skills.
- Pick a license for the plugin repo before submitting the bundle.
- Record the demo video for OpenAI and add `review.demo_recording_url`.
- The ChatGPT and Claude menu labels on `/ai` follow the vendors' docs as of
  2026-10-24. Check them in the live apps after deploy.

## Cleanup

`docker compose down -v` removed all containers and volumes for project
`svczz-web-mcpdoc`. The shared `svczz-e2e:1.64.1` image was left in place.
The worktree is clean on branch `mcpdoc`.
