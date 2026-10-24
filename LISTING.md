# Directory listing drafts

Ready-to-paste answers for the Anthropic Claude directory (MCP connector) and
the OpenAI plugin directory (ChatGPT app). Nothing has been submitted.
Submitting publishes SVCZZ under the owner's account, so the owner does it.

Requirements checked on 2026-10-24 against:

- Claude: [Submit a connector](https://claude.com/docs/connectors/building/submission),
  [Connector pre-submission checklist](https://claude.com/docs/connectors/building/review-criteria),
  [Authentication for connectors](https://claude.com/docs/connectors/building/authentication),
  [Lazy authentication](https://claude.com/docs/connectors/building/lazy-authentication),
  [Publish to the directory](https://claude.com/docs/directory/publish).
- OpenAI: [Upload and submit your plugin](https://developers.openai.com/plugins/deploy/submission),
  [Plugin submission errors](https://developers.openai.com/plugins/deploy/submission-errors).

Tool facts come from the API code (`crates/http/src/mcp/people/` in
`api.svczz.com`, `main` at `349c6c4`), not from memory.

## Shared facts

| Field | Value |
|---|---|
| Name | SVCZZ |
| Server URL | `https://api.svczz.com/mcp` (Streamable HTTP, stateless) |
| Auth | OAuth 2.1, authorization code + PKCE S256, dynamic client registration (RFC 7591), public clients. Catalog tools work with no token (lazy auth) |
| Discovery | `https://api.svczz.com/.well-known/oauth-protected-resource/mcp`, `https://api.svczz.com/.well-known/oauth-authorization-server` |
| Scopes | `read` (always granted), `library:write` (optional), `social:write` (optional, no tool uses it yet) |
| Tokens | Access 1 h; refresh 90 days, rotated on every use, reuse revokes the grant; bound to the resource (RFC 8707) |
| Docs URL | https://svczz.com/ai (also `https://svczz.com/mcp-documentation`, a 301 to it) |
| Privacy policy | https://svczz.com/privacy (section "AI assistants": `#ai-assistants`) |
| Terms | https://svczz.com/terms |
| Support | support@lipi.com.np (support page: https://svczz.com/support) |
| Website | https://svczz.com |
| Company | Lipi Technology, Balkumari-9, Lalitpur, Nepal (registration no. 610048917), https://lipi.com.np |
| Price | Free on every SVCZZ plan; searching needs no account |
| Plugin repo | https://github.com/LipiTechnology/svczz-watchlist (to publish; this folder) |

## Logo

| File | Size | Use |
|---|---|---|
| `assets/logo.png` (copy in `chatgpt/assets/`) | 512 × 512 PNG, RGBA, white background, 22 KB | Claude connector icon; OpenAI `logo` and `composerIcon` (square, 48 to 4096 px, 5 MiB or less: passes) |
| `svczz.com/packages/ui/public/svczz.svg` | SVG, square `viewBox 0 0 1000 1000` | Spare vector if a form asks for SVG |

The server's `initialize` already lists `https://svczz.com/icons/android-icon-512x512.png` and `-192x192.png`.

## Screenshots

- Claude: carousel screenshots are only for MCP Apps (interactive UI). SVCZZ
  returns structured output, not UI, so none are required.
- OpenAI: screenshots are allowed only when the scan finds a UI output template
  (`screenshots_not_allowed` otherwise). Don't upload any.
- For the listing page or a blog post, if wanted after deploy: (1) "Find a
  feel-good 90s comedy on Netflix in the US" with cards, (2) "What's my next
  watch tonight?", (3) "I'm up to S2E4 of The Bear" with the write
  confirmation, (4) the SVCZZ consent screen, (5) Settings → Connected apps.
  PNG, at least 1000 px wide, cropped to the response.
- Documentation page screenshots for review: `docs/screenshots/mcpdoc/ai-mobile.png`
  (390 px) and `ai-desktop.png` (1400 px) in the `svczz.com` repo, branch `mcpdoc`.

## Tools

29 tools. Every tool sets a `title` and all four hints (`readOnlyHint`,
`destructiveHint`, `idempotentHint`, `openWorldHint`) through the `Tool` and
`PublicTool` traits. `openWorldHint` is false everywhere: every tool reads or
writes SVCZZ's own data (catalog data is TMDB's, cached and served by the
SVCZZ API). R = read-only, W = writes (not destructive), D = destructive.

| Tool | Title | Access | R/W | Justification (for the OpenAI form) |
|---|---|---|---|---|
| `search_titles` | Search titles | none | R | Looks up movies, series or people by name in SVCZZ's catalog; changes nothing |
| `discover` | Discover by description | none | R | Semantic search over SVCZZ's catalog with filters; changes nothing |
| `title_details` | Title details | none | R | Returns one title's catalog details; changes nothing |
| `episodes` | Season episodes | none | R | Returns one season's episode list; changes nothing |
| `where_to_watch` | Where to watch | none | R | Returns streaming, rent and buy offers SVCZZ has cached; changes nothing and contacts no service on the user's behalf |
| `trending` | Trending now | none | R | Returns SVCZZ's trending list; changes nothing |
| `collection` | SVCZZ collections | none | R | Lists collections or returns a page of one; changes nothing |
| `person` | Person | none | R | Returns a person's biography and credits; changes nothing |
| `calendar_upcoming` | Upcoming releases | none | R | Returns public release lists; changes nothing |
| `articles_for_title` | Articles about a title | none | R | Returns SVCZZ's published articles; changes nothing |
| `similar_titles` | More like this | none | R | Returns similar titles from SVCZZ's index; changes nothing |
| `get_profile` | Get profile | `read` | R | Returns the signed-in user's own profile and connection scope; changes nothing |
| `my_library` | My watch list | `read` | R | Lists the user's own saved titles; changes nothing |
| `continue_watching` | Continue watching | `read` | R | Lists the user's own unfinished titles; changes nothing |
| `my_lists` | My lists | `read` | R | Lists the user's own lists; changes nothing |
| `list_get` | Open a list | `read` | R | Returns one of the user's own lists; another user's list is "not found"; changes nothing |
| `my_stats` | My stats | `read` | R | Returns the user's own viewing stats; changes nothing |
| `my_calendar` | My calendar | `read` | R | Returns releases of titles the user follows; changes nothing |
| `recommend_for_me` | Recommend for me | `read` | R | Computes picks from the user's ratings; changes nothing |
| `friends_activity` | Friends' activity | `read` | R | Returns activity of accepted friends who opted in to sharing; changes nothing |
| `my_notifications` | My notifications | `read` | R | Returns the user's notifications without marking them read; changes nothing |
| `save_title` | Save to watch list | `library:write` | W | Adds a title or sets its status in the user's own watch list; keeps rating and note; repeating it gives the same result; nothing is deleted |
| `set_progress` | Set series progress | `library:write` | W | Marks episodes up to one point watched in the user's own library; never unmarks; idempotent |
| `rate_title` | Rate a title | `library:write` | W | Sets the user's own 1 to 10 rating; replaces the previous rating, which the user can set again; idempotent |
| `mark_watched` | Mark as watched | `library:write` | W | Marks a movie, season or episode watched in the user's own library; idempotent; nothing is deleted |
| `add_to_list` | Add to a list | `library:write` | W | Appends a title to one of the user's own lists; adding it twice changes nothing |
| `remove_from_list` | Remove from a list | `library:write` | **D** | Removes a title from one of the user's lists; the title stays in the watch list, but the list entry and its position are gone |
| `create_list` | Create a list | `library:write` | W (not idempotent) | Creates a new empty, private list in the user's account; each call makes another list |
| `hide_title` | Hide a title | `library:write` | W | Hides a title from the user's own rows and recommendations; reversible in Settings → Hidden titles |

Resources: `svczz://guide` (everyone), `svczz://lists/{id}` (the user's own
lists, with `read`). Prompts: `get_started`, `whats_my_next_watch`,
`plan_a_movie_night`.

## Claude: developer portal answers

Portal: https://claude.ai/directory/manage → **Submit new** → **MCP connector**.
Needs a paid Claude plan (Pro, Max, Team or Enterprise; on Team and Enterprise
an Owner). Submit the plugin bundle separately afterwards (**Plugin bundle**,
from the public GitHub repo) and pair the two.

**1. Connection.** Universal URL: `https://api.svczz.com/mcp`.

**2. Tools.** Synced from the server. Expect 21 read-only and 8 write tools, no
flags for missing titles or annotations.

**3. Listing.**

- Server name (≤ 100): `SVCZZ`
- One-liner (≤ 200, 75 used):

  > Find what to watch, see where it streams, and keep your watch list in step.

- Description (≤ 2,000, 1,059 used):

  > SVCZZ helps you find movies and series and keep track of what you watch. Describe what you're in the mood for, such as "a slow-burn sci-fi series" or "feel-good 90s comedies", and get matching titles with posters, ratings and links. See where each one streams, rents or sells in your country, and browse trending titles, curated collections, upcoming releases, cast and episode guides. All of this works without an account.
  >
  > Connect your free SVCZZ account to see your watch list, lists, progress, calendar and stats, get picks based on what you've rated and watched, and see what friends who share their activity are watching. If you allow changes, Claude can update your library when you say so: save a title, rate it, mark episodes watched, or build a list for movie night.
  >
  > When you connect, you choose whether Claude may only see your library or also change it. Claude never sees your password, can't delete titles, lists or your account, and can't see other people's private data. You can disconnect at any time in SVCZZ under Settings → Connected apps.

- Categories (1 to 5): Entertainment; Lifestyle (pick the closest names the
  portal offers).
- Documentation URL: `https://svczz.com/ai`
- Privacy policy URL: `https://svczz.com/privacy`
- Support contact: `support@lipi.com.np`
- Icon: `assets/logo.png`
- URL slug (permanent): `svczz`

**4. Use cases.**

- Primary use cases: find something to watch from a description; check where a
  title streams in a country; plan a movie night; catch up on series and record
  episode progress; get recommendations from your ratings; keep your watch list
  and lists up to date.
- What users need: nothing for search and browsing; a free SVCZZ account
  (https://svczz.com/register) with a verified email for library features.
- Reads or writes: both. Writes only touch the user's own watch list and lists,
  and only with the `library:write` permission.

**5. Company.** Lipi Technology, https://lipi.com.np. Primary contact: the
owner's name and email (fill in).

**6. Authentication.** Authentication requirement: **Required when the server
asks**. Method: OAuth sign-in with dynamic client registration (no client ID or
secret to enter). Callback `https://claude.ai/api/mcp/auth_callback` and
loopback redirects on any port for Claude Code are accepted by the server's DCR
rules (https, and `localhost`, `127.0.0.1`, `[::1]` with any port).

**7. Data handling.** The API is our own (`api.svczz.com`). Catalog data comes
from TMDB through its API and is cached by SVCZZ; streaming availability is
TMDB's (JustWatch). No personal health data. No sponsored content.

**8. Test & launch.** Paste and fill in:

> Test account (verified, no MFA): email `<REVIEWER_EMAIL>`, password `<REVIEWER_PASSWORD>`. It has a watch list with titles in all four statuses (watching, watched, planning, dropped), two custom lists, several rated and watched titles so recommendations have seeds, one series in progress, and one friend who shares activity.
>
> Steps: add `https://api.svczz.com/mcp` as a custom connector. Ask "Find a feel-good 90s comedy on Netflix in the US" (no sign-in needed). Then ask "What's on my watch list as planning?". Claude shows Connect; sign in with the test account, keep all boxes ticked and choose Allow. Try "Mark Breaking Bad watched up to season 1 episode 3" and "Make a list called Movie night with Heat and Ronin".

Tick that every tool was run through MCP Inspector or a custom connector (do it
after deploy).

**9. Compliance.** Seven acknowledgments. SVCZZ moves no money, generates no
media, collects no conversation data and has public documentation, so all
seven can be ticked truthfully once the items under "API follow-ups" marked
*before submitting* are done.

## OpenAI: plugin portal answers

Portal: `platform.openai.com/plugins`. Needs a verified individual or business
identity and Apps Management write access, in a project with global data
residency.

**Package.** `scripts/zip.sh chatgpt` → `dist/svczz-chatgpt-plugin.zip`
(`plugin.json`, `mcp.json`, `assets/logo.png`, and `skills/` added from the repo
root). The listing text, test cases and release notes live in
`chatgpt/plugin.json` and are imported read-only.

| Field | Value | Limit |
|---|---|---|
| `displayName` | SVCZZ | 30 |
| `shortDescription` | Find what to watch, track it (28) | 30 |
| `longDescription` | In `chatgpt/plugin.json` (1,071 characters) | 4,000 |
| `developerName` | Lipi Technology | 80 |
| `category` | Entertainment | dashboard list |
| `capabilities` | 7 entries, each under 120 | 20 × 120 |
| `defaultPrompt` | 3 prompts, each under 128 | 3 × 128 |
| URLs | website, support, privacy, terms: all HTTPS | required for MCP |
| `logo`, `composerIcon` | `./assets/logo.png`, 512 × 512 | square, 48 to 4096 |

**In the portal.**

- MCP server: **With MCP**, `https://api.svczz.com/mcp`. Auth: mixed (no auth
  plus OAuth). Registration: `dcr`.
- Domain verification: serve the portal's token as plain text at
  `https://api.svczz.com/.well-known/openai-apps-challenge` (API follow-up 1),
  then **Verify Domain**.
- Tool scan: run it against production; it should list 29 tools.
- Annotation justifications: paste from the Tools table above.
- Test cases: 5 positive and 3 negative, already in `chatgpt/plugin.json`
  (`discover`; `my_library`; `search_titles, set_progress`;
  `my_lists, create_list, search_titles, add_to_list`; `friends_activity`.
  Negative: cinema tickets, playback, another user's private list).
- Reviewer credentials (Review details, never in the ZIP): the same test
  account as for Claude, without MFA, magic links or email codes.
- Demo recording URL: **to record** after deploy and add as
  `review.demo_recording_url` (required for MCP review).
- Release notes: in `publication.release_notes`.
- Countries: leave `publication.countries` out (no restriction).
- Commerce: false.

## API follow-ups

Found while checking the forms against the code. None was changed here.

**Before submitting**

1. **OpenAI domain challenge.** `GET /.well-known/openai-apps-challenge` on
   `api.svczz.com`, returning the portal's token as plain text from an env var
   (lipi does this). Not built (A27, A29).
2. **Deploy and check production.** `APP_URL=https://api.svczz.com`,
   `FRONTEND_URL=https://svczz.com`; discovery documents must return `https://`
   URLs; no Cloudflare cache rule on `POST /mcp`. Then connect from real Claude
   and ChatGPT: browse without signing in, sign in from an account tool, run one
   read and one write.
3. **Reviewer test account** with the sample data listed under Test & launch.
4. **`scope` in the 401 challenge.** `challenge()` in `crates/http/src/mcp/mod.rs`
   sends only `resource_metadata` and `error`. Without `scope="read library:write"`
   Claude requests every scope in `scopes_supported`, including `social:write`,
   which no tool uses. Add the scope parameter, or drop `social:write` from the
   people server's `scopes_supported` and the consent screen until a social tool
   exists (least privilege is a review point for both directories).

**Soon after**

5. **Step-up with HTTP 403.** A signed-in connection without `library:write`
   that calls a write tool gets a `200` tool error with
   `_meta["mcp/www_authenticate"]`. ChatGPT reads that; Claude re-authorizes
   only on an HTTP `403` with `WWW-Authenticate: Bearer error="insufficient_scope", scope="read library:write"`.
   Gate scope refusals in the HTTP layer as anonymous account calls already are.
6. **CIMD.** Claude recommends Client ID Metadata Documents over DCR for
   directory traffic, since DCR registers a new client on every fresh
   connection. Advertise `client_id_metadata_document_supported: true` (with
   `"none"` already in `token_endpoint_auth_methods_supported`) and fetch and
   check the `client_id` URL at `/oauth/authorize`. OpenAI's portal also
   accepts `cimd`.
7. **Top-level `securitySchemes` on tools.** Only in `_meta` today (rmcp's
   `Tool` has no field for it; A29). ChatGPT reads both.

**Optional**

8. **`Origin` check.** The MCP transport runs with `disable_allowed_origins()`.
   Browsers don't call `/mcp` and tokens are bearer, so the risk is low, but the
   MCP spec asks servers to validate `Origin` when present. Reject requests whose
   `Origin` is set and not an allowed app.
9. **Plugin license.** `claude plugin validate . --profile directory` refuses
   the plugin bundle without a `LICENSE` or a `license` field (Lipi's repo has
   the same gap). The owner should pick one before submitting the bundle.
