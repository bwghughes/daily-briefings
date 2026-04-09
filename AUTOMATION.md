# Newsletter Automation

This repository automatically publishes daily AI and DEX briefings to GitHub Pages.

## How it Works

### Daily Schedule (05:00 GMT+1)

1. **Newsletter Generation** (OpenClaw cron jobs)
   - AI briefing: searches web for latest AI news, research, developments
   - DEX briefing: searches for DEX market updates from major vendors

2. **Save to Obsidian**
   - AI: `/Users/bhclbot77/Obsidian Vault/cilla/AI Reports/YYYY-MM-DD.md`
   - DEX: `/tmp/dex-briefing.md`

3. **Publish to GitHub Pages** (immediately after creation)
   - Copies markdown to this repo
   - Git commit + push
   - Published at: https://bwghughes.github.io/daily-briefings/

4. **Email Distribution**
   - AI briefing: 9 recipients
   - DEX briefing: 2 recipients
   - Formatted HTML emails via Gmail

5. **Telegram Notification**
   - Both briefings sent to Ben's Telegram

## Repository Structure

```
.
├── README.md              # Landing page
├── index.md               # Main navigation
├── ai-briefing-latest.md  # Latest AI briefing
├── dex-briefing-latest.md # Latest DEX briefing
├── ai/                    # AI archive (YYYY-MM-DD.md)
├── dex/                   # DEX archive (YYYY-MM-DD.md)
└── publish.sh             # Automation script
```

## Manual Publishing

If needed, run manually:

```bash
cd /Users/bhclbot77/.openclaw/workspace/newsletters-public
./publish.sh
```

This will:
1. Copy latest AI briefing from Obsidian
2. Copy latest DEX briefing from /tmp
3. Update `-latest.md` files
4. Git commit + push

## URLs

- **Live site:** https://bwghughes.github.io/daily-briefings/
- **Repository:** https://github.com/bwghughes/daily-briefings
- **Latest AI:** https://bwghughes.github.io/daily-briefings/ai-briefing-latest.md
- **Latest DEX:** https://bwghughes.github.io/daily-briefings/dex-briefing-latest.md

## Email Recipients

### AI Briefing
- bhclbot77@gmail.com
- myai@apple.com
- ekelly22@apple.com
- emerkelly86@gmail.com
- h0th@mac.com
- a.danielaalves@gmail.com
- lobo@me.com
- jonahk@apple.com
- drosos@me.com

### DEX Briefing
- bhclbot77@gmail.com
- dex@apple.com
