# Drew's Claude Code Setup

> Personal defaults. Edit freely — this is yours.

## Active Style

<!-- Change this line to switch communication styles. Options: direct, karl, custom -->
@import styles/direct.md

## What Claude Knows About You

- Stock research and market analysis
- Family/household management
- Coming from OpenAI, new to Claude Code and the command line

Update this section as you go — the more context Claude has, the better it works.

## Environment

- **Machine**: Windows (via WSL)
- **Never commit**: `.env` files (API keys, secrets)
- **Always maintain**: `.env.example` (so you remember what keys you need)

## Memory

Claude has a persistent memory system. It remembers things across conversations.

- To save something: just say "remember that I..." or "save this for later"
- To recall: "what do you remember about..." or "check your memory for..."
- Memory lives in `~/.claude/` and persists between sessions

## Session Flow

- Start a session with `/kickoff` — Claude orients from memory and asks what you want to work on
- End a session with `/wrap` — Claude saves what it learned and notes anything unfinished

## Tips

- Be specific about what you want. "Research NVDA" is fine. "Research NVDA focusing on their data center revenue trend vs. capex commitments" is better.
- If Claude is heading the wrong direction, just say so. "No, not that" or "wrong approach" works.
- You can ask Claude to remember your preferences: "remember that I prefer DCF analysis over comparables"
- For API keys (brokerage, market data, etc.), put them in a `.env` file. Claude will read them but never commit them to git.
