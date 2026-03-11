---
name: generate-slides
description: Generate beautiful vertical slides (3:4) from Obsidian markdown articles for 小红书 video recording. Use when the user mentions slides, 幻灯片, PPT, presentation, 小红书 video, visual content for video, or wants to convert their notes/articles into presentation format for recording. Also use when the user provides an Obsidian article path and wants visual content generated.
metadata:
  author: haoyangs
  version: "3.4"
compatibility: Requires Node.js, npm. Slidev project at slides-generator/ must have dependencies installed.
---

# Generate 小红书 Video Slides

Convert Obsidian markdown articles into stunning Slidev presentations optimized for 小红书 vertical video (3:4, 1080×1440px, recording viewport 627×836px).

## Quick Reference

| Task | Action |
|------|--------|
| Generate slides from article | Follow Phase 0–4 below |
| Preview slides | `cd slides-generator && npm run dev` |
| Export to PNG | `cd slides-generator && npm run build` |
| View layout syntax | Read [references/layouts.md](references/layouts.md) |

---

## Apple Multi-Color Design System

All slides use a curated, Apple-inspired multi-color palette. Colors are purposeful — each serves a **specific role**.

### Color Palette

| Role | Color | Hex | Usage |
|------|-------|-----|-------|
| Primary | Emerald | `#006B54` | Default accent, bold text, section 1 |
| Secondary | Amber | `#B35A00` | Blockquotes, warm highlights |
| Tertiary | Indigo | `#3F3BBB` | Section 2, variety accent |
| Accent | Teal | `#00838F` | Section 3, variety accent |
| Contrast | Coral | `#C62828` | Bad/wrong side in comparisons |
| Background | White | `#FFFFFF` | Main slide bg |
| Card bg | Light gray | `#F2F2F7` | Card/pill backgrounds |
| Text | Charcoal | `#1D1D1F` | Primary text |
| Text sub | Dark gray | `#3A3A3C` | Body text |

### Automatic Color Variation (White Background)

All slide backgrounds are **pure white** `#FFFFFF`. Color variety is applied to elements:

- **Bold text** → renders in emerald green (primary accent)
- **List items** → alternating left-border colors: emerald → indigo → amber → teal
- **Blockquotes** → warm amber background with amber left border
- **Table headers** → emerald background
- **Section subtitles** → emerald green text on white background

### Font Sizes (for 627×836 recording viewport)

| Element | Canvas px | Appears as |
|---------|----------|-----------|
| h1 title | 120px | ~70px |
| h2 heading | 88px | ~51px |
| Body text | 48px | ~28px |
| List items | 44px | ~26px |
| Badge / footer | 36px | ~21px |

> These sizes are calibrated for a 1080×1440 canvas displayed at 627×836.

---

## Core Principles

1. **One Point Per Slide** — Each slide communicates exactly ONE idea
2. **Visual Every Slide** — Use AI images, Mermaid diagrams, tables, or blockquotes. NO text-only slides
3. **AI Image Generation** — For abstract concepts, generate illustrations with `generate_image`
4. **Narrative Arc** — Problem → Exploration → Insight → Takeaway
5. **Center Alignment** — All content centered, right-bottom reserved for face camera overlay
6. **Unified Colors** — Only use colors from the Apple Design System table above

## Content Density Limits

**NON-NEGOTIABLE:**
- Title: 1 line, max 12 Chinese characters
- Bullets: max 3 items, each max 15 characters
- Body text: max 2 short sentences
- Images: max 1 per slide
- Infographic diagrams: max 5 nodes

If content exceeds limits → split into multiple slides.

---

## Phase 0: Detect Input Format

**Step 1 — Source:**
- **File path** → Read with `view_file`
- **Inline content** → Use directly
- **Obsidian images** (`![[img.png]]`) → Find with `find_by_name`, copy to `slides-generator/public/images/`

**Step 2 — Detect section separators:**

Check if the input contains `---` (horizontal rules) used as section dividers.

- **Sectioned input** → Each `---` boundary = 1 slide. Count separators to determine total pages.
- **Unsectioned input** → AI auto-structures the content into 8–12 slides.

> [!IMPORTANT]
> `---` is the standard Markdown horizontal rule AND Slidev's native slide separator.
> When user input contains `---`, treat each section as one slide page.
> The number of sections = the number of slides (plus cover + summary if not included).

---

## Phase 1: Analyze Article

### Mode A — Sectioned Input (has `---` separators)

When the user provides content with `---` dividers:

1. Split input by `---` → each segment = 1 slide
2. For each segment, determine:
   - **Text content** → slide body text (respect all content from that section)
   - **Visual type** → Does it need an AI image, infographic, or text-only?
   - **Layout** → `content` (most), `section` (if segment is just a heading), `summary` (last)
3. First segment → `cover` slide (title + subtitle)
4. Last segment → `summary` slide (if it contains takeaways)
5. Generate AI images for sections that describe abstract concepts or comparisons

### Mode B — Unsectioned Input (plain text/article)

When no `---` separators found:

Extract:
1. **Main topic** → Cover title + subtitle
2. **Content type** → 学习心得 / 项目进展 / 技术分享
3. **Key sections** → Section divider slides
4. **Core arguments** → Content slides
5. **Abstract concepts** → Candidates for AI image generation
6. **Processes/flows** → AI infographic diagram slides
7. **Conclusions** → Summary slide takeaways

---

## Phase 2: Plan Slide Structure

**Sectioned input** → Slide count = number of `---` sections. Follow user's structure exactly.
**Unsectioned input** → Target **8–12 slides** (2–5 min video). AI decides structure.

```
Cover → Section → Content(+image) → Content(+infographic) → Section → Content(+image) → Content(+infographic) → Content → Summary
```

| Layout | When to Use |
|--------|------------|
| `cover` | First slide only. Title + subtitle ONLY (no badge, no author, no date) |
| `section` | Topic transitions. Large centered heading |
| `content` | Text + AI image/infographic, bullets, blockquotes |
| `summary` | Last slide. Key takeaways ONLY (no CTA button) |

> [!CAUTION]
> Do NOT use `diagram` layout or Mermaid.js. Mermaid produces visually poor diagrams that don't match our premium aesthetic. Use AI-generated infographic images instead for ALL logic, structure, and comparison illustrations.

**Rules:**
- Never use the same layout 3× in a row
- At least 4 slides must contain AI-generated images (concept + infographic)
- ALL logic diagrams, mindmaps, comparisons, and flowcharts → AI-generated images
- Each slide with an image should have ONLY the title + image (+ optional 1-line caption)

---

## Phase 3: Generate slides.md

Save to: `slides-generator/slides.md`

### Headmatter (CRITICAL: Prevents Blank First Page)

The first slide's layout MUST be declared in the frontmatter. Otherwise Slidev creates a blank slide 1.

```yaml
---
theme: ./theme
title: [Article Title]
layout: cover
aspectRatio: 3/4
canvasWidth: 1080
favicon: false
drawings:
  enabled: false
---
```

> [!CAUTION]
> Do NOT use a separate `--- layout: cover ---` block after the frontmatter. Put `layout: cover` INSIDE the frontmatter to avoid a blank first page.

### AI Image Generation (ALL Visual Diagrams)

Use `generate_image` for ALL visual needs — concepts, comparisons, mindmaps, flowcharts.

**Template 1 — Concept illustration:**
```
"Minimalist flat illustration of [concept visual metaphor].
Clean white background, using only dark emerald green (#006B54)
and charcoal gray (#1D1D1F). No text. Simple geometric shapes.
Premium tech aesthetic. Square aspect ratio."
```

**Template 2 — Comparison / Before-After:**
```
"Split comparison infographic on white background.
LEFT side in red/gray: [old way label] with X mark,
shows [old way icon + steps]. Arrow pointing to [bad outcome].
RIGHT side in emerald green (#006B54): [new way label] with checkmark,
shows [new way icon + steps]. Arrow pointing to [good outcome].
Clean minimalist flat design, premium tech aesthetic. Square aspect ratio."
```

**Template 3 — Mindmap / Structure:**
```
"Clean infographic mindmap on white background.
Center circle shows [core concept].
Four branches extend to four rounded cards, each with
an icon and label: [branch1], [branch2], [branch3], [branch4].
Minimalist flat design, dark emerald green (#006B54)
and charcoal gray (#1D1D1F). Premium tech aesthetic. Square aspect ratio."
```

Save to `slides-generator/public/images/[name].png`
Reference in slides as `![description](/images/[name].png)`

> [!IMPORTANT]
> Slides with infographic images should use `content` layout, NOT `diagram` layout.
> Include ONLY: h2 title + image + optional 1-line caption. No additional text to avoid overflow.

### ~~Mermaid~~ (DEPRECATED)

> [!WARNING]
> Do NOT use Mermaid.js. It produces visually poor, unprofessional diagrams that clash with the premium slide aesthetic. Use AI-generated infographic images (Templates 2 & 3 above) instead.

### Presenter Notes

Add HTML comments at end of each slide:
```markdown
<!-- 
讲解提示：
- 先说 X...
- 然后引出 Y...
-->
```

### Writing Style

- **Chinese** for text (English for tech terms)
- **Casual, conversational**
- Emoji as section markers: 🎯 📱 🔧 💡 ✅ (max 1 per title)
- Bold key terms: `**关键词**`

---

## Phase 4: QA Verification

> **Assume there are problems. Your job is to find them.**

1. **Start server** — `cd slides-generator && npm run dev`
2. **Visual check** — Browser subagent at 627×836 viewport, screenshot each slide:
   - Text large enough for mobile video?
   - Colors match Apple palette?
   - Content centered?
   - Bottom-right clear for face cam?
   - AI images loading?
   - Mermaid Apple-themed?
3. **Content check** — Verify slides.md:
   - No placeholder text
   - Presenter notes on every slide
   - All images exist in `public/images/`
4. **Fix + re-verify** — Repeat until clean

---

## Common Mistakes

- ❌ Separate `layout: cover` block → Put it in frontmatter to avoid blank page 1
- ❌ Badge/author/date on cover → Cover is title + subtitle ONLY
- ❌ CTA button on summary → Summary is key takeaways ONLY
- ❌ Mermaid.js for ANY diagram → Use AI-generated infographic images (ALWAYS)
- ❌ `diagram` layout → Use `content` layout with AI image
- ❌ Text-only slides → Add AI image or infographic
- ❌ Too much text on image slides → Title + image + 1-line caption max (prevents overflow)
- ❌ Random colors → Only Emerald palette (#006B54)
- ❌ Small fonts → Use v3 font sizes
- ❌ Left-aligned → Everything centered
- ❌ No bottom padding → 200px for face cam
- ✅ AI images for concepts, comparisons, mindmaps, and flowcharts
- ✅ Bold accent on key terms (renders emerald green)

---

## Supporting Files

| File | Purpose | When to Read |
|------|---------|-------------|
| [references/layouts.md](references/layouts.md) | Layout syntax with examples | Phase 2–3 |
| [scripts/build.sh](scripts/build.sh) | PNG export script | Phase 4 |
