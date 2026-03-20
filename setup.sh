#!/usr/bin/env bash
# DVP Setup — Mac/Linux
# Usage: curl -fsSL https://raw.githubusercontent.com/PropterMalone/dvp/main/setup.sh | bash
set -euo pipefail

REPO_URL="https://github.com/PropterMalone/dvp.git"
DVP_DIR="$HOME/dvp"
CLAUDE_DIR="$HOME/.claude"
STEP=0
TOTAL_STEPS=4

# --- Helpers ---
show_step() {
    STEP=$((STEP + 1))
    echo ""
    echo "  [$STEP/$TOTAL_STEPS] $1"
}

show_ok() {
    echo "         ✓ $1"
}

show_warn() {
    echo "         ! $1"
}

echo ""
echo "  ========================================"
echo "  DVP Setup"
echo "  ========================================"
echo ""

# --- Step 1: Git (via Xcode CLI tools on macOS) ---
show_step "Git"
if command -v git &>/dev/null; then
    show_ok "Ready."
else
    if [[ "$(uname)" == "Darwin" ]]; then
        if xcode-select -p &>/dev/null; then
            show_warn "Xcode tools found but git not in PATH. Try closing and reopening Terminal."
            exit 1
        else
            echo "         Installing Xcode command line tools (includes Git)..."
            xcode-select --install 2>/dev/null || true
            echo ""
            echo "         !! ACTION NEEDED !!"
            echo "         -------------------------------------------------------"
            echo "         A dialog box appeared -- check BEHIND this window."
            echo "         It says 'Install Command Line Developer Tools'."
            echo "         Click 'Install' and wait for it to finish."
            echo "         -------------------------------------------------------"
            echo ""
            echo "         When it's done, run the setup command again."
            echo ""
            exit 0
        fi
    else
        show_warn "Git is not installed."
        show_warn "Install git using your package manager, then run this script again."
        exit 1
    fi
fi

# --- Step 2: Claude Code ---
show_step "Claude Code"
if command -v claude &>/dev/null; then
    show_ok "Ready."
else
    echo "         Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | sh

    # Add common install locations to PATH for this session
    export PATH="$HOME/.local/bin:$HOME/.claude/bin:/usr/local/bin:$PATH"

    if ! command -v claude &>/dev/null; then
        echo ""
        show_warn "Installation completed but 'claude' command not found."
        show_warn "Please close this terminal, open a new one, and run the setup command again."
        echo ""
        exit 1
    fi
    show_ok "Installed."
fi

# --- Step 3: DVP repo ---
show_step "Configuration files"
if [ -d "$DVP_DIR/.git" ]; then
    echo "         Checking for updates..."
    cd "$DVP_DIR" && git pull --ff-only >/dev/null 2>&1 || true
    show_ok "Up to date."
elif [ -d "$DVP_DIR" ]; then
    show_warn "Folder exists but is not a Git repo."
    show_warn "To get automatic updates, delete $DVP_DIR and run this script again."
else
    echo "         Downloading..."
    git clone "$REPO_URL" "$DVP_DIR" >/dev/null 2>&1
    if [ ! -d "$DVP_DIR" ]; then
        show_warn "Failed to download. Check your internet connection and try again."
        exit 1
    fi
    show_ok "Downloaded."
fi

# --- Step 4: Place config ---
show_step "Claude Code configuration"
mkdir -p "$CLAUDE_DIR/styles" "$CLAUDE_DIR/skills"

# CLAUDE.md — don't overwrite if customized
if [ ! -f "$CLAUDE_DIR/CLAUDE.md" ]; then
    cp "$DVP_DIR/claude/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
    show_ok "Installed CLAUDE.md"
else
    show_ok "CLAUDE.md already exists (keeping yours)"
fi

# Styles — always update (templates)
cp "$DVP_DIR/claude/styles/"*.md "$CLAUDE_DIR/styles/"
show_ok "Styles installed"

# Skills — always update
cp "$DVP_DIR/claude/skills/"*.md "$CLAUDE_DIR/skills/"
show_ok "Skills installed"

# .env.example
if [ ! -f "$HOME/.env.example" ]; then
    cat > "$HOME/.env.example" << 'EOF'
# API keys for stock data, brokerage, etc.
# Copy this file to .env and fill in your values.
# Never commit .env to git — it contains secrets.

# ALPHA_VANTAGE_API_KEY=
# POLYGON_API_KEY=
# FINNHUB_API_KEY=
EOF
    show_ok "Created .env.example"
fi

# --- Done ---
echo ""
echo "  ========================================"
echo "  Setup complete!"
echo "  ========================================"
echo ""
echo "  Type 'claude' to start Claude Code."
echo ""
echo "  First time? Claude will ask you to log in"
echo "  via your browser. After that, just talk to it."
echo ""
echo "  Try: /kickoff.md"
echo ""
