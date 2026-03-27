# ai-devex

Suite de IA para o dia a dia dos devs da Agilize — skills, agentes, MCPs e mais.

## O que tem aqui

| Pasta | O que é |
|---|---|
| `skills/` | Skills para Claude Code — contexto e comportamentos especializados |
| `agents/` | Agentes autônomos para tarefas específicas _(em breve)_ |
| `mcps/` | Servidores MCP para integrar ferramentas internas _(em breve)_ |

## Skills

### agilize-presentation

Gera apresentações HTML animadas no estilo visual da Agilize — cobre, slides de conteúdo, navegação por teclado/touch, blobs animados.

```bash
cp -r skills/agilize-presentation ~/.claude/skills/
```

## Como usar as skills

Skills ficam em `~/.claude/skills/`. Depois de copiar, o Claude Code as carrega automaticamente.

```bash
# Instalar uma skill
cp -r skills/<nome> ~/.claude/skills/

# Ou clonar o repo e linkar
git clone git@github.com:agilize/ai-devex.git
cp -r ai-devex/skills/<nome> ~/.claude/skills/
```
