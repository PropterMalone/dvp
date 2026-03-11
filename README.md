# DVP

Claude Code setup for Drew. Persistent memory, switchable communication styles, session management.

## Quick Start

See [WINDOWS-SETUP.md](WINDOWS-SETUP.md) for full instructions.

## What's Included

- **CLAUDE.md** — Persistent instructions that Claude follows every session
- **Styles** — Three communication modes, switchable with `/style`:
  - `direct` — Concise and blunt
  - `karl` — Karl's voice (casual, sardonic, opinionated)
  - `custom` — Define your own
- **Skills** — Slash commands:
  - `/kickoff` — Start a session (Claude checks what it remembers)
  - `/wrap` — End a session (Claude saves what it learned)
  - `/style [name]` — Switch communication style
- **Memory** — Claude remembers your preferences, research threads, and ongoing work across sessions
- **.env pattern** — Safe handling of API keys for market data services
- **Style generator** — Create new styles from any writing sample:
  ```bash
  ./generate-style.sh shelby ~/texts/sample1.txt ~/texts/sample2.txt
  ```

## Docs

- [Getting Started](docs/getting-started.md) — first session, basic usage, how it differs from ChatGPT
- [Projects](docs/projects.md) — organizing your work into folders with per-project context
- [Memory](docs/memory.md) — how Claude remembers you across sessions
- [API Keys](docs/api-keys.md) — connecting to stock data services (Alpha Vantage, Finnhub, etc.)
- [Tips & Tricks](docs/tips.md) — power-user patterns, keyboard shortcuts, session workflows

## Updating

The setup script is idempotent. To get updates:

```bash
cd ~/dvp && git pull
bash setup.sh
```

This updates styles and skills but won't overwrite your customized CLAUDE.md.
