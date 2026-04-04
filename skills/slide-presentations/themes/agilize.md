# Agilize Theme

Purple-centric, confident, warm, professional. Uses Quicksand typography and animated blob backgrounds on cover slides.

## CSS Custom Properties

```css
:root {
  /* --- Brand --- */
  --purple-dark: #3D1A6E;
  --purple: #5C2D91;
  --purple-light: #7B4FAF;
  --purple-subtle: #F3EDF9;

  /* --- Neutrals --- */
  --white: #FFFFFF;
  --gray-50: #FAFAFA;
  --gray-100: #F5F5F5;
  --gray-200: #E8E8E8;
  --gray-400: #AAAAAA;
  --gray-600: #666666;
  --gray-800: #333333;
  --text: #2D2D2D;

  /* --- Accent Colors (for categorization) --- */
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

  /* --- Slide Transition --- */
  --slide-transition: 0.5s cubic-bezier(0.4, 0, 0.2, 1);
}
```

## Typography

**Font**: `'Quicksand', sans-serif` — loaded from Google Fonts with weights 300, 400, 500, 600, 700.

| Element | Size | Weight | Color |
|---|---|---|---|
| Cover h1 | `clamp(48px, 7vw, 80px)` | 700 | white |
| Slide title | `clamp(28px, 3.5vw, 44px)` | 700 | `--gray-800` |
| Title emphasis `<em>` | same | 700 | `--purple` (not italic) |
| Section label | 14px | 700 | `--purple`, uppercase, letter-spacing 4px |
| Squad header | `clamp(24px, 3vw, 36px)` | 700 | `--gray-800` |
| Card title (h3) | 20px | 700 | `--gray-800` |
| Staff name (h4) | 18px | 700 | `--gray-800` |
| Body text | 16px | 400-500 | `--gray-600` |
| Member name | 15px | 700 | `--gray-800` |
| Member role | 13px | 400 | `--gray-600` |
| Hierarchy label | 12px | 700 | `--gray-400` |
| Badge text | 9-11px | 700 | varies |
| Keyboard hint | 12px | 400 | `--gray-600` |

The `<em>` inside `.slide-title` renders in purple, not italic — this is a signature pattern for highlighting key words in titles.

## Cover Slide

Background: `#1B0A2E` (very deep indigo-black). Set directly on `.cover` class, not as a CSS variable.

### Animated Blobs

6 blurred blobs that drift slowly across the cover slide, creating a living, organic background. The `cover-content` sits above with `z-index: 2`.

```html
<div class="slide cover active" data-slide="0" data-title="Title">
  <div class="cover-blob"></div>
  <div class="cover-blob"></div>
  <div class="cover-blob"></div>
  <div class="cover-blob"></div>
  <div class="cover-blob"></div>
  <div class="cover-blob"></div>
  <div class="cover-content">
    <div class="fade-up" style="margin-bottom: 32px;">
      <div class="cover-logo-heartbeat">
        <img src="assets/logo-branca.png" alt="Logo" style="height: 56px; opacity: 0.9;">
      </div>
    </div>
    <div class="logo-text fade-up">Company Name</div>
    <div class="decorative-line fade-up"></div>
    <h1 class="fade-up" style="font-size: clamp(48px, 7vw, 80px);">
      Presentation Title
    </h1>
    <div class="date-badge fade-up">
      <i class="fa-solid fa-users"></i>&nbsp; Event Name
    </div>
  </div>
</div>
```

```css
.cover {
  background: #1B0A2E;
  color: var(--white); text-align: center; overflow: hidden;
}
.cover::before, .cover::after { content: none; }

.cover-blob {
  position: absolute;
  border-radius: 50%;
  filter: blur(80px);
  opacity: 0.7;
  z-index: 0;
}

.cover-blob:nth-child(1) {
  width: 500px; height: 500px;
  background: #5C2D91;
  top: -10%; left: -5%;
  animation: drift1 16s ease-in-out infinite alternate;
}
.cover-blob:nth-child(2) {
  width: 400px; height: 400px;
  background: #1ABC9C;
  opacity: 0.35;
  bottom: -15%; right: -5%;
  animation: drift2 20s ease-in-out infinite alternate;
}
.cover-blob:nth-child(3) {
  width: 350px; height: 350px;
  background: #9B59B6;
  top: 50%; left: 60%;
  animation: drift3 18s ease-in-out infinite alternate;
}
.cover-blob:nth-child(4) {
  width: 300px; height: 450px;
  background: #2980B9;
  opacity: 0.3;
  top: 10%; right: 20%;
  animation: drift4 22s ease-in-out infinite alternate;
}
.cover-blob:nth-child(5) {
  width: 450px; height: 300px;
  background: #E67E22;
  opacity: 0.2;
  bottom: 10%; left: 30%;
  animation: drift5 19s ease-in-out infinite alternate;
}
.cover-blob:nth-child(6) {
  width: 350px; height: 350px;
  background: #3D1A6E;
  top: 30%; left: 10%;
  animation: drift6 24s ease-in-out infinite alternate;
}

@keyframes drift1 { 0% { transform: translate(0, 0); } 100% { transform: translate(30vw, 40vh); } }
@keyframes drift2 { 0% { transform: translate(0, 0); } 100% { transform: translate(-35vw, -30vh); } }
@keyframes drift3 { 0% { transform: translate(0, 0); } 100% { transform: translate(-25vw, -45vh); } }
@keyframes drift4 { 0% { transform: translate(0, 0); } 100% { transform: translate(-20vw, 35vh); } }
@keyframes drift5 { 0% { transform: translate(0, 0); } 100% { transform: translate(25vw, -25vh); } }
@keyframes drift6 { 0% { transform: translate(0, 0); } 100% { transform: translate(20vw, 30vh); } }

@keyframes heartbeat {
  0% { transform: scale(1); }
  8% { transform: scale(1.15); }
  16% { transform: scale(1); }
  24% { transform: scale(1.10); }
  32% { transform: scale(1); }
  100% { transform: scale(1); }
}

.cover-logo-heartbeat { animation: heartbeat 1s ease-in-out infinite; display: inline-block; }
.cover-content { position: relative; z-index: 2; }
.cover .logo-text { font-size: 18px; font-weight: 300; letter-spacing: 8px; text-transform: uppercase; opacity: 0.7; margin-bottom: 40px; }
.cover h1 { font-size: clamp(36px, 5vw, 64px); font-weight: 700; line-height: 1.2; margin-bottom: 16px; }
.cover h1 span { display: block; font-weight: 300; font-size: 0.55em; opacity: 0.8; margin-top: 8px; }

.date-badge { display: inline-block; margin-top: 32px; padding: 10px 28px; border: 1px solid rgba(255,255,255,0.3); border-radius: 30px; font-weight: 500; font-size: 14px; letter-spacing: 1px; }
.decorative-line { width: 60px; height: 3px; background: rgba(255,255,255,0.4); border-radius: 2px; margin: 24px auto; }
```

### Closing Slide

Same structure as cover slide but with closing content:

```html
<div class="slide cover" data-slide="N" data-title="Questions?">
  <div class="cover-blob"></div>
  <div class="cover-blob"></div>
  <div class="cover-blob"></div>
  <div class="cover-blob"></div>
  <div class="cover-blob"></div>
  <div class="cover-blob"></div>
  <div class="cover-content">
    <p class="fade-up" style="font-size: clamp(28px, 4vw, 48px); font-weight: 700; letter-spacing: 1px; color: #FFFFFF;">Questions?</p>
    <p class="fade-up" style="font-size: 14px; opacity: 0.4; margin-top: 24px; letter-spacing: 2px; text-transform: uppercase; color: #FFFFFF;">Event Name — Year</p>
  </div>
</div>
```

## Gradient Patterns

For colored card backgrounds, use linear gradients at 135deg between two shades of the same hue:

```css
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
- Dashed/muted card: `1px dashed var(--gray-400)` with `opacity: 0.55-0.75`
- Accent border-left: `3px solid` or `4px solid` with accent color
- Cover date badge: `1px solid rgba(255,255,255,0.3)`

## Shadow Patterns

- Nav bar: `0 4px 24px rgba(0,0,0,0.1)`
- Card hover: `0 6px 20px rgba(92,45,145,0.08)`
- Large card hover: `0 12px 32px rgba(92,45,145,0.08)`

## External Dependencies

```html
<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
```
