# Navigation System

## UI Chrome

Place these elements before the `.slide-container`:

```html
<!-- Slide counter (top-left) -->
<div class="slide-counter">
  <span class="current" id="slideNum">01</span> / <span id="totalSlides">11</span>
</div>

<!-- Logo (top-center, visible on content slides only) -->
<div id="slideLogo" style="position: fixed; top: 28px; left: 50%; transform: translateX(-50%); z-index: 99; opacity: 0; transition: opacity 0.4s ease;">
  <img src="assets/logo-roxa.png" alt="Logo" style="height: 36px; opacity: 0.6; animation: heartbeat 1s ease-in-out infinite;">
</div>

<!-- Keyboard hint (top-right, visible only on first slide) -->
<div class="keyboard-hint">
  <kbd><i class="fa-solid fa-arrow-left"></i></kbd> <kbd><i class="fa-solid fa-arrow-right"></i></kbd> to navigate
</div>

<!-- Arrow buttons (sides) -->
<button class="nav-arrows left" onclick="prevSlide()">
  <div class="nav-arrow"><i class="fa-solid fa-chevron-left"></i></div>
</button>
<button class="nav-arrows right" onclick="nextSlide()">
  <div class="nav-arrow"><i class="fa-solid fa-chevron-right"></i></div>
</button>

<!-- Nav dots (bottom-center) -->
<div class="nav-bar" id="navBar"></div>
```

## CSS for UI Chrome

```css
.nav-bar {
  position: fixed; bottom: 30px; left: 50%; transform: translateX(-50%);
  display: flex; gap: 8px; z-index: 100;
  background: rgba(255,255,255,0.92); backdrop-filter: blur(12px);
  padding: 10px 20px; border-radius: 40px; box-shadow: 0 4px 24px rgba(0,0,0,0.1);
}

.nav-dot {
  width: 12px; height: 12px; border-radius: 50%;
  background: #CCCCCC; border: none; cursor: pointer;
  transition: all 0.3s ease; padding: 0;
  position: relative;
}
.nav-dot.active { background: var(--purple); width: 36px; border-radius: 6px; }
.nav-dot:hover:not(.active) { background: var(--purple-light); opacity: 0.6; }

/* ─── Slide Preview Tooltip ─── */
.nav-dot .slide-preview {
  position: absolute;
  bottom: calc(100% + 16px);
  left: 50%;
  transform: translateX(-50%) scale(0.92);
  width: 200px;
  height: 130px;
  background: transparent;
  border-radius: 10px;
  overflow: hidden;
  opacity: 0;
  pointer-events: none;
  transition: opacity 0.25s ease, transform 0.25s ease;
  box-shadow: 0 8px 32px rgba(0,0,0,0.25);
  z-index: 200;
}

.nav-dot:hover .slide-preview {
  opacity: 1;
  transform: translateX(-50%) scale(1);
}

.slide-preview-thumb {
  width: 100%;
  height: 100%;
  transform-origin: top left;
  pointer-events: none;
}

.slide-preview-label {
  position: absolute;
  bottom: 6px;
  left: 50%;
  transform: translateX(-50%);
  padding: 4px 12px;
  background: rgba(0,0,0,0.6);
  backdrop-filter: blur(8px);
  -webkit-backdrop-filter: blur(8px);
  font-size: 11px;
  font-weight: 500;
  color: #fff;
  letter-spacing: 0.3px;
  text-align: center;
  white-space: nowrap;
  border-radius: 20px;
  z-index: 2;
}

.nav-arrows {
  position: fixed; top: 50%; transform: translateY(-50%);
  z-index: 100; border: none; background: none; padding: 0;
}
.nav-arrows.left { left: 24px; }
.nav-arrows.right { right: 24px; }

.nav-arrow {
  width: 48px; height: 48px; border-radius: 50%;
  border: 2px solid var(--gray-200); background: rgba(255,255,255,0.85);
  backdrop-filter: blur(8px); cursor: pointer;
  display: flex; align-items: center; justify-content: center;
  transition: all 0.3s ease; color: var(--gray-600); font-size: 18px;
}
.nav-arrow:hover { border-color: var(--purple); color: var(--purple); transform: scale(1.1); }

.keyboard-hint {
  position: fixed; top: 24px; right: 24px; z-index: 100;
  background: rgba(255,255,255,0.88); backdrop-filter: blur(8px);
  padding: 8px 16px; border-radius: 10px; font-size: 12px;
  color: var(--gray-600); border: 1px solid var(--gray-200);
  transition: opacity 0.4s ease;
}
.keyboard-hint kbd {
  background: var(--gray-100); border: 1px solid var(--gray-200);
  border-radius: 4px; padding: 1px 6px; font-family: 'Quicksand', sans-serif;
  font-size: 11px; font-weight: 600;
}

.slide-counter {
  position: fixed; top: 24px; left: 24px; z-index: 100;
  font-size: 13px; font-weight: 600; color: var(--gray-400);
}
.slide-counter .current { color: var(--purple); font-size: 20px; }
```

## JavaScript

Each slide must have a `data-title` attribute with its display name for the preview tooltip:

```html
<div class="slide cover active" data-slide="0" data-title="Team Topologies">...</div>
<div class="slide" data-slide="1" data-title="Nietzsche">...</div>
<div class="slide" data-slide="2" data-title="Pensamos juntos">...</div>
```

If `data-title` is not set, the preview falls back to "Slide N".

```javascript
const slides = document.querySelectorAll('.slide');
const totalSlides = slides.length;
let currentSlide = 0;
let isAnimating = false;

// Generate nav dots with slide preview tooltips
const navBar = document.getElementById('navBar');
for (let i = 0; i < totalSlides; i++) {
  const dot = document.createElement('button');
  dot.className = 'nav-dot' + (i === 0 ? ' active' : '');
  dot.onclick = () => goToSlide(i);

  // Create preview tooltip
  const preview = document.createElement('div');
  preview.className = 'slide-preview';

  // Clone the slide as a scaled-down thumbnail (cover-fit)
  const thumb = document.createElement('div');
  thumb.className = 'slide-preview-thumb';
  const clone = slides[i].cloneNode(true);
  clone.classList.remove('active', 'exit-left', 'exit-right');
  const origBg = slides[i].style.background || (slides[i].classList.contains('cover') ? '#1B0A2E' : '#FFFFFF');
  clone.style.position = 'absolute';
  clone.style.top = '0';
  clone.style.left = '0';
  clone.style.width = '100vw';
  clone.style.height = '100vh';
  clone.style.opacity = '1';
  clone.style.pointerEvents = 'none';
  clone.style.transform = 'none';
  clone.style.display = 'flex';
  clone.style.background = origBg;
  // Make all animated elements visible in the thumbnail
  clone.querySelectorAll('.fade-up, .stagger, .stagger > *').forEach(el => {
    el.style.opacity = '1';
    el.style.transform = 'none';
    el.style.transition = 'none';
  });
  const scaleX = 200 / window.innerWidth;
  const scaleY = 130 / window.innerHeight;
  const coverScale = Math.max(scaleX, scaleY);
  thumb.style.width = window.innerWidth + 'px';
  thumb.style.height = window.innerHeight + 'px';
  thumb.style.transform = 'scale(' + coverScale + ')';
  thumb.style.transformOrigin = 'top center';
  thumb.style.position = 'absolute';
  thumb.style.top = '0';
  thumb.style.left = '50%';
  thumb.style.marginLeft = -(window.innerWidth / 2) + 'px';
  thumb.appendChild(clone);
  preview.appendChild(thumb);

  // Title label overlay (reads from data-title attribute)
  const label = document.createElement('div');
  label.className = 'slide-preview-label';
  label.textContent = slides[i].dataset.title || 'Slide ' + (i + 1);
  preview.appendChild(label);

  dot.appendChild(preview);
  navBar.appendChild(dot);
}

document.getElementById('totalSlides').textContent = String(totalSlides).padStart(2, '0');

// Initial state for cover slide counter
document.querySelector('.slide-counter').style.color = 'rgba(255,255,255,0.5)';
document.querySelector('.slide-counter .current').style.color = 'rgba(255,255,255,0.85)';

function goToSlide(index) {
  if (index < 0 || index >= totalSlides || index === currentSlide || isAnimating) return;
  isAnimating = true;

  const goingForward = index > currentSlide;
  const oldSlide = currentSlide;

  slides[oldSlide].classList.remove('active');
  slides[oldSlide].classList.add(goingForward ? 'exit-left' : 'exit-right');

  slides[index].style.transition = 'none';
  slides[index].classList.remove('exit-left', 'exit-right');
  slides[index].style.transform = goingForward ? 'translateX(80px)' : 'translateX(-80px)';
  slides[index].style.opacity = '0';

  void slides[index].offsetWidth;

  slides[index].style.transition = '';
  slides[index].classList.add('active');
  slides[index].style.transform = '';
  slides[index].style.opacity = '';

  currentSlide = index;

  // Update nav dots
  document.querySelectorAll('.nav-dot').forEach((d, i) => {
    d.classList.toggle('active', i === currentSlide);
  });

  // Update counter
  document.getElementById('slideNum').textContent = String(currentSlide + 1).padStart(2, '0');

  // Adapt counter color for dark/colored background slides
  const counter = document.querySelector('.slide-counter');
  const counterCurrent = document.querySelector('.slide-counter .current');
  const isCoverSlide = slides[currentSlide].classList.contains('cover');
  // Add data-slide values of any non-cover slides with colored backgrounds (e.g., quote slides)
  const isDarkBg = isCoverSlide || currentSlide === 0 || slides[currentSlide].dataset.slide === '1';
  if (isDarkBg) {
    counter.style.color = 'rgba(255,255,255,0.5)';
    counterCurrent.style.color = 'rgba(255,255,255,0.85)';
  } else {
    counter.style.color = '';
    counterCurrent.style.color = '';
  }

  // Show/hide logo on content slides (hidden on cover slides)
  document.getElementById('slideLogo').style.opacity = (currentSlide > 0 && !isCoverSlide) ? '1' : '0';

  // Keyboard hint visible only on first slide
  document.querySelector('.keyboard-hint').style.opacity = currentSlide === 0 ? '' : '0';
  document.querySelector('.keyboard-hint').style.pointerEvents = currentSlide === 0 ? '' : 'none';

  setTimeout(() => {
    slides[oldSlide].classList.remove('exit-left', 'exit-right');
    isAnimating = false;
  }, 500);
}

function nextSlide() { goToSlide(currentSlide + 1); }
function prevSlide() { goToSlide(currentSlide - 1); }

// Keyboard navigation
document.addEventListener('keydown', (e) => {
  if (e.key === 'ArrowRight' || e.key === ' ') { e.preventDefault(); nextSlide(); }
  if (e.key === 'ArrowLeft') { e.preventDefault(); prevSlide(); }
  if (e.key === 'Home') { e.preventDefault(); goToSlide(0); }
  if (e.key === 'End') { e.preventDefault(); goToSlide(totalSlides - 1); }
});

// Touch navigation
let touchStartX = 0;
document.addEventListener('touchstart', (e) => { touchStartX = e.touches[0].clientX; });
document.addEventListener('touchend', (e) => {
  const diff = touchStartX - e.changedTouches[0].clientX;
  if (Math.abs(diff) > 50) { diff > 0 ? nextSlide() : prevSlide(); }
});
```

## Slide Transition CSS

```css
.slide-container { position: relative; width: 100vw; height: 100vh; }

.slide {
  position: absolute; top: 0; left: 0;
  width: 100%; height: 100%;
  display: flex; flex-direction: column; align-items: center; justify-content: center;
  opacity: 0; pointer-events: none;
  transition: opacity var(--slide-transition), transform var(--slide-transition);
  padding: 40px 60px;
  transform: translateX(80px);
}

.slide.active { opacity: 1; transform: translateX(0); pointer-events: all; }
.slide.exit-left { opacity: 0; transform: translateX(-80px); }
.slide.exit-right { opacity: 0; transform: translateX(80px); }
```

## Animation CSS

```css
.fade-up {
  opacity: 0; transform: translateY(20px);
  transition: opacity 0.5s ease, transform 0.5s ease;
}
.active .fade-up { opacity: 1; transform: translateY(0); }
.active .fade-up:nth-child(1) { transition-delay: 0.1s; }
.active .fade-up:nth-child(2) { transition-delay: 0.2s; }
.active .fade-up:nth-child(3) { transition-delay: 0.3s; }
.active .fade-up:nth-child(4) { transition-delay: 0.4s; }
.active .fade-up:nth-child(5) { transition-delay: 0.5s; }
.active .fade-up:nth-child(6) { transition-delay: 0.6s; }
.active .fade-up:nth-child(7) { transition-delay: 0.7s; }

.stagger > * {
  opacity: 0; transform: translateY(16px);
  transition: opacity 0.4s ease, transform 0.4s ease;
}
.active .stagger > *:nth-child(1) { opacity: 1; transform: translateY(0); transition-delay: 0.1s; }
.active .stagger > *:nth-child(2) { opacity: 1; transform: translateY(0); transition-delay: 0.15s; }
.active .stagger > *:nth-child(3) { opacity: 1; transform: translateY(0); transition-delay: 0.2s; }
.active .stagger > *:nth-child(4) { opacity: 1; transform: translateY(0); transition-delay: 0.25s; }
.active .stagger > *:nth-child(5) { opacity: 1; transform: translateY(0); transition-delay: 0.3s; }
.active .stagger > *:nth-child(6) { opacity: 1; transform: translateY(0); transition-delay: 0.35s; }
.active .stagger > *:nth-child(7) { opacity: 1; transform: translateY(0); transition-delay: 0.4s; }
.active .stagger > *:nth-child(8) { opacity: 1; transform: translateY(0); transition-delay: 0.45s; }
.active .stagger > *:nth-child(9) { opacity: 1; transform: translateY(0); transition-delay: 0.5s; }
.active .stagger > *:nth-child(10) { opacity: 1; transform: translateY(0); transition-delay: 0.55s; }
```
