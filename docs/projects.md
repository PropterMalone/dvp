# Projects

Projects are just folders. Claude Code is aware of which folder you're in, and that changes what it knows and how it behaves.

## Why Projects Matter

When you're in a specific folder, Claude automatically reads any `CLAUDE.md` file in that folder. That file tells Claude what the project is about, what conventions to follow, and what to remember.

Your global `CLAUDE.md` (in `~/.claude/`) always applies. Project-level ones add to it.

## Starting a New Project

Say you want to start tracking stock research. Here's what that looks like:

```
mkdir ~/stock-research
cd ~/stock-research
claude
```

Then tell Claude:

> "I'm going to use this folder for stock research. Create a CLAUDE.md for this project."

Claude will create a file that might look like:

```markdown
# Stock Research

Notes, analysis, and tracking for personal portfolio research.

## What's Here
- Analysis notes in markdown
- Watchlist and position tracking
- Earnings call summaries

## Preferences
- DCF over comparables for valuation
- Focus on free cash flow, not earnings
- Always note the date of any data
```

Next time you `cd ~/stock-research && claude`, Claude will read that file and already know the context.

## Example Project Ideas

### Stock Research
```
~/stock-research/
├── CLAUDE.md           # project context
├── .env                # API keys (never shared)
├── .env.example        # reminder of what keys you need
├── watchlist.md        # stocks you're tracking
├── positions.md        # current holdings
└── notes/
    ├── nvda-q4-2025.md
    └── cost-thesis.md
```

### Household Management
```
~/household/
├── CLAUDE.md
├── budget.md
├── maintenance-schedule.md
├── meal-planning.md
└── kids/
    ├── school-calendar.md
    └── activities.md
```

### General Notes / Second Brain
```
~/notes/
├── CLAUDE.md
├── books/
├── ideas/
└── reference/
```

## Switching Between Projects

```bash
cd ~/stock-research
claude
# ... do stock stuff, /wrap when done ...

cd ~/household
claude
# ... different context, different CLAUDE.md ...
```

Each project has its own memory and its own `CLAUDE.md`. Claude shifts gears automatically.

## Creating a Project with Claude's Help

You don't have to set up the folder structure yourself. Just tell Claude what you want:

> "Set up a new project folder for tracking our household budget and expenses. Create the CLAUDE.md and any starter files."

Claude will create the folder, write the files, and explain what it made.

## Keeping Projects Updated

When your project evolves — you change your research approach, add a new focus area, whatever — tell Claude:

> "Update the CLAUDE.md to reflect that I'm now also tracking options positions"

Or just edit the file yourself. It's plain text.
