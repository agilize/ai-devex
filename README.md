# ai-devex

AI suite for Agilize devs — skills, agents, MCPs, and more.

## What's here

| Folder | Description |
|---|---|
| `skills/` | Claude Code skills — specialized context and behaviors |
| `agents/` | Autonomous agents for specific tasks _(coming soon)_ |
| `mcps/` | MCP servers to integrate internal tools _(coming soon)_ |

## Skills

### slide-presentations

Generates animated HTML slide presentations with theme support — cover slides, content slides, keyboard/touch navigation, slide preview thumbnails, and a theme-driven design system.

**Themes** define the visual identity (colors, typography, cover style). Available themes:

| Theme | Style |
|---|---|
| `agilize` | Purple-centric, Quicksand typography, animated blob covers |

```bash
cp -r skills/slide-presentations ~/.claude/skills/
```

## How to use skills

Skills live in `~/.claude/skills/`. Once copied, Claude Code loads them automatically.

```bash
# Install a skill
cp -r skills/<name> ~/.claude/skills/

# Or clone the repo and copy
git clone git@github.com:agilize/ai-devex.git
cp -r ai-devex/skills/<name> ~/.claude/skills/
```
