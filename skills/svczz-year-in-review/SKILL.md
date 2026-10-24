---
name: svczz-year-in-review
description: Write the user's year in movies and series from SVCZZ, with hours watched, titles and episodes, streak, top genres, best-rated titles and a few honest observations, compared with the year before. Use when the user asks for their year in review, wrapped, how much they watched this year, their stats or their favourites of the year. Needs the SVCZZ MCP server with the user's account connected.
---

# Year in review

Turn the user's SVCZZ numbers into a short, readable review of their year.

## Before you start

This skill needs the SVCZZ MCP server (`https://api.svczz.com/mcp`) and the
user's account. If tools such as `my_stats` are not available, say so and point
the user to https://github.com/LipiTechnology/svczz-watchlist#readme. Do not
guess numbers.

The year is the one the user names, or the current year.

## Steps

1. `my_stats` with `year`: hours, titles, movies, series, episodes, current
   streak and top genres. On Premium, `advanced` is true and top people and top
   titles are filled in. On the free plan they are empty; don't invent them.
2. `my_stats` with `year` minus one, for the comparison. Skip the comparison if
   that year is all zeros.
3. `my_library` with `status: watched`, `sort: rating`: their best-rated titles
   (first 2 pages). Keep the ones they finished in the year when you can tell;
   otherwise say these are their highest-rated overall.
4. `get_profile` for their name and plan.

## What to write

- A headline number: hours watched, and what that is in days.
- Titles, movies, series and episodes, with the change from last year.
- Top genres, and top people and titles if the plan has them.
- Their 5 best-rated titles with links.
- Two or three observations drawn from the numbers ("more series than movies
  for the first time"). No made-up trivia.

Keep it to one screen. This skill only reads. SVCZZ also has a shareable year
page on the site; mention it if the user wants to share.
