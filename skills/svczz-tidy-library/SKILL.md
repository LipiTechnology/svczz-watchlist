---
name: svczz-tidy-library
description: Tidy the user's SVCZZ watch list and lists. Finds stalled Watching titles, Planned titles they've already seen, finished series still marked watching, and titles in a list twice or in the wrong list, then fixes them in one reviewed batch. Use when the user says their watch list is a mess, wants to clean up or reorganise lists, or their Watching shelf is full of things they stopped. Needs the SVCZZ MCP server with the user's account connected; fixes need the Change your library permission.
---

# Tidy the library

Find what's out of date in the user's watch list and lists, then fix it in one
batch they approve.

## Before you start

This skill needs the SVCZZ MCP server (`https://api.svczz.com/mcp`), the user's
account, and for fixes the Change your library permission. If tools such as
`my_library` are not available, say so and point the user to
https://github.com/LipiTechnology/svczz-watchlist#readme.

The server can't delete a title from the watch list or delete a list. It can
change a title's status, hide it, or take it out of one list. Tell the user
when something has to be done on svczz.com instead.

## Steps

1. `my_library` with `status: watching`, `sort: updated` (up to 5 pages). The
   titles at the end haven't changed in a long time.
2. `continue_watching` for real progress on each.
3. `title_details` on watching series: ended series where they finished the
   last aired episode belong in watched.
4. `my_library` with `status: planning` (up to 5 pages). Ask the user to point
   out any they've already seen or lost interest in.
5. `my_lists`, then `list_get` for each list: find titles that appear twice or
   that the user calls out as in the wrong list.

## The batch

Show one table of proposed changes, grouped by kind, with the tool each uses:

- Stalled for months: `save_title` with `status: dropped`, or keep.
- Finished: `save_title` with `status: watched`.
- Already seen: `save_title` with `status: watched`, and `rate_title` if they
  give a rating.
- Never want to see: `hide_title` (it can be shown again in Settings, Hidden
  titles; the free plan hides up to 50).
- Wrong list: `add_to_list` to the right one, then `remove_from_list`.

Wait for the user's yes, and let them strike items. `remove_from_list` takes a
title out of a list; ask about each one. Then apply the changes and report what
changed, with links.
