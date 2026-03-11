---
description: "Switch communication style — /style direct, /style karl, /style custom"
user_invocable: true
---

# Switch Communication Style

The user wants to change how Claude communicates. Available styles:

Built-in styles:
- **direct** — Concise, blunt, no fluff
- **karl** — Casual, sardonic, opinionated (based on Karl's writing voice)
- **custom** — User-defined (edit `~/.claude/styles/custom.md` to personalize)

Additional styles can be generated from any writing sample using `generate-style.sh`.

## Instructions

1. Read the argument to determine which style was requested
2. Check if `~/.claude/styles/{style}.md` exists. If not, list available styles from that directory.
3. Read the requested style file
4. Update `~/.claude/CLAUDE.md` — change the `@import` line under "Active Style" to point to the new style file
5. Confirm the switch and demonstrate the new voice briefly
