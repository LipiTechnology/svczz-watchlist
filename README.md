# SVCZZ Watchlist

Use [SVCZZ](https://svczz.com), the movie and series tracker, from your AI
assistant: find something to watch from a description, see where it streams in
your country, and keep your watch list, lists and episode progress up to date
without opening the site.

The core is the SVCZZ MCP server, `https://api.svczz.com/mcp`. Searching and
browsing work without an account. Connect your SVCZZ account (OAuth) and the
assistant can also read your library and, if you allow it, change it. You
choose what it may do when you connect, and you can disconnect it at any time
on svczz.com under Settings → Connected apps. Full documentation, with every
tool, is at [svczz.com/ai](https://svczz.com/ai).

On top of the server, `skills/` holds optional skills: plain `SKILL.md` files
in the Agent Skills format. Each one has the assistant do a job that takes
several of the server's tools, using your real watch list. They do nothing
without the server.

| Skill | What it does |
|---|---|
| `svczz-tonight` | Picks one thing to watch tonight from what you're partway through and your Planned titles, fitted to your time, mood and services. Can pick at random |
| `svczz-catch-up` | Shows how many aired episodes you have left on each series you're watching and what airs next, and records "I'm up to S2E5" |
| `svczz-taste-picks` | Recommends titles from what you rated highly and watched, says which favourite each one resembles, and checks where it streams |
| `svczz-whats-new` | A weekly briefing of new episodes of your shows, unread notifications, friends' activity and what's newly streaming |
| `svczz-year-in-review` | Your year in hours, titles, episodes, genres and best-rated titles, compared with the year before |
| `svczz-movie-night` | Five movies a group can agree on and stream in their country, saved as a list to vote on |
| `svczz-import-list` | Adds a pasted or attached list of titles to your watch list or a custom list, asking about unclear matches first |
| `svczz-tidy-library` | Finds stalled, finished and already-seen titles and misplaced list entries, and fixes them in one reviewed batch |

Skills that write ask before changing anything. Writing needs the "Change your
library" permission when you connect.

Searching needs nothing. For your own library you need an SVCZZ account at
[svczz.com](https://svczz.com/register).

## Claude Code

The plugin bundles the server and the skills. Two commands inside Claude Code,
one at a time. First add this repo as a marketplace:

```
/plugin marketplace add LipiTechnology/svczz-watchlist
```

Then install the plugin:

```
/plugin install svczz-watchlist@svczz
```

Then run `/mcp`, pick **svczz** and choose **Authenticate** to connect your
account (skip this if you only want to browse). Skills are called as
`/svczz-watchlist:svczz-tonight` and so on, or Claude picks them up when they
fit.

To add the server alone: `claude mcp add --transport http svczz https://api.svczz.com/mcp`.

To try a local checkout without installing: `claude --plugin-dir /path/to/svczz-watchlist`.

## Claude (claude.ai, Claude Desktop, mobile) and ChatGPT

These take the server only:

- **Claude:** Customize → Connectors → **Add custom connector**, name `SVCZZ`,
  URL `https://api.svczz.com/mcp`, then **Add**. Claude shows a **Connect**
  button the first time it needs your account. A connector added on the web
  also appears in Claude Desktop and the mobile apps.
- **ChatGPT:** Settings → Apps → Advanced settings → turn on developer mode →
  **Create app**, URL `https://api.svczz.com/mcp`, authentication OAuth.

## Other agents

**1. Add the server.** Every agent below opens a browser to sign in to SVCZZ
the first time it needs your account.

| Agent | Where | Add |
|---|---|---|
| Codex | `~/.codex/config.toml` | `[mcp_servers.svczz]` with `url = "https://api.svczz.com/mcp"`, then run `codex mcp login svczz` |
| Cursor | `.cursor/mcp.json` or `~/.cursor/mcp.json` | `{ "mcpServers": { "svczz": { "url": "https://api.svczz.com/mcp" } } }` |
| VS Code (GitHub Copilot) | `.vscode/mcp.json` | `{ "servers": { "svczz": { "type": "http", "url": "https://api.svczz.com/mcp" } } }` |
| Gemini CLI | `~/.gemini/settings.json` | `{ "mcpServers": { "svczz": { "httpUrl": "https://api.svczz.com/mcp" } } }` |
| OpenCode | `opencode.json` | `{ "mcp": { "svczz": { "type": "remote", "url": "https://api.svczz.com/mcp" } } }` |
| Windsurf | `~/.codeium/windsurf/mcp_config.json` | `{ "mcpServers": { "svczz": { "serverUrl": "https://api.svczz.com/mcp" } } }` |

Any other MCP client: add a remote (Streamable HTTP) server at
`https://api.svczz.com/mcp` with OAuth. It supports dynamic client
registration, so there is no client ID to set up.

**2. Add the skills (optional).** One command detects your agents and asks
where to put them:

```sh
npx skills add LipiTechnology/svczz-watchlist
```

Or copy each folder under `skills/` into your agent's skills folder:

| Agent | Project folder | Personal folder |
|---|---|---|
| Codex | `.agents/skills/` | `~/.codex/skills/` |
| OpenCode | `.agents/skills/` | `~/.config/opencode/skills/` |
| Cursor | `.agents/skills/` | `~/.cursor/skills/` |
| GitHub Copilot | `.agents/skills/` | `~/.copilot/skills/` |
| Windsurf | `.windsurf/skills/` | `~/.codeium/windsurf/skills/` |
| Claude Code, without the plugin | `.claude/skills/` | `~/.claude/skills/` |

Outside Claude Code the skills have no `svczz-watchlist:` prefix; call them by
name, such as `svczz-tonight`.

## Privacy

Nothing in this repo is secret and nothing here collects data. Without an
account, SVCZZ doesn't know who is asking. With your account, the assistant
sees only what it looks up to answer you, within the permissions you gave.
What it reads from SVCZZ goes to that assistant's provider, under your
agreement with them. See the [privacy policy](https://svczz.com/privacy#ai-assistants)
and the [MCP documentation](https://svczz.com/ai#privacy).

Questions: [support@lipi.com.np](mailto:support@lipi.com.np). SVCZZ is run by
Lipi Technology.

## For maintainers

| Path | What |
|---|---|
| `.claude-plugin/plugin.json`, `.mcp.json`, `skills/`, `assets/` | Claude Code plugin `svczz-watchlist`; the repo root is the plugin |
| `.claude-plugin/marketplace.json` | Marketplace `svczz`, listing the root as the plugin |
| `chatgpt/` | OpenAI plugin package (Agent Plugins format), not submitted yet |
| `scripts/zip.sh` | Builds an upload ZIP for a platform folder, with `skills/` added |
| `LISTING.md` | Answers for the Claude and ChatGPT directory forms |

Reviewer credentials go into each portal's own form, never into this repo.

Before a release:

```sh
claude plugin validate .                         # plugin and marketplace
claude plugin validate . --profile directory     # Anthropic's directory rules
scripts/zip.sh chatgpt                           # → dist/svczz-chatgpt-plugin.zip
```

Upload the ChatGPT ZIP at `platform.openai.com/plugins` and raise `version` in
`chatgpt/plugin.json` each time. Raise `version` in `.claude-plugin/plugin.json`
for each Claude Code release.

Known OpenAI portal limits (see Lipi's plugin repo, found by trial):

- `interface.displayName` and `interface.shortDescription`: at most 30
  characters each.
- `review.test_cases.positive[].tools_triggered`: a string, not a list.
- No pricing, plans or promotions in the description.
- `review.demo_recording_url` is required before submitting; record it after
  the server is live.
