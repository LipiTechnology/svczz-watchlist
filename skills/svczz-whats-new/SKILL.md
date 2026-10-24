---
name: svczz-whats-new
description: A short weekly briefing from SVCZZ with new episodes and releases of what the user follows, unread notifications, what friends have been watching, and what's newly streaming or coming soon. Use when the user asks what's new, what's coming this week, what they've missed, or for a weekly watch update. Needs the SVCZZ MCP server; the personal parts need the user's account connected.
---

# What's new this week

One short briefing: what's new for the user, what friends are into, and what's
new for everyone.

## Before you start

This skill needs the SVCZZ MCP server (`https://api.svczz.com/mcp`). If tools
such as `my_calendar` are not available, say so and point the user to
https://github.com/LipiTechnology/svczz-watchlist#readme.

Without a connected account, skip steps 1 to 3 and say the briefing covers
everyone's releases only.

## Steps

1. `my_calendar` with `from` today and `to` 7 days later (`YYYY-MM-DD`): new
   episodes and releases of titles they follow.
2. `my_notifications` with `unread_only: true`. Reading them doesn't mark them
   read; don't claim you did.
3. `friends_activity`: the first page. Only friends who share their activity
   appear.
4. `calendar_upcoming` with `what: now_streaming`, then `what: movies` for what's
   coming soon.
5. Optionally `trending` with `window: week`.

## What to write

Four short parts, skipping any that are empty:

- **For you this week:** day by day, title and episode, with links.
- **Notifications:** a count and the few that matter.
- **Friends:** who finished or rated what, in a line each.
- **New and coming:** 3 to 5 titles worth knowing about.

This skill only reads.
