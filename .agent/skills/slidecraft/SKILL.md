---
name: slidecraft
description: Generate beautiful horizontal slides (4:3) from Obsidian markdown articles for 小红书 video recording. Use when the user mentions slides, 幻灯片, PPT, presentation, 小红书 video, visual content for video, or wants to convert their notes/articles into presentation format for recording. Also use when the user provides an Obsidian article path and wants visual content generated.
metadata:
  author: haoyangs
  version: "5.0"
compatibility: Requires Node.js, npm. Slidev project at slides-generator/ must have dependencies installed.
---

# Generate 小红书 Video Slides

Convert Obsidian markdown articles into stunning Slidev presentations optimized for 小红书 horizontal video (4:3, 1440×1080px, recording viewport 836×627px).

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
| **Highlight** | **Orange** | **`#E8740C`** | **Keyword highlighting in titles** |
| Tertiary | Indigo | `#3F3BBB` | Section 2, variety accent |
| Accent | Teal | `#00838F` | Section 3, variety accent |
| Contrast | Coral | `#C62828` | Bad/wrong side in comparisons |
| Background | White | `#FFFFFF` | Main slide bg |
| Card bg | Light gray | `#F2F2F7` | Card/pill backgrounds |
| Text | Charcoal | `#1D1D1F` | Primary text |
| Text sub | Dark gray | `#3A3A3C` | Body text |
| Category label | Medium gray | `#8E8E93` | Category subtitles above headings |

### Automatic Color Variation (White Background)

All slide backgrounds are **pure white** `#FFFFFF`. Color variety is applied to elements:

- **Bold text** → renders in emerald green (primary accent)
- **Keyword highlights** → renders in orange `#E8740C` (use `<span class="highlight">关键词</span>`)
- **List items** → iOS white cards `#FFFFFF` on gray `#EBEBF0` bg, multi-layer shadow, border-radius 16px, left-aligned
- **List item bold keywords** → alternating accent colors: emerald → indigo → amber → teal
- **Blockquotes** → serif font (Noto Serif SC), white card with shadow, decorative `"` mark
- **Feature cards** → white card on gray bg, border-radius 18px, subtle shadow
- **Table headers** → emerald background
- **Section subtitles** → emerald green text on white background
- **Category labels** → small gray text above headings

### Typography System

**Font Stack** (loaded via Google Fonts `@import` in theme CSS):
- **Titles (h1, h2, h3)**: `Noto Serif SC` weight 900/700 — gives titles authority and elegance
- **Body text, labels**: `Noto Sans SC` weight 300/400/500 — clean and readable
- **Monospace**: `JetBrains Mono` — code blocks, technical labels

Every content slide should have a clear **3-level hierarchy**:

| Level | Element | Style | Example |
|-------|---------|-------|---------|
| L1 — Category | Small label above title | Gray `#8E8E93`, 36px, letter-spacing 0.15em | `核心方法` `产品思维` |
| L2 — Title | Main heading (serif) | Weight 700-900, 88px, with keywords in orange | `让产品自己<span class="highlight">说话</span>` |
| L3 — Body | Description text (sans) | Weight 400, 48px, dark gray `#3A3A3C` | 1-2 sentences max |

**Keyword Highlighting** — The single most impactful typography technique:
- In every title, identify 1-2 keywords that carry the core meaning
- Wrap them: `<span class="highlight">关键词</span>`
- They render in orange `#E8740C`, creating instant visual hierarchy
- Example: `让用户自己<span class="highlight">发现需求</span>`

**Category Labels** — Add context above the title:
- Use inline HTML: `<span class="category-label">核 心 方 法</span>`
- Add spaces between characters for the letter-spacing effect
- Renders as small, spaced-out gray text above h2
- Gives each slide a "section identity" without a full section divider

### Font Sizes (for 836×627 recording viewport)

| Element | Font | Weight | Canvas px | Appears as |
|---------|------|--------|----------|------------|
| h1 title | Noto Serif SC | 900 | 110px | ~64px |
| h2 heading | Noto Serif SC | 700 | 88px | ~51px |
| h3 subhead | Noto Serif SC | 700 | 60px | ~35px |
| Category label | Noto Sans SC | 400 | 36px | ~21px |
| Body text (p) | Noto Sans SC | 400 | 48px | ~28px |
| List items (li) | Noto Sans SC | 400 | 42px | ~24px |
| Card body | Noto Sans SC | 300 | 32px | ~19px |

> These sizes are calibrated for a 1440×1080 canvas displayed at 836×627.

---

## Core Principles

1. **One Point Per Slide** — Each slide communicates exactly ONE idea
2. **Visual Every Slide** — Use AI images, tables, or blockquotes. NO text-only slides
3. **AI Image Generation** — For abstract concepts, generate illustrations with `generate_image`
4. **Narrative Arc** — Problem → Exploration → Insight → Takeaway
5. **Center Alignment** — All content centered
6. **Bottom-Right Safe Zone** — Bottom-right corner reserved for face camera overlay. All layouts use `padding-bottom: 240px` and `padding-right: 280px` (in 1440×1080 canvas coordinates) to keep content clear of this zone. Images use `max-width: 75%` to prevent overflow into the safe zone. NO text, images, or interactive elements may appear in the bottom-right safe zone of any slide
7. **Unified Colors** — Only use colors from the Apple Design System table above

### Animation Philosophy

All animations are **entrance-only** (no hover effects). Reason: slides are screen-recorded for 小红书 video — there is no mouse interaction during playback.

Before adding any animation, ask:
1. Does it help the audience **follow the content flow**? (e.g., staggered card reveals guide reading order)
2. Does it signal **content hierarchy**? (e.g., title drops in first, then body)
3. Does it create **visual rhythm**? (e.g., consistent transition between slides)

If the answer is "no" to all three → **don't add it.**

| Animation | Element | Purpose | Timing |
|-----------|---------|--------|--------|
| Fade-up | Entire slide | Signals new content | 0.7s expo ease-out |
| Drop-in | Title (h2) | Establishes topic first | 0.6s, delay 0.1s |
| Category fade | Category label (.category-label) | Appears before title | 0.4s, delay 0s |
| Text fade | Body text (p) | Subtle content appear | 0.5s, delay 0.15s |
| Staggered reveal | List items (li) | Guides reading order | 0.5s each, stagger 0.12s |
| Slide-in-left | Blockquote | Draws attention to quote | 0.7s, delay 0.2s |
| Scale-in | Image | Draws eye to visual | 0.6s, from 0.92 → 1.0, delay 0.2s |
| Card grid stagger | Feature cards (.feature-card) | 3 cards appear L→R | 0.5s each, stagger 0.15s |

## Content Density Limits

**NON-NEGOTIABLE:**
- Title: 1 line, max 12 Chinese characters (with 1-2 keywords highlighted)
- Bullets: max 3 items, each max 15 characters
- Body text: max 2 short sentences
- Images: max 1 per slide (except image grid layout)
- Infographic diagrams: max 5 nodes
- Emoji per slide: max 3 distinct emoji

If content exceeds limits → split into multiple slides.

### Emoji / Icon Usage Guide

Emoji serve as **lightweight icons** — visual anchors that guide the eye without needing AI-generated images.

| Position | Usage | Example |
|----------|-------|---------|
| Card title prefix | Marks each feature card | 🧬 自演化引擎 |
| List item prefix | Optional visual variety | 🎯 明确目标 |
| Section marker | In h2 headings | 🔧 工具 |

**Rules:**
- Max 1 emoji per title, max 1 per list item
- Emoji must be **semantically relevant** to content (not decoration)
- Prefer concrete emoji (🔧🎯📱) over abstract (✨💫🌟)
- Feature card grids should use emoji consistently (all cards have one, or none do)

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
| `cover` | First slide only. Title + subtitle ONLY (no badge, no author, no date). Title MUST use `<span class="highlight">` on the most important keyword (renders orange) to create visual hierarchy |
| `section` | Topic transitions. Large centered heading |
| `content` | Text + AI image/infographic, bullets, blockquotes |
| `summary` | Last slide. Key takeaways ONLY (no CTA button). Do NOT use generic headings like "本期总结" / "Summary" — instead use a thematic closing phrase that echoes the topic (e.g. "从接龙到 Agent") or omit the H2 entirely and let the takeaway list speak for itself |

> [!CAUTION]
> Do NOT use `diagram` layout or Mermaid.js. Mermaid produces visually poor diagrams that don't match our premium aesthetic. Use AI-generated infographic images instead for ALL logic, structure, and comparison illustrations.

**Rules:**
- Never use the same layout 3× in a row
- At least 4 slides must contain AI-generated images (concept + infographic)
- ALL logic diagrams, mindmaps, comparisons, and flowcharts → AI-generated images
- Each slide with an image should have ONLY the title + image (+ optional 1-line caption)

### Recommended Layout Patterns (within `content` layout)

These are **compositional patterns** achieved within the `content` layout using markdown + inline HTML. Choose the right pattern for each slide's purpose:

#### Pattern A — Split Text + Image (左文右图)
**When**: Feature explanation, product demo, process walkthrough.

Left side: category label + title + body text + optional bullet/card list.
Right side: phone screenshot, product image, or AI illustration.

```markdown
---
layout: content
---

<span class="category-label">核 心 功 能</span>

## 让 AI <span class="highlight">自动总结</span>

把每天的对话记录发给 AI，它会自动提炼出关键要点和行动项。

<div class="split-layout">
<div class="split-text">

- 🎯 **自动提炼** — 从对话中抽取关键信息
- 📝 **结构化输出** — 生成标准格式笔记  
- 🔄 **每日更新** — 无需手动整理

</div>
<div class="split-image">

![产品截图](/images/demo-screenshot.png)

</div>
</div>
```

#### Pattern B — Feature Card Grid (功能卡片网格)
**When**: Summarizing 3 features/concepts side by side.

```markdown
---
layout: content
---

<span class="category-label">产 品 能 力</span>

## 三大<span class="highlight">核心能力</span>

这些功能让你的工作流彻底升级——

<div class="card-grid">
<div class="feature-card">

🧬 **自动分析**

AI 审查日志，自动发现模式

</div>
<div class="feature-card">

💊 **经验封装**

成功经验打包为可复用模板

</div>
<div class="feature-card">

🌐 **全网共享**

一人优化，所有人受益

</div>
</div>
```

#### Pattern C — Image Gallery Grid (图片网格展示)
**When**: Showing a collection (stickers, screenshots, portfolio, before/after comparisons).

```markdown
---
layout: content
---

<span class="category-label">成 果 展 示</span>

## 生成的<span class="highlight">表情包</span>集合

<div class="image-grid cols-3">

![表情1](/images/sticker-1.png)
![表情2](/images/sticker-2.png)
![表情3](/images/sticker-3.png)
![表情4](/images/sticker-4.png)
![表情5](/images/sticker-5.png)
![表情6](/images/sticker-6.png)

</div>
```

> [!TIP]
> Pattern A is the most versatile and impactful — use it as your **default** for content slides. Fall back to plain centered layout only when the content doesn't have an accompanying visual.

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
aspectRatio: 4/3
canvasWidth: 1440
favicon: false
drawings:
  enabled: false
---
```

> [!CAUTION]
> Do NOT use a separate `--- layout: cover ---` block after the frontmatter. Put `layout: cover` INSIDE the frontmatter to avoid a blank first page.

### AI Image Generation (ALL Visual Diagrams)

Use `generate_image` for ALL visual needs — concepts, comparisons, mindmaps, flowcharts.

#### Illustration Style Consistency

All AI-generated images within the **same presentation** must share a consistent visual style. Pick ONE style prefix and use it for every image in that deck.

**The goal**: Images should feel like refined, premium editorial illustrations — vivid and alive, yet elegant and sophisticated. Think high-end magazine art direction with warm, humanistic tones. Avoid generic clip-art simplicity.

**Style Prefix A — Editorial Illustration (default, STRONGLY preferred):**
```
"Refined editorial illustration with sophisticated color palette.
Use premium tones: warm ochre, slate blue, sage green, dusty rose,
charcoal gray, and muted gold. Clean white or warm off-white background.
No text. Detailed with subtle textures and depth. Feels like a
premium magazine illustration. Artistic and vivid yet elegant.
Landscape 4:3 aspect ratio."
```

**Style Prefix B — Soft 3D:**
```
"Soft 3D rendered illustration with premium material aesthetic.
Matte finish surfaces in sage green, warm gray, dusty blue, and cream.
Subtle ambient occlusion shadows. Clean composition on light background.
No text. Feels like a premium product render. Landscape 4:3 aspect ratio."
```

**⛔ BANNED styles** — Do NOT use these:
- Neon glow / particle effects / holographic digital art
- Dark silhouette with glowing outlines
- Futuristic cyber / tech-forward aesthetic
- Generic stock photo / clip-art
- Any style that looks "AI-generated generic" or "cheap digital"

**Color philosophy**: Use sophisticated, curated color combinations — NOT random bright neon. Think:
- Warm ochre + slate blue + charcoal (elegant contrast)
- Sage green + dusty rose + muted gold (refined harmony)
- Deep teal + warm gray + burnt sienna (premium editorial)

Prepend the chosen style prefix to every image prompt for the deck.

#### Image Prompt Templates

**Template 1 — Concept illustration:**
```
"[Style Prefix] [concept visual metaphor].
Landscape 4:3 aspect ratio."
```

**Template 2 — Comparison / Before-After:**
```
"[Style Prefix] Split comparison infographic.
LEFT side in red/gray: [old way label] with X mark,
shows [old way icon + steps]. Arrow pointing to [bad outcome].
RIGHT side in emerald green: [new way label] with checkmark,
shows [new way icon + steps]. Arrow pointing to [good outcome].
Landscape 4:3 aspect ratio."
```

**Template 3 — Mindmap / Structure:**
```
"[Style Prefix] Clean infographic mindmap.
Center circle shows [core concept].
Four branches extend to four rounded cards, each with
an icon and label: [branch1], [branch2], [branch3], [branch4].
Landscape 4:3 aspect ratio."
```

**Template 4 — Scene illustration (NEW):**
```
"[Style Prefix] A person [doing action related to slide topic],
[setting: at desk / in coffee shop / standing at whiteboard].
Showing [key element: laptop screen / notebook / phone].
Warm, inviting atmosphere. Landscape 4:3 aspect ratio."
```
Use for narrative/storytelling slides where a human context makes the concept relatable.

**Template 5 — Icon set (NEW):**
```
"[Style Prefix] A clean set of 4 icons arranged in a 2x2 grid:
[icon1 description], [icon2 description],
[icon3 description], [icon4 description].
Each icon inside a rounded square. Uniform style.
Landscape 4:3 aspect ratio."
```
Use when the slide needs custom icons that emoji can't adequately represent.

Save to `slides-generator/public/images/[name].png`
Reference in slides as `![description](/images/[name].png)`

> [!IMPORTANT]
> Slides with infographic images should use `content` layout, NOT `diagram` layout.
> Include ONLY: h2 title + image + optional 1-line caption. No additional text to avoid overflow.

> [!TIP]
> For slides that just need a visual anchor (feature lists, bullet points), use **emoji** instead of generating a full AI image. Reserve `generate_image` for hero visuals, concept art, and diagrams.

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
- Emoji as section markers: 🎯 📱 🔧 💡 ✅ (max 1 per title, max 3 per slide)
- Bold key terms: `**关键词**` (renders in emerald green)
- **Keyword highlights**: `<span class="highlight">关键词</span>` (renders in orange — use in titles)
- **Category labels**: `<span class="category-label">标 签 名</span>` inline HTML above title (with spaces between chars)

---

## Phase 4: QA Verification

> **Assume there are problems. Your job is to find them.**

1. **Start server** — `cd slides-generator && npm run dev`
2. **Visual check** — Browser subagent at 836×627 viewport, screenshot each slide:
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

## Phase 5: Script Annotation (口播稿翻页标注)

After QA verification, return the user's **original script** with page-turn markers inserted at each slide transition point. This helps the user know exactly when to advance slides during video recording.

### Rules

1. **Do NOT modify** any of the user's original text — preserve it word-for-word
2. **Insert a page-turn marker** at each slide boundary using this format:

```
> ⏭️ 【翻页】
```

3. **Placement** — Insert the marker at the natural pause point in the script where the next slide should appear. This is typically:
   - After the user finishes discussing the current slide's topic
   - Before they begin introducing the next slide's topic
4. **Output format** — Return as a markdown artifact (e.g., `annotated_script.md`) with the full script text and markers
5. The marker must be on its own line, surrounded by blank lines above and below for visual clarity

### Example

```markdown
...这就是 Harness 的核心概念。

> ⏭️ 【翻页】

那么，为什么我们需要这套系统呢？...
```

---

## Common Mistakes

- ❌ Separate `layout: cover` block → Put it in frontmatter to avoid blank page 1
- ❌ Badge/author/date on cover → Cover is title + subtitle ONLY
- ❌ Cover title without highlight → MUST use `<span class="highlight">` on the key keyword in title
- ❌ CTA button on summary → Summary is key takeaways ONLY
- ❌ Generic "本期总结" heading on summary → Use thematic phrase or omit heading
- ❌ Mermaid.js for ANY diagram → Use AI-generated infographic images (ALWAYS)
- ❌ `diagram` layout → Use `content` layout with AI image
- ❌ Text-only slides → Add AI image, infographic, or emoji-based card grid
- ❌ Too much text on image slides → Title + image + 1-line caption max (prevents overflow)
- ❌ Random colors → Only Apple palette colors
- ❌ Small fonts → Use v4 font sizes
- ❌ Left-aligned → Everything centered (unless using split layout)
- ❌ Content in bottom-right → All layouts have `padding-bottom: 240px` and `padding-right: 280px` safe zone for face cam overlay
- ❌ Plain titles without hierarchy → Always use keyword `<span class="highlight">` in titles
- ❌ Inconsistent AI image styles → Use same style prefix for entire deck
- ❌ Neon glow / silhouette / holographic digital art style → Use Editorial Illustration style ONLY
- ❌ Decorative emoji → Only semantically relevant emoji
- ✅ AI images for concepts, comparisons, mindmaps, and flowcharts
- ✅ Bold accent on key terms (renders emerald green)
- ✅ Keyword highlight in titles (renders orange)
- ✅ Category labels above titles for context
- ✅ Feature card grids with emoji icons for multi-point slides
- ✅ Split text+image layout for feature/demo slides

---

## Supporting Files

| File | Purpose | When to Read |
|------|---------|-------------|
| [references/layouts.md](references/layouts.md) | Layout syntax with examples | Phase 2–3 |
| [scripts/build.sh](scripts/build.sh) | PNG export script | Phase 4 |
