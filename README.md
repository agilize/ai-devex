# ai-devex

AI suite for Agilize devs — skills, agents, MCPs, and more.

## What's here

| Folder | Description |
|---|---|
| `skills/` | Claude Code skills — specialized context and behaviors |
| `scripts/` | Shell scripts for Claude Code configuration (status line, hooks, etc.) |
| `agents/` | Autonomous agents for specific tasks _(coming soon)_ |
| `mcps/` | MCP servers to integrate internal tools _(coming soon)_ |

## Skills

### slide-presentations

Generates branded HTML slide presentations with a custom engine (CSS/JS inline). Accepts natural language or explicit flags. Can create from scratch or redesign an existing PDF/PPTX. Themes define colors, typography, layouts, and slide patterns.

**Themes** define the full visual identity (colors, typography, slide layouts, decorative elements). Available themes:

| Theme | Style |
|---|---|
| `agilize` | Purple-centric, Quicksand typography, animated blob covers |

```bash
cp -r skills/slide-presentations ~/.claude/skills/
```

## Scripts

### statusline.sh

A compact status line for Claude Code showing: working directory, git branch + dirty state, active model, context window usage (color-coded bar), rate limits, and session duration.

```
ai-devex (feat/my-branch)* | Sonnet | ctx [████████░░] 78% | 5h:12% 7d:34% | 42m
```

**Install:**

```bash
cp scripts/statusline.sh ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh
```

**Register in `~/.claude/settings.json`:**

```json
{
  "statusline": {
    "command": "~/.claude/statusline.sh"
  }
}
```

Or use the built-in agent: type `/statusline-setup` inside Claude Code and it will configure `settings.json` for you.

**Requirements:** `jq`, `git`, `stat` (standard on Linux/macOS).

---

## How to use skills

Skills live in `~/.claude/skills/`. Once copied, Claude Code loads them automatically.

```bash
# Install a skill
cp -r skills/<name> ~/.claude/skills/

# Or clone the repo and copy
git clone git@github.com:agilize/ai-devex.git
cp -r ai-devex/skills/<name> ~/.claude/skills/
```
