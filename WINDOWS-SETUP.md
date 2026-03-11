# Windows Setup — Before the Script

Claude Code runs inside WSL (Windows Subsystem for Linux). This is a one-time setup that takes about 10 minutes.

## Step 1: Install WSL

1. Open **PowerShell** as Administrator
   - Press the Windows key, type "PowerShell", right-click "Windows PowerShell", choose "Run as administrator"
2. Paste this command and press Enter:
   ```
   wsl --install
   ```
3. **Restart your computer** when prompted

## Step 2: Set up Ubuntu

1. After restart, Ubuntu will open automatically (or search for "Ubuntu" in the Start menu)
2. It will ask you to create a username and password — this is just for WSL, pick something simple
3. Once you see a command prompt (something like `drew@laptop:~$`), you're in

## Step 3: Run the setup script

Still in that Ubuntu window, paste this and press Enter:

```bash
curl -fsSL https://raw.githubusercontent.com/PropterMalone/dvp/main/setup.sh | bash
```

The script installs everything else automatically. When it's done, it'll tell you how to start Claude Code.

## After Setup

To use Claude Code in the future:
1. Open **Ubuntu** from the Start menu
2. Type `claude` and press Enter

That's it. Claude remembers your preferences and ongoing work between sessions.

## Troubleshooting

**"WSL is not installed"**: Make sure you ran the install command as Administrator (Step 1).

**Ubuntu doesn't open after restart**: Search for "Ubuntu" in the Start menu. If it's not there, open PowerShell and run `wsl --install -d Ubuntu`.

**Script fails with a network error**: Check your internet connection and try running the curl command again.

**"claude: command not found"**: Close Ubuntu and reopen it, then try `claude` again.
