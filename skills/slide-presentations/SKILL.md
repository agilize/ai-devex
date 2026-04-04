---
name: slide-presentations
description: Generate branded HTML slide presentations with a custom engine. Accepts natural language or explicit flags. Can create from scratch or redesign an existing PDF/PPTX. Themes define colors, typography, layouts, and slide patterns. Interactive theme selection when not specified.
disable-model-invocation: true
argument-hint: <natural language description or flags>
---

# /slide-presentations — Branded Slide Generator

> Gera apresentações HTML completas com motor custom (CSS/JS inline) e temas visuais de marca.
> Aceita linguagem natural ou flags explícitas. Cria do zero ou redesenha uma existente.
> Output: arquivo HTML standalone pronto para apresentar — sem dependências externas além de fontes CDN.

---

## Exemplos de uso

```bash
# Linguagem natural
/slide-presentations crie uma apresentação sobre OKRs com o tema agilize
/slide-presentations redesenhe a apresentação ~/Downloads/palestra.pdf usando agilize
/slide-presentations refaça ~/Desktop/aula.pptx com 10 slides no tema agilize

# Flags explícitas
/slide-presentations topic="OKRs Q2 2026" theme=agilize slides=12
/slide-presentations from=~/Downloads/palestra.pdf theme=agilize
/slide-presentations outline=OUTLINE.md theme=agilize lang=en

# Misto
/slide-presentations from=palestra.pdf crie com tema agilize e 10 slides
```

---

## Fase 0 — Interpretar intenção do usuário

> **Emitir:** `▶ [0/6] Interpretando solicitação`

### 0.1 — Parser dual (flags + linguagem natural)

Tentar resolver por **flags** primeiro (instantâneo):

```
Flags reconhecidas:
  from=<path>           Arquivo fonte (PDF, PPTX, PPT) para redesenhar
  outline=<path>        Outline estruturado em markdown
  topic="<texto>"       Tópico para criar do zero
  theme=<nome>          Nome do tema visual
  slides=<N>            Número aproximado de slides (default: 12-15)
  lang=<pt|en|es>       Idioma do conteúdo (default: pt-BR)
```

Se flags não cobrem tudo, **interpretar o texto livre** para extrair:

```
Do texto do usuário, identificar:
  ┌─────────────┬──────────────────────────────────────────────────┐
  │ Ação        │ "crie/cria/nova/novo" → CRIAR DO ZERO            │
  │             │ "redesenhe/refaça/refazer/transforme" → REDESIGN  │
  │             │ nenhum verbo claro → CRIAR DO ZERO (default)      │
  ├─────────────┼──────────────────────────────────────────────────┤
  │ Fonte       │ qualquer path com extensão .pdf/.pptx/.ppt       │
  ├─────────────┼──────────────────────────────────────────────────┤
  │ Tema        │ nome após "tema"/"theme"/"com o tema"/"usando"   │
  │             │ se não encontrado → NÃO DEFINIDO (perguntar)     │
  ├─────────────┼──────────────────────────────────────────────────┤
  │ Tópico      │ "sobre X" / "apresentação de X"                  │
  ├─────────────┼──────────────────────────────────────────────────┤
  │ Slides      │ número mencionado ("10 slides", "com 15 slides") │
  ├─────────────┼──────────────────────────────────────────────────┤
  │ Idioma      │ "em inglês"/"in english" → en | default: pt-BR   │
  └─────────────┴──────────────────────────────────────────────────┘
```

### 0.2 — Validar e confirmar entendimento

Emitir resumo:

```
ENTENDI:
  Ação:     CRIAR DO ZERO | REDESENHAR EXISTENTE
  Fonte:    [path] (se redesign)
  Tema:     [nome] ou ⚠️ não informado
  Tópico:   [assunto] (se criar do zero)
  Slides:   [N]
  Idioma:   [lang]
```

---

## Fase 1 — Resolver tema

> **Emitir:** `▶ [1/6] Resolvendo tema`

### 1.1 — Se tema foi informado

```
Ler: .claude/skills/slide-presentations/themes/[theme].md
Se encontrado → carregar e avançar
Se não encontrado → ir para 1.2
```

### 1.2 — Se tema NÃO foi informado ou não encontrado

Listar todos os temas disponíveis:

```bash
ls .claude/skills/slide-presentations/themes/*.md
```

Apresentar ao usuário com preview de cada um (ler nome, descrição, cores principais, fontes, tom).

```
TEMAS DISPONÍVEIS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  1. [nome] — [descrição] ([cores principais])
     [fontes] | Tom: [tom]
  
  ...

  ─────────────────────────────────────
  0. Criar um tema novo do zero
     A partir de um styleguide (imagem/PDF) ou descrição textual
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Qual tema deseja usar? (número ou nome)
```

**⏸ PAUSA:** Aguardar resposta do usuário.

### 1.3 — Criar tema novo (opção 0)

#### Passo 1 — Coletar informações

```
NOVO TEMA
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Para criar seu tema, preciso de:

  1. Nome do tema (slug, ex: "minha-marca")

  2. Referência visual — pelo menos uma:
     □ Imagem de styleguide (path para PNG/JPG/PDF)
     □ URL do site da marca
     □ Descrição textual (cores, tom, público)

  3. Tom desejado:
     □ Profissional / Corporativo
     □ Moderno / Minimalista
     □ Lúdico / Colorido
     □ Elegante / Refinado
     □ Outro: ________
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**⏸ PAUSA:** Aguardar respostas.

#### Passo 2 — Analisar referência

- **Se imagem/PDF**: usar Read tool para analisar visualmente — extrair paleta, tipografia, elementos visuais, tom
- **Se descrição textual**: usar as informações diretamente

#### Passo 3 — Gerar arquivo de tema

Criar `.claude/skills/slide-presentations/themes/[nome].md` seguindo a **mesma estrutura** dos temas existentes (usar um como base):

```
Estrutura obrigatória:
  - CSS Custom Properties (cores: brand, neutrals, accents)
  - Tipografia (Google Fonts link, escala, pesos por elemento)
  - Cover Slide (background, elementos decorativos, estrutura HTML/CSS)
  - Gradient Patterns
  - Spacing Conventions
  - Border Patterns
  - Shadow Patterns
  - External Dependencies (fonts CDN, icon library CDN)
```

#### Passo 4 — Apresentar para aprovação

**⏸ PAUSA:** Se aprovar → carregar e avançar. Se ajustar → iterar.

---

## Fase 2 — Extrair ou criar conteúdo

> **Emitir:** `▶ [2/6] Preparando conteúdo`

### Caminho A — REDESIGN (arquivo fonte existe)

#### 2A.1 — Ler o arquivo fonte

**Se PDF:**
```
Usar Read tool com o path do arquivo.
Para PDFs grandes (> 10 páginas): ler em blocos de 20 páginas.
```

**Se PPTX:**
```bash
pip install python-pptx 2>/dev/null

python3 << 'PYEOF'
from pptx import Presentation
from pptx.util import Inches, Pt
import json, sys

prs = Presentation(sys.argv[1] if len(sys.argv) > 1 else "INPUT_PATH")
slides_data = []

for i, slide in enumerate(prs.slides):
    slide_info = {
        "number": i + 1,
        "layout": slide.slide_layout.name if slide.slide_layout else "unknown",
        "texts": [],
        "notes": "",
        "has_images": False,
        "has_tables": False
    }
    
    for shape in slide.shapes:
        if shape.has_text_frame:
            for paragraph in shape.text_frame.paragraphs:
                text = paragraph.text.strip()
                if text:
                    slide_info["texts"].append({
                        "text": text,
                        "bold": any(run.font.bold for run in paragraph.runs if run.font.bold),
                        "size": str(paragraph.runs[0].font.size) if paragraph.runs and paragraph.runs[0].font.size else "default"
                    })
        if shape.shape_type == 13:  # Picture
            slide_info["has_images"] = True
        if shape.has_table:
            slide_info["has_tables"] = True
    
    if slide.has_notes_slide:
        notes_frame = slide.notes_slide.notes_text_frame
        slide_info["notes"] = notes_frame.text.strip()
    
    slides_data.append(slide_info)

print(json.dumps(slides_data, indent=2, ensure_ascii=False))
PYEOF
```

**Se PPT (formato antigo):**
```bash
libreoffice --headless --convert-to pdf "[path]" --outdir /tmp/
# Depois ler o PDF gerado
```

#### 2A.2 — Gerar outline a partir do conteúdo

```
OUTLINE (extraído de [nome do arquivo])
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Slides originais: [N]
Slides propostos: [N]

  Slide │ Conteúdo (resumo)                  │ Tipo de slide
  ──────┼────────────────────────────────────┼──────────────────
  1     │ [título]                           │ Cover
  2     │ [citação]                          │ Quote
  3     │ [contexto]                         │ Content (grid/cards)
  ...   │ ...                                │ ...
  N     │ [encerramento]                     │ Cover (closing)
```

**⏸ PAUSA:** Apresentar outline. Aguardar aprovação ou ajustes.

### Caminho B — CRIAR DO ZERO

#### 2B.1 — Gerar outline

```
OUTLINE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Tópico: [assunto]
Total de slides: [N]

  #  │ Título                              │ Tipo de slide
  ───┼─────────────────────────────────────┼──────────────────
  1  │ [Título da apresentação]            │ Cover
  2  │ [Citação impactante]                │ Quote
  3  │ [Contexto / Por quê]                │ Content (cards)
  4  │ [Seção principal]                   │ Content (grid)
  ...│ ...                                 │ ...
  N  │ [Encerramento / Perguntas]          │ Cover (closing)
```

**⏸ PAUSA:** Apresentar outline. Aguardar aprovação ou ajustes.

### Caminho C — Sem tópico e sem arquivo → perguntar

---

## Fase 3 — Gerar apresentação HTML

> **Emitir:** `▶ [3/6] Gerando apresentação`

### Arquitetura

Cada apresentação é um **único arquivo HTML** com CSS e JS inline. Sem build tools, sem frameworks, sem dependências além de fontes CDN definidas pelo tema. O arquivo precisa funcionar abrindo direto no browser, compartilhando via Slack, projetando em reuniões.

```
presentation.html
├── <head>
│   ├── Theme fonts (CDN)
│   ├── Icon library (CDN)
│   └── <style> (all CSS inline)
├── <body>
│   ├── UI chrome (counter, logo, nav dots, arrows, keyboard hint)
│   ├── .slide-container
│   │   ├── .slide.cover.active (first slide)
│   │   ├── .slide (content slides)
│   │   └── .slide.cover (closing slide)
│   └── <script> (navigation logic)
```

### Carregar referências

Antes de gerar, ler os arquivos de referência para obter o CSS/HTML exato:

1. **`references/components.md`** — HTML/CSS de cada componente (cards, grids, badges, cover, animations)
2. **`references/navigation.md`** — CSS e JavaScript completo para navegação, thumbnails, touch, keyboard
3. **`themes/[nome].md`** — Design tokens, paleta, tipografia, estilo do cover

### Tipos de Slide

#### 1. Cover Slide (`.slide.cover`)

Fundo escuro com elementos decorativos definidos pelo tema (blobs, waves, gradients). Usado para abertura, divisores de seção, e encerramento.

```html
<div class="slide cover active" data-slide="0" data-title="Title">
  <!-- Theme decorative elements -->
  <div class="cover-content">
    <!-- Content: logo, title, subtitle, date badge -->
  </div>
</div>
```

**IMPORTANTE:** NÃO colocar `position: relative` no `.cover` — deve herdar `position: absolute` do `.slide` para o sistema de stacking funcionar.

#### 2. Content Slide (`.slide`)

Fundo branco/claro, layout flex centralizado:

```html
<div class="slide" data-slide="1" data-title="Title" style="background: var(--white);">
  <div class="section-label fade-up">Section Name</div>
  <h2 class="slide-title fade-up">Title with <em>emphasis</em></h2>
  <!-- Content: grids, cards, lists -->
</div>
```

#### 3. Quote Slide

Fundo vibrante de cor única com blockquote centralizado. Bom para abrir com impacto logo após o cover.

#### 4. Grid/Card Slide

CSS Grid para layouts estruturados. Cards seguem os padrões de `references/components.md`.

### Design Philosophy

Apresentações modernas e limpas — não corporate-boring, não startup-flashy. Whitespace generoso, animações sutis, uso restrito de cor. A cor primária da marca é a assinatura; outras cores são acentos que nunca competem com o layout.

### Construindo a Apresentação

1. **Carregar o tema** — ler o arquivo de tema para cores, tipografia, estilo do cover
2. **Carregar referências** — ler `references/components.md` e `references/navigation.md`
3. **Começar pelo cover** — usar a estrutura do tema (elementos decorativos + cover-content)
4. **Planejar o arco narrativo** — que história os slides contam? Agrupar conteúdo relacionado
5. **Usar section labels** para orientar ("Visão Geral", "Detalhes", "Próximos Passos")
6. **Destacar palavras-chave** com `<em>` nos títulos — uma ou duas palavras no máximo
7. **Fechar com cover** — mensagem de encerramento, "Perguntas?", ou call to action
8. **Manter slides focados** — uma ideia por slide, whitespace generoso
9. **Usar `fade-up` e `stagger`** em todos os elementos para animações de entrada polidas
10. **Atribuir `data-slide` sequencial** começando de 0
11. **Adicionar `data-title` em todo slide** — label curto para os tooltips de preview dos nav dots

### Detalhes Técnicos Importantes

- Todos os slides devem estar dentro de `.slide-container`
- Primeiro slide recebe `.slide`, `.cover`, e `.active`
- A classe `.slide` provê `position: absolute` — nunca sobrescrever com `position: relative` no `.cover`
- Content slides usam `style="background: var(--white);"` inline
- Cover slides não precisam de background inline (`.cover` usa o background do tema)
- Nav dots são gerados dinamicamente via JS a partir de `document.querySelectorAll('.slide').length`
- Classes de ícone dependem da icon library do tema (ex: Font Awesome `fa-solid fa-users`)
- Usar `clamp()` para sizing responsivo em títulos

### Referências

- **`references/components.md`** — HTML/CSS completo de cada padrão de componente
- **`references/navigation.md`** — CSS e JavaScript completo do sistema de navegação
- **`themes/[nome].md`** — Design tokens e estilo visual do tema escolhido

**Ler o arquivo de referência apropriado quando precisar do CSS ou HTML exato de um componente.**

---

## Fase 4 — Refinar e polir

> **Emitir:** `▶ [4/6] Refinando apresentação`

### 4.1 — Consistência visual

- [ ] Todas as cores vêm do tema (nenhuma cor hardcoded fora da paleta)
- [ ] Tipografia consistente (mesmas fontes em todos os slides)
- [ ] Espaçamento uniforme
- [ ] Elementos decorativos consistentes
- [ ] Logo aparece em content slides, oculto em cover slides

### 4.2 — Animações

- [ ] `fade-up` em todos os elementos de conteúdo
- [ ] `stagger` em grids e listas para cascata de entrada
- [ ] Delays escalonados (0.1s incrementos) para sequência natural
- [ ] Transições de slide com translateX + opacity

### 4.3 — Navegação

- [ ] Nav dots gerados corretamente
- [ ] Preview tooltips com `data-title` em todo slide
- [ ] Keyboard (arrows, space, home/end)
- [ ] Touch (swipe > 50px threshold)
- [ ] Counter adapta cor em slides escuros vs claros

---

## Fase 5 — Entrega

> **Emitir:** `▶ [5/6] Entrega`

### 5.1 — Salvar arquivo

```bash
mkdir -p slides
# slides/[slug-do-topico].html
```

### 5.2 — Instruções de uso

```
APRESENTAÇÃO GERADA
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Arquivo:    slides/[nome].html
Tema:       [nome do tema]
Slides:     [N] slides

Para apresentar:
  Abrir slides/[nome].html no navegador
  Teclas: ← → (navegar) | Space (avançar) | Home/End (primeiro/último)

Para editar:
  O arquivo é HTML puro — editar em qualquer editor de texto
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Fase 6 — Iteração (opcional)

> **Emitir:** `▶ [6/6] Revisão com o usuário`

```
Deseja ajustar algo?
  • Trocar conteúdo de um slide específico
  • Mudar layout de algum slide
  • Adicionar ou remover slides
  • Ajustar cores ou tipografia
  • Nada — está perfeito ✓
```

---

## Regras

1. **Parser dual** — flags explícitas têm prioridade; linguagem natural preenche o que faltar
2. **Tema é lei** — todas as decisões visuais vêm do arquivo de tema; nunca inventar cores/fontes
3. **Tema obrigatório** — se não informado, SEMPRE perguntar (listar disponíveis + opção de criar)
4. **Motor custom** — HTML/CSS/JS inline, NUNCA usar reveal.js ou frameworks de slides; copiar os padrões exatos de `references/components.md` e `references/navigation.md`
5. **Standalone** — o HTML não depende de arquivos locais (fontes/ícones via CDN)
6. **Anti-stub** — todo slide tem conteúdo real, nunca placeholder genérico
7. **Variação visual** — alternar layouts e fundos para manter interesse
8. **Brand-first** — logo, cores, tipografia da marca são inegociáveis
9. **Pausa antes de gerar** — o outline SEMPRE é apresentado ao usuário antes da geração
10. **Ler referências** — SEMPRE ler `references/components.md`, `references/navigation.md`, e `themes/[nome].md` antes de gerar qualquer slide
