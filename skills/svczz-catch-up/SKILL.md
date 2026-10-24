---
name: svczz-catch-up
description: Catch the user up on the series they follow in SVCZZ (which shows have aired episodes they haven't watched, how many, and what airs next) and record their progress when they say where they are. Use when the user asks what they've missed, what's new in their shows, how far behind they are, or says "I'm up to S2E5 of X" or "I finished X". Needs the SVCZZ MCP server with the user's account connected; recording progress needs the Change your library permission.
---

# Catch up on episodes

Tell the user where they stand on each series they're watching, and keep their
SVCZZ progress right.

## Before you start

This skill needs the SVCZZ MCP server (`https://api.svczz.com/mcp`) and the
user's account. If tools such as `my_library` are not available, say so and
point the user to https://github.com/LipiTechnology/svczz-watchlist#readme.

## Steps

1. `my_library` with `status: watching`, `type: tv`, `sort: updated`. Read up to
   5 pages (10 titles a page).
2. `continue_watching` for the episode the user is partway through in each.
3. For each series, `title_details` (`type: tv`, `id`) for its seasons and next
   episode, then `episodes` (`id`, `season`) for the current season. Count the
   episodes that have aired after the last one they finished.
4. `my_calendar` (no dates: the next 30 days) for episodes coming soon.

## What to write

- One line per series, most behind first: title, where they are, how many
  aired episodes they have left, and the next one with its air date.
- Series that are finished or not airing: say so, and ask whether to mark them
  watched or dropped.
- What airs in the next 7 days, from `my_calendar`.

## Recording progress

When the user says where they are, record it. Show what you will change and
wait for a yes before each write.

- "I'm up to season 2 episode 4": `set_progress` (`id`, `season: 2`,
  `episode: 4`). It marks every earlier episode watched too and never unmarks.
- One episode or a whole season out of order: `mark_watched` (`type: tv`, `id`,
  `season`, and `episode` for one).
- "I finished it": `save_title` with `status: watched`.
- "I gave up on it": `save_title` with `status: dropped`.

Use `search_titles` first when you don't have the series' `id`. If a write
says the connection can't change the library, tell the user to reconnect SVCZZ
with "Change your library" ticked.
