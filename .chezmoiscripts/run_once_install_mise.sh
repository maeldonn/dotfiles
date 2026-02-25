#!/usr/bin/env bash
set -euo pipefail

MISE_BIN="$HOME/.local/bin/mise"

if [ -x "$MISE_BIN" ]; then
  echo "✅ mise already installed. No installation needed."
else
  echo "🚀 Installing mise..."
  curl -fsSL https://mise.run | sh
fi

echo "📦 Running mise install..."
"$MISE_BIN" install

echo "🎉 Done!"
