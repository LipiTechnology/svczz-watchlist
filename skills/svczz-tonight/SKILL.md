---
name: svczz-tonight
description: Pick one thing to watch tonight from the user's SVCZZ watch list, starting with what they're partway through and their Planned titles, fitted to the time they have, their mood and the services they pay for. Can pick at random from a shortlist (watch roulette). Use when the user asks what to watch tonight, what's next, "pick something for me", "spin the wheel", or can't decide. Needs the SVCZZ MCP server; the watch list needs the user's account connected.
---

# What to watch tonight

Help the user stop scrolling: one pick from their own SVCZZ watch list, two
backups, and where to watch each.

## Before you start

This skill needs the SVCZZ MCP server (`https://api.svczz.com/mcp`). If tools
such as `my_library` are not available, say so and point the user to the setup
steps at https://github.com/LipiTechnology/svczz-watchlist#readme.

If `my_library` asks the user to sign in, let them. If they would rather not,
fall back to `trending` and `discover` and say the picks are not from their
list.

Ask only for what you need and don't know: how much time they have, their mood,
and their country (two-letter code, such as `US` or `GB`) with the services they
have. One short question, not a form.

## Steps

1. `continue_watching` (limit 10). Something half-finished is often the right
   answer. Note the episode and how far in they are.
2. `my_library` with `status: planning`, `sort: added`. It returns 10 a page;
   read up to 5 pages. Add `type: movie` or `type: tv` if the user said.
3. Shortlist up to 8 titles that fit the time they have. For runtimes and
   genres you don't have, call `title_details` (`type`, `id`). A series fits if
   one episode fits.
4. `where_to_watch` for each shortlisted title in their country. Drop titles
   they can't stream on their services, unless they said they'd rent.
5. Pick:
   - Usually choose the best fit for the mood and time, and say why in one line.
   - If the user asks for roulette, a spin or a random pick, choose at random
     from the shortlist and say it was random. Offer one re-spin.

## What to write

- The pick: title, year, runtime (or episode length), why it fits tonight,
  where to watch it, and its SVCZZ link.
- Two backups, one line each.
- If the Planned list is empty, say so and offer picks from
  `recommend_for_me` instead.

This skill only reads. If the user says they'll watch the pick, offer to set it
to watching with `save_title` (`status: watching`). Ask first.
