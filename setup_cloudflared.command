#!/bin/bash
# Quality Tire Print — Cloudflare Tunnel One-Click Setup
# Double-click this file in Finder to run it.

echo "============================================"
echo "  Quality Tire Print — Cloudflare Setup"
echo "============================================"
echo ""

# ── Homebrew ─────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "Homebrew not found. Installing now..."
  echo "(This may take a few minutes and may ask for your password)"
  echo ""
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add brew to PATH for Apple Silicon Macs
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  echo "✓ Homebrew already installed"
fi

# ── cloudflared ───────────────────────────────────
if command -v cloudflared &>/dev/null; then
  CF_VER=$(cloudflared --version 2>&1 | head -1)
  echo "✓ cloudflared already installed: $CF_VER"
else
  echo "Installing cloudflared..."
  brew install cloudflare/cloudflare/cloudflared
  if [ $? -ne 0 ]; then
    echo ""
    echo "ERROR: cloudflared installation failed."
    echo "Try running manually: brew install cloudflare/cloudflare/cloudflared"
    read -p "Press Enter to close..."
    exit 1
  fi
  echo "✓ cloudflared installed: $(cloudflared --version 2>&1 | head -1)"
fi

echo ""
echo "============================================"
echo "  Setup complete!"
echo ""
echo "  Next step: Restart the print client."
echo "  It will start the Cloudflare tunnel"
echo "  automatically — no further action needed."
echo "============================================"
echo ""
read -p "Press Enter to close this window..."
