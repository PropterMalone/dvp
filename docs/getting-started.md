# Getting Started with Claude Code

You've installed Claude Code. Here's how to actually use it.

## The Basics

Open your terminal (PowerShell on Windows, Terminal on Mac) and type `claude`. That's it — you're in.

Claude Code is a conversation in your terminal. You type, Claude responds. It can also read and create files on your computer, which is the big difference from ChatGPT.

### Your First Session

Try typing `/kickoff`. Claude will introduce itself and ask what you want to work on.

When you're done, type `/wrap`. Claude saves what it learned about you so it remembers next time.

### How It's Different from ChatGPT

| ChatGPT | Claude Code |
|---------|-------------|
| Runs in a browser | Runs in your terminal |
| Forgets you between conversations | Remembers your preferences and context |
| You copy-paste everything | Claude reads and creates files directly |
| One-size-fits-all personality | Customizable communication style |
| Conversations are isolated | Sessions build on each other |

## Talking to Claude

Just type naturally. Some examples:

- "What's the current P/E ratio environment for semiconductor stocks?"
- "Help me compare NVDA and AMD on revenue growth, margins, and valuation"
- "Make me a spreadsheet tracking our monthly household expenses"
- "Summarize this earnings call" (if you have the transcript as a file)

### Being Specific Gets Better Results

| Vague | Specific |
|-------|----------|
| "Research NVDA" | "Research NVDA focusing on data center revenue growth vs. capex commitments over the last 4 quarters" |
| "Help with my portfolio" | "I hold NVDA, MSFT, and COST. What's my sector concentration risk?" |
| "Make a budget" | "Make a monthly budget spreadsheet with categories for mortgage, groceries, kids activities, and utilities" |

### Correcting Course

If Claude heads the wrong direction, just say so:

- "No, not that — I meant..."
- "Wrong approach. Try..."
- "Stop. Let's back up."

Claude doesn't have feelings. Be direct.

## Slash Commands

These are shortcuts that trigger specific behaviors:

| Command | What It Does |
|---------|-------------|
| `/kickoff` | Start a session — Claude checks its memory and asks your agenda |
| `/wrap` | End a session — Claude saves what it learned |
| `/style direct` | Switch to concise, blunt communication |
| `/style karl` | Switch to Karl's voice (casual, sardonic) |
| `/style custom` | Switch to your own defined style |

## Exiting

- Type `/exit` or press `Ctrl+C` to leave Claude Code
- To come back later: open your terminal, type `claude`

## Next Steps

- [Projects](projects.md) — how to organize your work
- [Memory](memory.md) — how Claude remembers things about you
- [API Keys](api-keys.md) — connecting to stock data services
- [Tips](tips.md) — power-user tricks
