---
name: svczz-import-list
description: Bring a list of movies and series into SVCZZ from anything the user pastes or attaches (a note, a spreadsheet, a screenshot, an export from another app) by matching each title, asking about the unclear ones, and saving them to the watch list with a status or to a custom list. Use when the user wants to import, add many titles at once, move from another tracker, or turn a list of recommendations into a watch list. Needs the SVCZZ MCP server with the user's account connected and the Change your library permission.
---

# Import a list

Turn a messy list of titles into SVCZZ records, with nothing added that the user
didn't mean.

## Before you start

This skill needs the SVCZZ MCP server (`https://api.svczz.com/mcp`), the user's
account, and the Change your library permission. If tools such as
`search_titles` are not available, say so and point the user to
https://github.com/LipiTechnology/svczz-watchlist#readme.

For a CSV export from another site, SVCZZ also has an importer under Settings,
Imports on svczz.com. Mention it for very long lists (more than about 100
titles).

## Steps

1. Read the list. For each line, take the title, a year if there is one, and any
   status or rating it gives ("watched", "4/5").
2. Ask where the titles go, if the user didn't say: the watch list with a
   status (`planning`, `watching`, `watched` or `dropped`), a custom list, or
   both.
3. `search_titles` for each title. Pick the match by year and type. Put aside
   anything with no match or two likely matches.
4. Show the plan before writing: matched titles with year and type, the
   unclear ones with their candidates, and anything not found. Wait for the
   user's yes and their choices on the unclear ones.
5. Write:
   - Watch list: `save_title` (`type`, `id`, `status`).
   - Ratings: `rate_title` (1 to 10). Convert other scales and say how, such
     as 4/5 becoming 8.
   - A custom list: `my_lists` first, then `create_list` if needed, then
     `add_to_list` for each title. The free plan allows 3 lists.
6. Stop and report if a write fails with a plan limit; don't retry it.

## What to write

A short report: how many titles were added and where, which were skipped or
not found, and links to the list or watch list.
