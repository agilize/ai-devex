# Component Library

## Table of Contents
1. [Cover Slide](#cover-slide)
2. [Content Slide](#content-slide)
3. [Section Label & Title](#section-label--title)
4. [Context Cards Grid](#context-cards-grid)
5. [Member Cards](#member-cards)
6. [Number Cards](#number-cards)
7. [Staff Cards](#staff-cards)
8. [Overview Grid (Compact)](#overview-grid-compact)
9. [Squad Overview Cards (Colored)](#squad-overview-cards-colored)
10. [Hierarchy Layout](#hierarchy-layout)
11. [Role Legend](#role-legend)
12. [Tags & Badges](#tags--badges)
13. [Timeline](#timeline)
14. [Quote Slide](#quote-slide)
15. [Closing Slide](#closing-slide)

---

## Cover Slide

```html
<div class="slide cover active" data-slide="0">
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

---

## Content Slide

```html
<div class="slide" data-slide="1" style="background: var(--white);">
  <div class="section-label fade-up"><i class="fa-solid fa-icon"></i> Section Name</div>
  <h2 class="slide-title fade-up">Title with <em>emphasis</em></h2>
  <!-- Content goes here -->
</div>
```

---

## Section Label & Title

```css
.section-label {
  font-size: 14px; font-weight: 700; letter-spacing: 4px;
  text-transform: uppercase; color: var(--purple); margin-bottom: 12px;
}
.slide-title {
  font-size: clamp(28px, 3.5vw, 44px); font-weight: 700;
  color: var(--gray-800); margin-bottom: 40px; text-align: center;
}
.slide-title em { color: var(--purple); font-style: normal; }
```

---

## Context Cards Grid

3-column grid for presenting concepts, features, or ideas.

```html
<div class="context-grid stagger">
  <div class="context-card">
    <div class="context-icon"><i class="fa-solid fa-icon"></i></div>
    <h3>Card Title</h3>
    <p>Description text explaining this concept.</p>
  </div>
  <!-- more cards -->
</div>
```

```css
.context-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 32px; max-width: 1000px; width: 100%; }
.context-card { background: var(--gray-50); border-radius: 16px; padding: 32px 28px; text-align: center; border: 1px solid var(--gray-200); transition: transform 0.3s ease, box-shadow 0.3s ease; }
.context-card:hover { transform: translateY(-4px); box-shadow: 0 12px 32px rgba(92,45,145,0.08); }
.context-icon { width: 56px; height: 56px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 22px; margin: 0 auto 16px; color: var(--purple); }
.context-card h3 { font-size: 20px; font-weight: 700; margin-bottom: 8px; color: var(--gray-800); }
.context-card p { font-size: 16px; color: var(--gray-600); line-height: 1.6; }
```

---

## Member Cards

Individual person cards with avatar, name, and role.

```html
<div class="members-row stagger">
  <div class="member-card">
    <div class="member-avatar"><img src="photos/name.png" alt="Name"></div>
    <div class="member-info">
      <div class="member-name">Person Name</div>
      <div class="member-role"><i class="fa-solid fa-code" style="font-size:12px;color:var(--accent-blue);"></i> Role Title</div>
    </div>
  </div>
</div>
```

```css
.members-row { display: flex; flex-wrap: wrap; gap: 12px; justify-content: center; }
.member-card { display: flex; align-items: center; gap: 12px; background: var(--white); border-radius: 14px; padding: 14px 18px; min-width: 240px; transition: transform 0.25s ease, box-shadow 0.25s ease; border: 1px solid var(--gray-200); }
.member-card:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(92,45,145,0.08); }
.member-card.hiring { border: 1px dashed var(--gray-400); opacity: 0.75; }
.member-avatar { width: 48px; height: 48px; border-radius: 50%; flex-shrink: 0; overflow: hidden; background: var(--gray-200); }
.member-avatar img { width: 100%; height: 100%; object-fit: cover; border-radius: 50%; }
.member-info { flex: 1; min-width: 0; }
.member-name { font-size: 15px; font-weight: 700; color: var(--gray-800); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.member-role { font-size: 13px; color: var(--gray-600); margin-top: 2px; }
```

---

## Number Cards

Stats/metrics display in a 4-column grid.

```html
<div class="numbers-grid stagger">
  <div class="number-card">
    <div class="number-icon"><i class="fa-solid fa-users"></i></div>
    <div class="big-number">25</div>
    <div class="number-label">Team Members</div>
  </div>
</div>
```

```css
.numbers-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 24px; max-width: 900px; width: 100%; }
.number-card { text-align: center; padding: 28px 16px; background: var(--white); border-radius: 16px; border: 1px solid var(--gray-200); }
.number-card .big-number { font-size: 56px; font-weight: 700; color: var(--purple); line-height: 1; }
.number-card .number-label { font-size: 16px; color: var(--gray-600); margin-top: 8px; font-weight: 500; }
.number-card .number-icon { font-size: 24px; color: var(--purple-light); margin-bottom: 8px; }
```

---

## Staff Cards

Larger profile cards for leadership/key people.

```html
<div class="staff-grid stagger">
  <div class="staff-card">
    <div class="staff-avatar"><img src="photos/name.png" alt="Name"></div>
    <h4>Person Name</h4>
    <p><i class="fa-solid fa-icon" style="color:var(--purple);"></i> Title</p>
  </div>
</div>
```

```css
.staff-grid { display: flex; gap: 24px; justify-content: center; flex-wrap: wrap; }
.staff-card { background: var(--white); border: 1px solid var(--gray-200); border-radius: 16px; padding: 32px 36px; text-align: center; min-width: 220px; transition: transform 0.3s ease; }
.staff-card:hover { transform: translateY(-4px); }
.staff-avatar { width: 72px; height: 72px; border-radius: 50%; margin: 0 auto 14px; overflow: hidden; background: var(--gray-200); }
.staff-avatar img { width: 100%; height: 100%; object-fit: cover; border-radius: 50%; }
.staff-card h4 { font-size: 18px; font-weight: 700; color: var(--gray-800); }
.staff-card p { font-size: 15px; color: var(--gray-600); margin-top: 4px; }
```

---

## Overview Grid (Compact)

Dense overview grid for showing many items at once (e.g., all teams on one slide).

```html
<div class="full-overview stagger" style="grid-template-columns: repeat(4, 1fr);">
  <div class="overview-squad" style="border-left-color: var(--purple);">
    <div class="overview-squad-title"><i class="fa-solid fa-gears"></i> Team Name</div>
    <div class="overview-members">
      <div class="ov-member"><span class="ov-dot" style="background:var(--accent-blue);"></span>Name <span class="ov-role">Role</span></div>
    </div>
  </div>
</div>
```

```css
.full-overview { display: grid; grid-template-columns: repeat(3, 1fr); gap: 12px; max-width: 1120px; width: 100%; }
.overview-squad { border-radius: 10px; overflow: hidden; background: var(--gray-50); border-left: 3px solid var(--gray-200); }
.overview-squad-title { padding: 10px 18px 6px; font-size: 14px; font-weight: 800; color: var(--gray-800); display: flex; align-items: center; gap: 8px; }
.overview-squad-title i { font-size: 12px; opacity: 0.6; }
.overview-members { padding: 4px 14px 10px; }
.ov-member { display: flex; align-items: center; gap: 8px; font-size: 12px; font-weight: 600; color: var(--gray-600); padding: 2px 0; }
.ov-dot { width: 7px; height: 7px; border-radius: 50%; flex-shrink: 0; }
.ov-role { margin-left: auto; font-size: 14px; font-weight: 500; color: var(--gray-400); }
```

Use `grid-column: span N` for items that should stretch across multiple columns (e.g., a full-width section).

---

## Squad Overview Cards (Colored)

Gradient-background cards for high-level team overviews.

```html
<div class="squads-overview stagger">
  <div class="squad-overview-card bg-engops">
    <div class="card-icon"><i class="fa-solid fa-gears"></i></div>
    <h3>Team Name</h3>
    <div class="count">7 <span>members</span></div>
    <div class="desc">Brief description</div>
  </div>
</div>
```

```css
.squads-overview { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; max-width: 1100px; width: 100%; }
.squad-overview-card { border-radius: 16px; padding: 28px 24px; color: var(--white); position: relative; overflow: hidden; transition: transform 0.3s ease; }
.squad-overview-card:hover { transform: translateY(-4px); }
.squad-overview-card::after { content: ''; position: absolute; top: -30%; right: -20%; width: 120px; height: 120px; border-radius: 50%; background: rgba(255,255,255,0.08); }
.squad-overview-card h3 { font-size: 20px; font-weight: 700; margin-bottom: 6px; }
.squad-overview-card .count { font-size: 36px; font-weight: 700; opacity: 0.9; }
.squad-overview-card .count span { font-size: 16px; font-weight: 400; opacity: 0.8; }
.squad-overview-card .desc { font-size: 14px; opacity: 0.85; margin-top: 8px; line-height: 1.5; }
.squad-overview-card .card-icon { position: absolute; top: 20px; right: 20px; font-size: 28px; opacity: 0.2; }
```

---

## Hierarchy Layout

Organized sections with labels and connector lines.

```html
<div class="hierarchy">
  <div class="hierarchy-section fade-up">
    <div class="hierarchy-label"><i class="fa-solid fa-crown"></i> Leadership</div>
    <div class="members-row stagger">
      <!-- member-card elements -->
    </div>
  </div>
  <div class="hierarchy-connector"></div>
  <div class="hierarchy-section fade-up">
    <div class="hierarchy-label"><i class="fa-solid fa-code"></i> Engineering</div>
    <div class="members-row stagger">
      <!-- member-card elements -->
    </div>
  </div>
</div>
```

```css
.hierarchy { max-width: 1100px; width: 100%; }
.hierarchy-section { margin-bottom: 16px; }
.hierarchy-label { font-size: 12px; font-weight: 700; letter-spacing: 3px; text-transform: uppercase; color: var(--gray-400); margin-bottom: 10px; padding-left: 4px; }
.hierarchy-connector { width: 2px; height: 14px; background: var(--gray-200); margin: 0 auto; }
```

---

## Role Legend

```html
<div class="role-legend fade-up">
  <div class="legend-item">
    <span class="legend-dot" style="background: var(--accent-blue);"></span> Backend
  </div>
  <div class="legend-item">
    <span class="legend-dot" style="background: var(--accent-teal);"></span> Frontend
  </div>
</div>
```

```css
.role-legend { display: flex; gap: 16px; justify-content: center; flex-wrap: wrap; padding: 14px 24px; background: var(--gray-50); border-radius: 12px; border: 1px solid var(--gray-200); max-width: 800px; width: 100%; }
.legend-item { display: flex; align-items: center; gap: 8px; font-size: 14px; font-weight: 600; color: var(--gray-600); }
.legend-dot { width: 12px; height: 12px; border-radius: 3px; }
```

---

## Tags & Badges

```html
<!-- Squad tags -->
<div class="squad-tags fade-up">
  <span class="squad-tag" style="background: var(--purple-subtle); color: var(--purple);">
    <i class="fa-solid fa-tag"></i> Tag Label
  </span>
</div>

<!-- Role badge -->
<span class="role-badge" style="background: var(--accent-blue);">Senior</span>

<!-- Level badge -->
<span class="level-badge">L3</span>
```

---

## Timeline

Used on cover slides for roadmaps/next steps.

**Alignment rule**: Use an even-width line (2px) so all centers land on whole pixels. Position dots with `transform: translateX(-50%)` for automatic centering regardless of dot size. Use `box-sizing: border-box` on dots so `width` includes border.

```html
<div style="max-width: 700px; width: 100%; text-align: left;">
  <div class="section-label fade-up" style="color: rgba(255,255,255,0.7);"><i class="fa-solid fa-route"></i> Section</div>
  <h2 class="slide-title fade-up" style="color: var(--white); text-align: left;">Title</h2>
</div>
<div class="stagger" style="display: flex; flex-direction: column; gap: 0; max-width: 700px; width: 100%; position: relative; padding-left: 40px;">
  <!-- Timeline line — 2px wide, center at left+1=15px -->
  <div style="position: absolute; left: 14px; top: 10px; bottom: 10px; width: 2px; background: linear-gradient(to bottom, #00E68D, rgba(255,255,255,0.3)); border-radius: 2px;"></div>
  <!-- Past item (green dot) -->
  <div style="display: flex; align-items: flex-start; gap: 24px; padding: 16px 0; position: relative;">
    <div style="position: absolute; left: -25px; top: 20px; width: 16px; height: 16px; background: #00E68D; border-radius: 50%; border: 3px solid rgba(255,255,255,0.3); z-index: 1; box-sizing: border-box; transform: translateX(-50%); box-shadow: 0 0 12px rgba(0,230,141,0.5);"></div>
    <div style="text-align: left;">
      <div style="font-size: 12px; font-weight: 700; color: #00E68D; text-transform: uppercase; letter-spacing: 2px;">Done</div>
      <div style="font-size: 15px; color: rgba(255,255,255,0.8); margin-top: 6px;">Description</div>
    </div>
  </div>
  <!-- Current item (larger white dot with green border) -->
  <div style="display: flex; align-items: flex-start; gap: 24px; padding: 16px 0; position: relative;">
    <div style="position: absolute; left: -25px; top: 18px; width: 20px; height: 20px; background: #FFFFFF; border-radius: 50%; border: 3px solid #00E68D; z-index: 1; box-sizing: border-box; transform: translateX(-50%); box-shadow: 0 0 16px rgba(0,230,141,0.6);"></div>
    <div style="text-align: left;">
      <div style="font-size: 12px; font-weight: 700; color: #FFFFFF; text-transform: uppercase; letter-spacing: 2px;">Now</div>
      <div style="font-size: 15px; color: rgba(255,255,255,0.9); margin-top: 6px; font-weight: 500;">Description</div>
    </div>
  </div>
  <!-- Future item (muted dot) -->
  <div style="display: flex; align-items: flex-start; gap: 24px; padding: 16px 0; position: relative;">
    <div style="position: absolute; left: -25px; top: 20px; width: 16px; height: 16px; background: rgba(255,255,255,0.5); border-radius: 50%; border: 3px solid rgba(255,255,255,0.3); z-index: 1; box-sizing: border-box; transform: translateX(-50%);"></div>
    <div style="text-align: left;">
      <div style="font-size: 12px; font-weight: 700; color: rgba(255,255,255,0.7); text-transform: uppercase; letter-spacing: 2px;">Future</div>
      <div style="font-size: 15px; color: rgba(255,255,255,0.8); margin-top: 6px;">Description</div>
    </div>
  </div>
</div>
```

---

## Quote Slide

```html
<div class="slide" data-slide="1" style="background: #00E68D; color: var(--gray-800); display: flex; align-items: center; justify-content: center;">
  <div class="cover-content" style="max-width: 800px; text-align: center;">
    <div class="fade-up" style="font-size: 28px; opacity: 0.4; margin-bottom: 40px;">
      <i class="fa-solid fa-quote-left"></i>
    </div>
    <blockquote class="fade-up" style="font-size: clamp(28px, 3.5vw, 48px); font-weight: 500; font-style: italic; line-height: 1.5; letter-spacing: 0.5px;">
      Quote text with <span style="font-weight: 700; border-bottom: 2px solid rgba(0,0,0,0.25);">emphasized words</span>.
    </blockquote>
    <cite class="fade-up" style="display: block; margin-top: 36px; font-size: 16px; font-weight: 600; opacity: 0.6; font-style: normal;">
      — Author Name
    </cite>
  </div>
</div>
```

---

## Closing Slide

Same structure as cover slide but with closing content:

```html
<div class="slide cover" data-slide="N">
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
