---
name: agilize-presentation
description: Create polished, animated HTML slide presentations following the Agilize design system. Use this skill whenever the user asks to create a presentation, slide deck, pitch deck, or wants to present information in slides — even if they don't say "Agilize style" explicitly. Also trigger when the user says things like "make slides for", "create a deck about", "build a presentation on", or "I need to present this". The skill produces a single self-contained HTML file with keyboard navigation, animated transitions, and a consistent purple-centric color palette.
---

# Agilize Presentation Builder

Create single-file HTML presentations that feel premium and cohesive. Every presentation follows the same design language: Quicksand typography, a purple-centric palette, smooth slide transitions, and animated blob backgrounds on cover slides.

## Design Philosophy

The presentations feel modern and clean — not corporate-boring, not startup-flashy. Think: confident, warm, professional. The design relies on generous whitespace, subtle animations, and restrained color use. Purple is the signature; other colors appear as accents for categorization (role dots, squad borders) but never compete with the layout.

## Architecture

Every presentation is a **single HTML file** with embedded CSS and JS. No build tools, no dependencies beyond two CDN links. This matters because these files get shared via Slack, opened directly in browsers, and projected in meetings — they need to Just Work.

```
presentation.html
├── <head>
│   ├── Google Fonts: Quicksand (300–700)
│   ├── Font Awesome 6.5.1
│   └── <style> (all CSS inline)
├── <body>
│   ├── UI chrome (counter, logo, nav dots, arrows, keyboard hint)
│   ├── .slide-container
│   │   ├── .slide.cover.active (first slide)
│   │   ├── .slide (content slides)
│   │   └── .slide.cover (closing slide)
│   └── <script> (navigation logic)
```

## Color Palette

Read `references/design-tokens.md` for the full set of CSS custom properties. Here's the essential palette:

| Token | Value | Usage |
|---|---|---|
| `--purple-dark` | `#3D1A6E` | Deep accents, structural borders |
| `--purple` | `#5C2D91` | Primary brand, active states, emphasis |
| `--purple-light` | `#7B4FAF` | Hover states, secondary accents |
| `--purple-subtle` | `#F3EDF9` | Light backgrounds |
| `--white` | `#FFFFFF` | Card backgrounds |
| `--gray-50` | `#FAFAFA` | Page/slide background |
| `--gray-100` | `#F5F5F5` | Subtle fills |
| `--gray-200` | `#E8E8E8` | Borders, dividers |
| `--gray-400` | `#AAAAAA` | Muted text, labels |
| `--gray-600` | `#666666` | Secondary text |
| `--gray-800` | `#333333` | Primary text on light backgrounds |
| `--text` | `#2D2D2D` | Body text |

Cover slides use a deep background `#1B0A2E` with white text. Content slides use `var(--white)` background with dark text.

## Typography

**Font**: `'Quicksand', sans-serif` — loaded from Google Fonts with weights 300, 400, 500, 600, 700.

| Element | Size | Weight | Color |
|---|---|---|---|
| Cover h1 | `clamp(48px, 7vw, 80px)` | 700 | white |
| Slide title | `clamp(28px, 3.5vw, 44px)` | 700 | `--gray-800` |
| Title emphasis `<em>` | same | 700 | `--purple` (not italic) |
| Section label | 14px | 700 | `--purple`, uppercase, letter-spacing 4px |
| Body/card text | 15–16px | 500–600 | `--gray-600` |
| Small labels | 12–13px | 600–700 | `--gray-400` |

The `<em>` inside `.slide-title` renders in purple, not italic — this is a signature pattern for highlighting key words in titles.

## Slide Types

### 1. Cover Slide (`.slide.cover`)

Dark background (`#1B0A2E`) with 6 animated blurred blobs that drift slowly across the slide. Used for the opening, section dividers, and closing.

Structure:
```html
<div class="slide cover active" data-slide="0">
  <div class="cover-blob"></div>
  <div class="cover-blob"></div>
  <div class="cover-blob"></div>
  <div class="cover-blob"></div>
  <div class="cover-blob"></div>
  <div class="cover-blob"></div>
  <div class="cover-content">
    <!-- Content here: logo, title, subtitle, date badge -->
  </div>
</div>
```

The 6 blobs use different colors (#5C2D91, #1ABC9C, #9B59B6, #2980B9, #E67E22, #3D1A6E), sizes (300–500px), opacities (0.2–0.7), and drift animations (16–24s, alternating). They create a living, organic background. The `cover-content` sits above with `z-index: 2`.

Do NOT set `position: relative` on `.cover` — it must inherit `position: absolute` from `.slide` for the stacking system to work correctly.

### 2. Content Slide (`.slide`)

White background, centered flex layout. Structure:
```html
<div class="slide" data-slide="1" style="background: var(--white);">
  <div class="section-label fade-up">Section Name</div>
  <h2 class="slide-title fade-up">Title with <em>emphasis</em></h2>
  <!-- Content: grids, cards, lists, etc. -->
</div>
```

### 3. Quote Slide

A vibrant single-color background (e.g., `#00E68D`) with a centered blockquote. Good for opening with an impactful quote right after the cover.

### 4. Grid/Card Slide

Uses CSS Grid for structured layouts (teams, features, comparisons). Cards follow the `.context-card` or `.member-card` pattern with subtle borders, rounded corners (12–16px), and hover lift effects.

## Component Patterns

Read `references/components.md` for full HTML/CSS of each component. Summary:

### Cards
- **Context card**: Icon + title + description. 16px border-radius, 1px border, hover lifts -4px.
- **Member card**: Avatar (48px circle) + name + role. 14px border-radius, flex layout.
- **Number card**: Big number (56px, purple) + label below. Good for stats/metrics.
- **Staff card**: Larger avatar (72px) + name + title. Centered layout.

### Grids
- 3-column for overview grids: `grid-template-columns: repeat(3, 1fr)`
- 4-column for squad comparisons: `grid-template-columns: repeat(4, 1fr)`
- Always `max-width: 1100px; width: 100%` to constrain and center

### Tags/Badges
- Section label: uppercase, letter-spacing 4px, purple
- Squad tags: pill-shaped, 11px uppercase
- Role badges: 9px, colored background, white text
- Date badge: inline-block, bordered pill on cover slides

## Animation System

### Fade-up entrance
Add class `fade-up` to elements. They start `opacity: 0; translateY(20px)` and animate in when the parent slide gets `.active`. Sequential children get staggered delays (0.1s increments).

### Stagger entrance
Wrap children in a `.stagger` container. Each child animates in with 0.05s delay increments — feels like items cascading into view.

### Cover blob drift
6 `@keyframes` animations (drift1–drift6) move blobs across 20–40vw/vh over 16–24 seconds, alternating direction infinitely.

### Heartbeat logo
The logo on the cover pulses subtly: `scale(1) → scale(1.15) → scale(1) → scale(1.10) → scale(1)` over 1 second.

### Slide transitions
Slides transition with `opacity` + `translateX(80px)` over 0.5s using `cubic-bezier(0.4, 0, 0.2, 1)`.

## Navigation System

The JavaScript navigation handles:
- **Keyboard**: Arrow keys to navigate, Space for next, Home/End for first/last
- **Touch**: Swipe gestures (>50px threshold)
- **Click**: Nav dots at bottom (pill bar with blur backdrop), arrow buttons on sides
- **Counter**: Top-left shows `01 / 15` format
- **Logo**: Small logo appears top-center on content slides, hidden on all cover slides
- **Slide Preview Tooltips**: Hovering a nav dot shows a miniature thumbnail of the corresponding slide with a frosted-glass pill label showing the slide title

The `goToSlide()` function manages the active class, exit animations, counter updates, and nav dot state. The slide counter adapts its color on cover slides (white text) vs content slides (purple/gray).

### Slide Preview Tooltips

Each nav dot renders a hover preview with:
- A **scaled-down clone** of the actual slide content as thumbnail (cover-fit scaling)
- A **title label pill** overlaid at the bottom (frosted glass, `backdrop-filter: blur(8px)`)
- Smooth `opacity` + `scale` entrance animation on hover

Slide titles come from the `data-title` attribute on each `.slide` element. Always add `data-title` to every slide.

## Building a Presentation

When creating a new presentation:

1. **Start with the cover slide** — always include the 6 blob divs and cover-content with logo, title, and date badge
2. **Plan the narrative arc** — what story do the slides tell? Group related content.
3. **Use section labels** to orient the audience ("Overview", "Details", "Next Steps")
4. **Highlight key words** with `<em>` in slide titles — one or two words max
5. **End with a cover slide** — closing message, "Questions?" prompt, or call to action
6. **Keep slides focused** — one idea per slide, generous whitespace
7. **Use `fade-up` and `stagger`** on all content elements for polished entrance animations
8. **Assign sequential `data-slide` attributes** starting from 0
9. **Add `data-title` to every slide** — a short label (e.g., "Team Overview", "Dúvidas?") used by the nav dot preview tooltips

## Important Technical Details

- All slides must be inside `.slide-container`
- First slide gets both `.slide` and `.cover` and `.active` classes
- The `.slide` class provides `position: absolute` — never override this with `position: relative` on `.cover` or any variant, as this breaks the stacking
- Content slides use inline `style="background: var(--white);"`
- Cover slides need no inline background (`.cover` class provides `#1B0A2E`)
- The nav dots are generated dynamically from `document.querySelectorAll('.slide').length`
- Font Awesome icons use the `fa-solid` prefix (e.g., `fa-solid fa-users`)
- Use `clamp()` for responsive text sizing on titles

## Reference Files

- `references/design-tokens.md` — Complete CSS custom properties, all color values, and spacing conventions
- `references/components.md` — Full HTML/CSS for every component pattern (cards, grids, badges, navigation, cover blobs, animations)
- `references/navigation.md` — Complete JavaScript for slide navigation, touch handling, and keyboard controls

Read the appropriate reference file when you need the exact CSS or HTML for a specific component.
