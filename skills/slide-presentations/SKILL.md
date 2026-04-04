---
name: slide-presentations
description: Create polished, animated HTML slide presentations with theme support. Use this skill whenever the user asks to create a presentation, slide deck, pitch deck, or wants to present information in slides. Also trigger when the user says things like "make slides for", "create a deck about", "build a presentation on", or "I need to present this". The skill produces a single self-contained HTML file with keyboard navigation, animated transitions, and a theme-driven design system.
---

# Slide Presentations

Create single-file HTML presentations that feel premium and cohesive. Every presentation follows a consistent architecture with smooth slide transitions, entrance animations, and full keyboard/touch navigation. The visual identity is driven by a **theme** — a set of colors, typography, and component styles.

## Themes

Themes define the visual identity of a presentation. Each theme provides:
- CSS custom properties (colors, accents, neutrals)
- Typography (font family, weights, scale)
- Cover slide style (background, decorative elements)
- Gradient patterns and shadow colors
- External CDN dependencies (fonts, icons)

Available themes live in `themes/<name>/theme.md`. Read the theme file to load the design tokens and visual rules before building slides.

### Available Themes

| Theme | Style |
|---|---|
| `agilize` | Purple-centric, Quicksand typography, animated blob covers. Confident, warm, professional. |

When the user doesn't specify a theme, default to `agilize`. When creating a new theme, follow the same structure as existing theme files.

## Design Philosophy

Presentations feel modern and clean — not corporate-boring, not startup-flashy. The design relies on generous whitespace, subtle animations, and restrained color use. The primary brand color is the signature; other colors appear as accents for categorization but never compete with the layout.

## Architecture

Every presentation is a **single HTML file** with embedded CSS and JS. No build tools, no dependencies beyond CDN links defined by the theme. These files get shared via Slack, opened directly in browsers, and projected in meetings — they need to Just Work.

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

## Slide Types

### 1. Cover Slide (`.slide.cover`)

Dark background with decorative elements (defined by the theme). Used for the opening, section dividers, and closing.

Structure:
```html
<div class="slide cover active" data-slide="0" data-title="Title">
  <!-- Theme decorative elements (e.g., blobs) -->
  <div class="cover-content">
    <!-- Content here: logo, title, subtitle, date badge -->
  </div>
</div>
```

Do NOT set `position: relative` on `.cover` — it must inherit `position: absolute` from `.slide` for the stacking system to work correctly.

### 2. Content Slide (`.slide`)

White/light background, centered flex layout. Structure:
```html
<div class="slide" data-slide="1" data-title="Title" style="background: var(--white);">
  <div class="section-label fade-up">Section Name</div>
  <h2 class="slide-title fade-up">Title with <em>emphasis</em></h2>
  <!-- Content: grids, cards, lists, etc. -->
</div>
```

### 3. Quote Slide

A vibrant single-color background with a centered blockquote. Good for opening with an impactful quote right after the cover.

### 4. Grid/Card Slide

Uses CSS Grid for structured layouts (teams, features, comparisons). Cards follow patterns defined in `references/components.md` with subtle borders, rounded corners, and hover lift effects.

## Component Patterns

Read `references/components.md` for full HTML/CSS of each component. Summary:

### Cards
- **Context card**: Icon + title + description. 16px border-radius, 1px border, hover lifts -4px.
- **Member card**: Avatar (48px circle) + name + role. 14px border-radius, flex layout.
- **Number card**: Big number (56px, brand color) + label below. Good for stats/metrics.
- **Staff card**: Larger avatar (72px) + name + title. Centered layout.

### Grids
- 3-column for overview grids: `grid-template-columns: repeat(3, 1fr)`
- 4-column for squad comparisons: `grid-template-columns: repeat(4, 1fr)`
- Always `max-width: 1100px; width: 100%` to constrain and center

### Tags/Badges
- Section label: uppercase, letter-spacing 4px, brand color
- Squad tags: pill-shaped, 11px uppercase
- Role badges: 9px, colored background, white text
- Date badge: inline-block, bordered pill on cover slides

## Animation System

### Fade-up entrance
Add class `fade-up` to elements. They start `opacity: 0; translateY(20px)` and animate in when the parent slide gets `.active`. Sequential children get staggered delays (0.1s increments).

### Stagger entrance
Wrap children in a `.stagger` container. Each child animates in with 0.05s delay increments — feels like items cascading into view.

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

The `goToSlide()` function manages the active class, exit animations, counter updates, and nav dot state. The slide counter adapts its color on cover slides (white text) vs content slides (brand/gray).

### Slide Preview Tooltips

Each nav dot renders a hover preview with:
- A **scaled-down clone** of the actual slide content as thumbnail (cover-fit scaling)
- A **title label pill** overlaid at the bottom (frosted glass, `backdrop-filter: blur(8px)`)
- Smooth `opacity` + `scale` entrance animation on hover

Slide titles come from the `data-title` attribute on each `.slide` element. Always add `data-title` to every slide.

## Building a Presentation

When creating a new presentation:

1. **Load the theme** — read the theme file to get colors, typography, and cover style
2. **Start with the cover slide** — use the theme's cover structure (decorative elements + cover-content)
3. **Plan the narrative arc** — what story do the slides tell? Group related content.
4. **Use section labels** to orient the audience ("Overview", "Details", "Next Steps")
5. **Highlight key words** with `<em>` in slide titles — one or two words max
6. **End with a cover slide** — closing message, "Questions?" prompt, or call to action
7. **Keep slides focused** — one idea per slide, generous whitespace
8. **Use `fade-up` and `stagger`** on all content elements for polished entrance animations
9. **Assign sequential `data-slide` attributes** starting from 0
10. **Add `data-title` to every slide** — a short label used by the nav dot preview tooltips

## Important Technical Details

- All slides must be inside `.slide-container`
- First slide gets both `.slide` and `.cover` and `.active` classes
- The `.slide` class provides `position: absolute` — never override this with `position: relative` on `.cover` or any variant, as this breaks the stacking
- Content slides use inline `style="background: var(--white);"`
- Cover slides need no inline background (`.cover` class provides the theme's dark background)
- The nav dots are generated dynamically from `document.querySelectorAll('.slide').length`
- Icon classes depend on the theme's icon library (e.g., Font Awesome `fa-solid fa-users`)
- Use `clamp()` for responsive text sizing on titles

## Reference Files

- `references/components.md` — Full HTML/CSS for every component pattern (cards, grids, badges, cover, animations)
- `references/navigation.md` — Complete CSS and JavaScript for slide navigation, thumbnails, touch handling, and keyboard controls
- `themes/<name>/theme.md` — Design tokens, color palette, typography, and cover style for the chosen theme

Read the appropriate reference file when you need the exact CSS or HTML for a specific component.
