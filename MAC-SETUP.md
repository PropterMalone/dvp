# Mac Setup

One command. Takes about 5 minutes.

## Setup

1. Open **Terminal** (press Cmd+Space, type "Terminal", press Enter)
2. Paste this command and press Enter:
   ```
   curl -fsSL https://raw.githubusercontent.com/PropterMalone/dvp/main/setup.sh | bash
   ```

The script installs Git (via Xcode tools), Claude Code, and your configuration automatically.

**Note:** macOS may show a popup asking to install developer tools. Click **Install** and wait for it to finish, then run the command above again.

## Using Claude Code

1. Open **Terminal**
2. Type `claude` and press Enter

That's it. Claude remembers your preferences and ongoing work between sessions.

## Updating

When Karl pushes updates to the config:

```
curl -fsSL https://raw.githubusercontent.com/PropterMalone/dvp/main/setup.sh | bash
```

Same command. It pulls updates without overwriting your customizations.

## Troubleshooting

**"claude: command not found"**: Close Terminal and open a new one, then try `claude` again.

**Xcode tools popup doesn't appear**: Run `xcode-select --install` manually, then try the setup command again.

**Something else broke**: Close and reopen Terminal, try again. If it keeps happening, text Karl.
