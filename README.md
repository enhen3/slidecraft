# SlideCraft 🎨

Generate beautiful vertical slides (3:4) from Obsidian markdown articles for 小红书 video recording.

An AI-powered skill that transforms your written content into premium, presentation-ready slides with Apple-inspired design aesthetics.

## Features

- **Apple Multi-Color Design System** — Curated 5-color palette (Emerald, Amber, Indigo, Teal, Coral)
- **AI-Generated Infographics** — Mindmaps, comparisons, and concept illustrations auto-generated
- **Optimized for 小红书** — 3:4 vertical aspect ratio, large readable text, face-cam safe zone
- **Slidev-Powered** — Vue.js layouts, hot-reload dev server, markdown-native workflow
- **Skill-Based** — Reusable, documented workflow for consistent slide generation

## Quick Start

```bash
cd slides-generator
npm install
npm run dev
```

Open `http://localhost:3030` (or assigned port) in browser at **627×836** viewport.

## Project Structure

```
.agent/skills/generate-slides/   # Skill definition
  SKILL.md                       # Full workflow documentation
  references/layouts.md          # Layout syntax reference
  scripts/build.sh               # PNG export script

slides-generator/                # Slidev project
  slides.md                      # Presentation content
  theme/                         # Custom theme
    styles/index.css              # Apple multi-color CSS
    layouts/                      # Vue.js slide layouts
      cover.vue
      content.vue
      section.vue
      summary.vue
  public/images/                  # AI-generated images
```

## Design System

| Color | Hex | Role |
|-------|-----|------|
| Emerald | `#006B54` | Primary accent, bold text |
| Amber | `#B35A00` | Blockquotes, warm highlights |
| Indigo | `#3F3BBB` | Variety accent |
| Teal | `#00838F` | Variety accent |
| Coral | `#C62828` | Contrast (comparisons) |

## How It Works

1. Provide your oral script / Obsidian article
2. The skill analyzes content and plans 8–12 slides
3. AI generates concept illustrations and infographic diagrams
4. Produces `slides.md` with presenter notes
5. Dev server renders premium slides at 627×836

## License

MIT
