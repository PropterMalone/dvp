#!/usr/bin/env bash
# DVP Setup — installs Node.js, Claude Code, and places config files.
# Run inside WSL (Ubuntu).
set -euo pipefail

REPO_URL="https://github.com/PropterMalone/dvp.git"
DVP_DIR="$HOME/dvp"
CLAUDE_DIR="$HOME/.claude"
STEP=0
TOTAL_STEPS=5

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

# --- Step 1: Node.js ---
show_step "Node.js"
if command -v node &>/dev/null; then
    show_ok "Ready ($(node --version))."
else
    echo "         Installing..."
    # Use NodeSource for current LTS
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - >/dev/null 2>&1
    sudo apt-get install -y nodejs >/dev/null 2>&1
    if ! command -v node &>/dev/null; then
        show_warn "Could not install Node.js automatically."
        show_warn "Please install from https://nodejs.org/ and run this script again."
        exit 1
    fi
    show_ok "Installed ($(node --version))."
fi

# --- Step 2: Git ---
show_step "Git"
if command -v git &>/dev/null; then
    show_ok "Ready."
else
    echo "         Installing..."
    sudo apt-get update -qq >/dev/null 2>&1
    sudo apt-get install -y git >/dev/null 2>&1
    if ! command -v git &>/dev/null; then
        show_warn "Could not install Git."
        exit 1
    fi
    show_ok "Installed."
fi

# --- Step 3: Claude Code ---
show_step "Claude Code"
if command -v claude &>/dev/null; then
    show_ok "Ready."
else
    echo "         Installing..."
    npm install -g @anthropic-ai/claude-code >/dev/null 2>&1
    if ! command -v claude &>/dev/null; then
        show_warn "Could not install Claude Code."
        show_warn "Try: npm install -g @anthropic-ai/claude-code"
        exit 1
    fi
    show_ok "Installed."
fi

# --- Step 4: DVP repo ---
show_step "Configuration files"
if [ -d "$DVP_DIR/.git" ]; then
    echo "         Checking for updates..."
    cd "$DVP_DIR" && git pull --ff-only >/dev/null 2>&1 || true
    show_ok "Up to date."
else
    echo "         Downloading..."
    git clone "$REPO_URL" "$DVP_DIR" >/dev/null 2>&1
    if [ ! -d "$DVP_DIR" ]; then
        show_warn "Failed to download. Check your internet connection and try again."
        exit 1
    fi
    show_ok "Downloaded."
fi

# --- Step 5: Place config ---
show_step "Claude Code configuration"
mkdir -p "$CLAUDE_DIR/styles" "$CLAUDE_DIR/skills"

# Copy config files, but don't overwrite if they already exist (user may have customized)
for f in CLAUDE.md; do
    if [ ! -f "$CLAUDE_DIR/$f" ]; then
        cp "$DVP_DIR/claude/$f" "$CLAUDE_DIR/$f"
        show_ok "Installed $f"
    else
        show_ok "$f already exists (keeping yours)"
    fi
done

# Styles — always update (these are templates)
cp "$DVP_DIR/claude/styles/"*.md "$CLAUDE_DIR/styles/"
show_ok "Styles installed"

# Skills — always update
cp "$DVP_DIR/claude/skills/"*.md "$CLAUDE_DIR/skills/"
show_ok "Skills installed"

# Create .env.example if it doesn't exist
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
echo "  Try: /kickoff"
echo ""
