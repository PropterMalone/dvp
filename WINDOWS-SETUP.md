# Windows Setup

One command. Takes about 5 minutes.

## Setup

1. Open **PowerShell** (press the Windows key, type "PowerShell", click it)
2. Paste this command and press Enter:
   ```
   irm https://raw.githubusercontent.com/PropterMalone/dvp/main/setup.ps1 | iex
   ```

The script installs Git, Claude Code, and your configuration automatically.

## Using Claude Code

1. Open **PowerShell**
2. Type `claude` and press Enter

That's it. Claude remembers your preferences and ongoing work between sessions.

## Updating

When Karl pushes updates to the config:

```
irm https://raw.githubusercontent.com/PropterMalone/dvp/main/setup.ps1 | iex
```

Same command. It pulls updates without overwriting your customizations.

## Troubleshooting

**"claude: command not found"**: Close PowerShell and open a new one, then try `claude` again.

**Script fails with a network error**: Check your internet connection and try again.

**Something else broke**: Close and reopen PowerShell, type `claude` again. If it keeps happening, text Karl.
