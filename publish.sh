#!/bin/bash
# Publish daily newsletters to GitHub Pages
set -e

DATE=$(date +%Y-%m-%d)
REPO_DIR="/Users/bhclbot77/.openclaw/workspace/newsletters-public"

cd "$REPO_DIR"

# Copy AI briefing
if [ -f "/Users/bhclbot77/Obsidian Vault/cilla/AI Reports/$DATE.md" ]; then
    cp "/Users/bhclbot77/Obsidian Vault/cilla/AI Reports/$DATE.md" "ai/$DATE.md"
    cp "/Users/bhclbot77/Obsidian Vault/cilla/AI Reports/$DATE.md" "ai-briefing-latest.md"
    echo "✅ AI briefing published: $DATE"
else
    echo "⚠️  No AI briefing found for $DATE"
fi

# Copy DEX briefing (if exists)
if [ -f "/tmp/dex-briefing.md" ]; then
    cp "/tmp/dex-briefing.md" "dex/$DATE.md"
    cp "/tmp/dex-briefing.md" "dex-briefing-latest.md"
    echo "✅ DEX briefing published: $DATE"
else
    echo "⚠️  No DEX briefing found for $DATE"
fi

# Git operations
git add .
git commit -m "Daily briefing: $DATE" || echo "No changes to commit"
git push origin main

echo "🚀 Published to GitHub Pages"
