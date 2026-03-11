# Memory

Claude Code has a persistent memory system. It remembers things about you, your preferences, and your ongoing work across sessions.

## How It Works

Memory is stored in files on your computer (in `~/.claude/`). Claude reads them at the start of each session and updates them when you `/wrap`.

This means:
- Memory survives between sessions
- Memory is yours — it's just files on your machine
- You can read, edit, or delete memory files yourself
- Nothing is sent to Anthropic's servers beyond the normal conversation

## Saving Things to Memory

### Explicitly

Just tell Claude to remember something:

- "Remember that I prefer DCF analysis over comparables"
- "Save this for later: my broker account is at Schwab"
- "Remember that our mortgage payment is $2,400/month"

### Automatically

When you `/wrap`, Claude reviews the session and saves anything it thinks will be useful next time:

- Your research interests and ongoing threads
- Preferences it noticed (formatting, analysis style, etc.)
- Unfinished work to pick up later

## Recalling Memory

- "What do you remember about my NVDA research?"
- "Check your memory for our household budget"
- "What were we working on last time?"

Or just use `/kickoff` — Claude checks its memory and gives you a summary.

## What Gets Remembered

**Good things to save:**
- Your investment thesis on specific stocks
- Portfolio holdings and watchlist
- Analysis preferences (DCF vs. comparables, metrics you care about)
- Household details (budget categories, schedules, kids' activities)
- Ongoing projects and their status

**Things Claude won't save:**
- Passwords or sensitive financial details (don't ask it to)
- Temporary stuff that won't matter next session

## Editing Memory Yourself

Memory files are in `~/.claude/`. You can look at them:

```bash
ls ~/.claude/
```

They're plain markdown files. You can open and edit them with any text editor, or just tell Claude:

- "Delete whatever you remember about XYZ"
- "Update my memory: I sold my NVDA position"

## Privacy

All memory stays on your computer. It's not synced anywhere, not backed up to the cloud, and not visible to anyone but you (and Claude, when you start a session).

If you want to start fresh: `rm -rf ~/.claude/memory/` and Claude forgets everything.
