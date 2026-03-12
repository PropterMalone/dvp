# Tips & Tricks

Things that aren't obvious but make Claude Code much more useful.

## Talk to It Like a Person

Don't write "prompts." Just say what you want.

Bad: "Please generate a comprehensive analysis of NVIDIA Corporation (NVDA) including financial metrics, competitive positioning, and growth catalysts."

Good: "What's the bull case for NVDA right now?"

Claude works better with natural language. Be specific about what you want, but don't be formal about it.

## Tell Claude What You DON'T Want

Half the value of the memory system is teaching Claude your anti-preferences:

- "Don't give me technical analysis — I only care about fundamentals"
- "Stop including disclaimers about not being a financial advisor"
- "I don't need you to explain what P/E ratio means"

These stick across sessions once Claude saves them.

## Use Claude to Build Tools

This is the thing most people don't realize. Claude can create actual tools for you:

- "Build me a spreadsheet that tracks my portfolio positions with current prices"
- "Create a script that pulls earnings dates for my watchlist every Monday"
- "Make a comparison table of these five stocks on the metrics I care about"

Claude writes the files directly to your computer. No copy-paste needed.

## Work with Files

Claude can read files on your computer. Powerful for:

- **Earnings transcripts:** "Here's the NVDA Q4 transcript, summarize the key numbers"
- **Bank statements:** "Read my bank export and categorize the expenses"
- **Research notes:** "Read my notes folder and remind me what my COST thesis was"

Just tell Claude where the file is, or drop it in your project folder.

## Keyboard Shortcuts

| Key | What It Does |
|-----|-------------|
| `Ctrl+C` | Cancel current response / exit |
| `Up arrow` | Recall previous message |
| `Tab` | Autocomplete file paths |
| `Ctrl+L` | Clear screen |

## Session Patterns That Work Well

### Morning Research Check
```
/kickoff
"What's on the earnings calendar this week for my watchlist?"
"Any news on NVDA or COST since last session?"
/wrap
```

### Deep Dive
```
/kickoff
"I want to do a deep dive on Costco. Start with their last 10-K."
... back and forth analysis ...
"Save the key findings to my notes"
/wrap
```

### Household Sprint
```
cd ~/household
claude
/kickoff
"Update the budget with this month's actual expenses"
"What's coming up on the maintenance schedule?"
/wrap
```

## When Something Goes Wrong

**Claude seems confused:** Say "let's start over" or "forget what we were just doing."

**Claude is doing the wrong thing:** Just interrupt it. `Ctrl+C` to stop, then redirect.

**Claude is too verbose:** Tell it once: "Be more concise." It'll remember via `/wrap`.

**Something broke:** Close and reopen your terminal, type `claude` again. If it keeps happening, text Karl.

## Updating Your Setup

When Karl pushes updates to the config, run the setup command again:

**Windows (PowerShell):**
```
irm https://raw.githubusercontent.com/PropterMalone/dvp/main/setup.ps1 | iex
```

**Linux/Mac:**
```bash
cd ~/dvp && git pull && bash setup.sh
```

This updates styles and skills without touching your personal config or memory.
