# Newsletter Verification

**Rule:** Every single report must be saved in BOTH Obsidian AND GitHub.

## ✅ Current Configuration Status

### 1. AI Morning Briefing
- **Obsidian Path:** `/Users/bhclbot77/Obsidian Vault/cilla/AI Reports/YYYY-MM-DD.md`
- **GitHub Path:** `ai/YYYY-MM-DD.md`
- **Status:** ✅ Configured
- **Workflow:**
  1. Generate report
  2. Save to Obsidian (step 1 in task)
  3. Run `publish.sh` (copies from Obsidian to GitHub)
  4. Email distribution

### 2. DEX Market Briefing
- **Obsidian Path:** `/Users/bhclbot77/Obsidian Vault/cilla/DEX Reports/YYYY-MM-DD.md`
- **GitHub Path:** `dex/YYYY-MM-DD.md`
- **Status:** ✅ Configured
- **Workflow:**
  1. Generate report
  2. Save to `/tmp/dex-briefing.md`
  3. Save to Obsidian (step 2 in task)
  4. Run `publish.sh` (copies from Obsidian OR /tmp to GitHub)
  5. Email distribution

### 3. EXO Labs Briefing
- **Obsidian Path:** `/Users/bhclbot77/Obsidian Vault/cilla/EXO Reports/YYYY-MM-DD.md`
- **GitHub Path:** `exo/YYYY-MM-DD.md`
- **Status:** ✅ Configured
- **Workflow:**
  1. Generate report
  2. Save to `/tmp/exo-briefing.md`
  3. Save to Obsidian (step 2 in task)
  4. Run `publish.sh` (copies from Obsidian OR /tmp to GitHub)
  5. Email distribution

## Verification Commands

```bash
# Check Obsidian
ls -1 "/Users/bhclbot77/Obsidian Vault/cilla/AI Reports/"
ls -1 "/Users/bhclbot77/Obsidian Vault/cilla/DEX Reports/"
ls -1 "/Users/bhclbot77/Obsidian Vault/cilla/EXO Reports/"

# Check GitHub repo
cd ~/.openclaw/workspace/newsletters-public
ls -1 ai/
ls -1 dex/
ls -1 exo/

# Verify sync
diff -r "/Users/bhclbot77/Obsidian Vault/cilla/AI Reports/" ai/
diff -r "/Users/bhclbot77/Obsidian Vault/cilla/DEX Reports/" dex/
diff -r "/Users/bhclbot77/Obsidian Vault/cilla/EXO Reports/" exo/
```

## Automatic Daily Process (05:00 GMT+1)

For each newsletter:

1. ✅ Agent generates report
2. ✅ Saves to Obsidian (AI Reports, DEX Reports, or EXO Reports)
3. ✅ Saves to `/tmp/` (DEX and EXO only)
4. ✅ Runs `publish.sh`:
   - Copies from Obsidian to GitHub repo
   - Git commit + push
5. ✅ Converts to HTML
6. ✅ Emails to distribution list
7. ✅ Sends to Telegram

## Manual Verification Script

```bash
#!/bin/bash
# Run this to verify all newsletters are properly mirrored

DATE=$(date +%Y-%m-%d)

echo "Checking newsletters for $DATE..."
echo ""

# AI
if [ -f "/Users/bhclbot77/Obsidian Vault/cilla/AI Reports/$DATE.md" ]; then
    echo "✅ AI Report in Obsidian"
else
    echo "❌ AI Report missing from Obsidian"
fi

if [ -f "$HOME/.openclaw/workspace/newsletters-public/ai/$DATE.md" ]; then
    echo "✅ AI Report in GitHub"
else
    echo "❌ AI Report missing from GitHub"
fi

echo ""

# DEX
if [ -f "/Users/bhclbot77/Obsidian Vault/cilla/DEX Reports/$DATE.md" ]; then
    echo "✅ DEX Report in Obsidian"
else
    echo "❌ DEX Report missing from Obsidian"
fi

if [ -f "$HOME/.openclaw/workspace/newsletters-public/dex/$DATE.md" ]; then
    echo "✅ DEX Report in GitHub"
else
    echo "❌ DEX Report missing from GitHub"
fi

echo ""

# EXO
if [ -f "/Users/bhclbot77/Obsidian Vault/cilla/EXO Reports/$DATE.md" ]; then
    echo "✅ EXO Report in Obsidian"
else
    echo "❌ EXO Report missing from Obsidian"
fi

if [ -f "$HOME/.openclaw/workspace/newsletters-public/exo/$DATE.md" ]; then
    echo "✅ EXO Report in GitHub"
else
    echo "❌ EXO Report missing from GitHub"
fi
```

## Troubleshooting

If a report is missing from Obsidian or GitHub:

1. Check if the cron job ran: `openclaw cron runs <job-id>`
2. Check Obsidian folder exists: `ls -la "/Users/bhclbot77/Obsidian Vault/cilla/"`
3. Check GitHub repo: `cd ~/.openclaw/workspace/newsletters-public && git log --oneline | head -5`
4. Manually run publish: `cd ~/.openclaw/workspace/newsletters-public && ./publish.sh`

## Last Updated

2026-04-09 08:11 GMT+1
