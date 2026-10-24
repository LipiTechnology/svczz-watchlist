---
name: svczz-movie-night
description: Plan a movie night for a group with SVCZZ. Builds a shortlist of five that fits everyone's taste, the time and the services the group has in their country, and saves it as a list to vote on. Use when the user is planning a movie night, a watch party or a date night, or asks what a group should watch together. Needs the SVCZZ MCP server; saving the list needs the user's account and the Change your library permission.
---

# Movie night

Find five movies a group can agree on and can actually stream tonight.

## Before you start

This skill needs the SVCZZ MCP server (`https://api.svczz.com/mcp`). If tools
such as `discover` are not available, say so and point the user to
https://github.com/LipiTechnology/svczz-watchlist#readme.

Ask in one message for what you don't know: how many people, the mood or
genres people like or veto, how long you have, the country (two-letter code)
and which services the group has.

## Steps

1. `discover` with a `query` in the group's words and the filters you have:
   `type: movie`, `genre`, `year_from`/`year_to`, `min_rating`, and `provider`
   with `region` for the main service. Run it once per service if they have
   several. Use `limit: 20`.
2. If the user's account is connected, `recommend_for_me` (`type: movie`) and
   `my_library` (`status: planning`, `type: movie`) add titles the user already
   wants to see. Keep the ones that fit the group.
3. `title_details` for runtimes. Drop anything longer than the time they have.
4. `where_to_watch` in their country for each finalist. Leave out what the group
   can't stream.

## What to write

Five movies, each with year, runtime, one line on why it works for this group,
where to stream it, and its SVCZZ link. Say which one you'd pick if they can't
decide.

## Saving the shortlist

Offer to save the five as a list. Check `my_lists` first: the free plan allows
3 lists, so suggest reusing an existing list if they are at the limit. Then
`create_list` (a name such as "Movie night, 24 Oct") and `add_to_list` for each
title. Ask before creating anything, and share the list link at the end.
