# Design Tokens

## CSS Custom Properties

```css
:root {
  /* ─── Brand ─── */
  --purple-dark: #3D1A6E;
  --purple: #5C2D91;
  --purple-light: #7B4FAF;
  --purple-subtle: #F3EDF9;

  /* ─── Neutrals ─── */
  --white: #FFFFFF;
  --gray-50: #FAFAFA;
  --gray-100: #F5F5F5;
  --gray-200: #E8E8E8;
  --gray-400: #AAAAAA;
  --gray-600: #666666;
  --gray-800: #333333;
  --text: #2D2D2D;

  /* ─── Accent Colors (for categorization) ─── */
  --accent-orange: #E67E22;
  --accent-blue: #3498DB;
  --accent-teal: #1ABC9C;
  --accent-deep-blue: #2980B9;
  --accent-violet: #9B59B6;
  --accent-red: #E74C3C;
  --accent-dark-red: #C0392B;
  --accent-burnt-orange: #D35400;
  --accent-dark-blue: #2C3E50;
  --accent-green: #00E68D;
  --accent-pink: #E91E63;

  /* ─── Slide Transition ─── */
  --slide-transition: 0.5s cubic-bezier(0.4, 0, 0.2, 1);
}
```

## Cover Background

The cover slide background is `#1B0A2E` (very deep indigo-black). This is set directly on the `.cover` class, not as a CSS variable, because it's a fixed design constant.

## Gradient Patterns

For colored card backgrounds, use linear gradients at 135deg between two shades of the same hue:

```css
/* Example gradient cards */
background: linear-gradient(135deg, #3D1A6E, #5C2D91);  /* deep purple */
background: linear-gradient(135deg, #5C2D91, #7B4FAF);  /* medium purple */
background: linear-gradient(135deg, #7B2D8E, #9B59B6);  /* violet */
background: linear-gradient(135deg, #2D1050, #3D1A6E);  /* darkest */
```

## Spacing Conventions

| Context | Value |
|---|---|
| Slide padding | `40px 60px` |
| Card padding | `14px 18px` (small), `28px 24px` (medium), `32px 36px` (large) |
| Card border-radius | `12px` (compact), `14px` (standard), `16px` (large) |
| Grid gap | `12px` (compact), `20px` (standard), `32px` (spacious) |
| Max content width | `1100px` |
| Section margin-bottom | `40px` (title), `16px` (hierarchy section) |

## Border Patterns

- Standard card: `1px solid var(--gray-200)`
- Dashed/muted card: `1px dashed var(--gray-400)` with `opacity: 0.55–0.75`
- Accent border-left: `3px solid` or `4px solid` with accent color
- Cover date badge: `1px solid rgba(255,255,255,0.3)`

## Shadow Patterns

- Nav bar: `0 4px 24px rgba(0,0,0,0.1)`
- Card hover: `0 6px 20px rgba(92,45,145,0.08)`
- Large card hover: `0 12px 32px rgba(92,45,145,0.08)`

## Typography Scale

| Use | Size | Weight | Color |
|---|---|---|---|
| Cover title | `clamp(48px, 7vw, 80px)` | 700 | white |
| Slide title | `clamp(28px, 3.5vw, 44px)` | 700 | `--gray-800` |
| Squad header | `clamp(24px, 3vw, 36px)` | 700 | `--gray-800` |
| Card title (h3) | `20px` | 700 | `--gray-800` |
| Staff name (h4) | `18px` | 700 | `--gray-800` |
| Body text | `16px` | 400–500 | `--gray-600` |
| Member name | `15px` | 700 | `--gray-800` |
| Section label | `14px` | 700 | `--purple` |
| Member role | `13px` | 400 | `--gray-600` |
| Hierarchy label | `12px` | 700 | `--gray-400` |
| Badge text | `9–11px` | 700 | varies |
| Keyboard hint | `12px` | 400 | `--gray-600` |

## External Dependencies

```html
<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
```
