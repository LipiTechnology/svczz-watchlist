---
name: svczz-taste-picks
description: Recommend movies and series from what the user rated highly and watched in SVCZZ, explain each pick by the titles it resembles, check where it streams in their country, and save the ones they like to their watch list. Use when the user asks for recommendations, "what would I like", "more like the shows I loved", or wants new ideas beyond trending. Needs the SVCZZ MCP server with the user's account connected; saving needs the Change your library permission.
---

# Picks from what you liked

Give the user recommendations that come from their own ratings, with a reason
for each that names a title they loved.

## Before you start

This skill needs the SVCZZ MCP server (`https://api.svczz.com/mcp`) and the
user's account. If tools such as `recommend_for_me` are not available, say so
and point the user to https://github.com/LipiTechnology/svczz-watchlist#readme.

Ask for their country (two-letter code) and services if you will check where to
watch and don't know them.

## Steps

1. `my_library` with `status: watched`, `sort: rating`: their top-rated titles
   (first 2 pages). These are the seeds you name in reasons.
2. `recommend_for_me` (`limit: 20`, and `type` if the user wants only movies or
   only series). It already leaves out what they saved, watched or hid.
3. If that comes back empty, the user has too few ratings. Use
   `similar_titles` on their 3 highest-rated titles instead, and suggest they
   rate a few more titles on SVCZZ.
4. For each seed you plan to mention, `similar_titles` on it tells you which
   picks resemble which seed. Use it to write the reasons.
5. `where_to_watch` for your final picks in their country.

## What to write

- 5 to 8 picks, best first: title, year, one line on why ("closest to
  Severance and Dark, which you rated 9 and 10"), and where it streams.
- Leave out anything the user can't watch in their country unless they asked
  for everything.

## Saving

Offer to save picks the user likes with `save_title` (`status: planning`). For a
pick they never want to see, offer `hide_title`. Ask before each write and list
what you changed.
