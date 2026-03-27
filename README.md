# ai-devex

AI suite for Agilize devs — skills, agents, MCPs, and more.

## What's here

| Folder | Description |
|---|---|
| `skills/` | Claude Code skills — specialized context and behaviors |
| `agents/` | Autonomous agents for specific tasks _(coming soon)_ |
| `mcps/` | MCP servers to integrate internal tools _(coming soon)_ |

## Skills

### agilize-presentation

Generates animated HTML presentations in Agilize's visual style — cover slides, content slides, keyboard/touch navigation, animated blob backgrounds.

```bash
cp -r skills/agilize-presentation ~/.claude/skills/
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
