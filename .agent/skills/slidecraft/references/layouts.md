# Layout Reference — Slidev 小红书 Theme (4:3 Horizontal)

Complete syntax and examples for all available layouts.

---

## Headmatter (First Slide Config)

```yaml
---
theme: ./theme
title: [Article Title]
aspectRatio: 4/3
canvasWidth: 1440
favicon: false
drawings:
  enabled: false
---
```

---

## Layout: `cover`

**Use for**: First slide only. Title + subtitle + category badge.

```markdown
---
layout: cover
badge: 学习心得
author: Build in Public
date: 2026-03-10
---

# 我如何用 AI 加速开发效率

从工具选型到实际落地的完整心路历程
```

Attributes:
- `badge` — Category pill (学习心得 / 项目进展 / 技术分享)
- `author` — Bottom-left credit
- `date` — Bottom-right date (YYYY-MM-DD)

---

## Layout: `section`

**Use for**: Topic transitions between major sections.

```markdown
---
layout: section
---

## 🧭 背景

为什么我开始探索 AI 辅助开发？
```

Rules:
- Max 1 emoji in the heading
- Optional 1-line subtitle below heading
- Keep it short — this is a "pause and breathe" slide

---

## Layout: `content`

**Use for**: Main content. Text, bullets, images, tables, code, blockquotes.

### Variant A: Bullets

```markdown
---
layout: content
---

## 遇到的问题

在日常开发中，有几个反复出现的痛点：

- **重复性工作太多** — 每次都要写类似的模板代码
- **上下文切换成本高** — 文档、调试、代码来回切换
- **学习新技术效率低** — 官方文档不够直观

> 这些痛点让我开始思考：能否让 AI 帮我分担？
```

### Variant B: Image

```markdown
---
layout: content
---

## 界面对比

重构前后的 UI 变化：

![重构后的新界面](/screenshot-new-ui.png)

关键改进：圆角卡片 + 深色模式 + 动态渐变
```

### Variant C: Table

```markdown
---
layout: content
---

## 效率对比

| 任务 | 手动耗时 | AI 辅助 | 节省 |
|------|---------|---------|------|
| 项目初始化 | 2-3小时 | 15分钟 | **85%** |
| 写测试 | 1-2小时 | 20分钟 | **75%** |
```

### Variant D: Code Block

```markdown
---
layout: content
---

## 关键代码

核心配置只需几行：

\```typescript
const config = {
  theme: './theme',
  aspectRatio: '4/3',
  canvasWidth: 1440
}
\```

这就是 Slidev 的魅力 — 简单直接
```

---

## Layout: `diagram`

**Use for**: Mermaid charts. Processes, architectures, mind maps.

```markdown
---
layout: diagram
---

## 解决思路

\```mermaid
graph TD
    A[识别重复任务] --> B[设计 Prompt 模板]
    B --> C[测试 & 迭代]
    C --> D[封装为 Workflow]
    D --> E[日常使用]
    E --> C
\```

通过不断迭代，把 AI 融入工作流的每个环节
```

Supported Mermaid types:
- `graph TD` — Vertical flow (processes, step-by-step)
- `graph LR` — Horizontal flow (pipelines)
- `sequenceDiagram` — Component interactions
- `mindmap` — Concept maps
- `pie` — Proportion data

Rules:
- Max 6 nodes per diagram
- Keep node labels short (max 8 characters)
- One explanatory sentence below the diagram

---

## Layout: `summary`

**Use for**: Last slide. Key takeaways + call to action.

```markdown
---
layout: summary
cta: 关注获取更多 AI 开发实践
---

## 本期总结

- AI 辅助开发的核心是**流程化**和**模板化**
- 好的 Prompt 模板可以节省 **70%+** 重复工作时间
- 关键在于持续迭代，而非一次性使用
- 把经验沉淀为 **可复用的 Workflow**
- Build in Public，让更多人受益
```

Attributes:
- `cta` — Call-to-action button text at bottom

Rules:
- 4–6 takeaway bullets
- Each starts with a key noun, not a verb
- Bold the most important phrase in each bullet

---

## Slide Separator

Use `---` on its own line between slides:

```markdown
---
layout: content
---

## Slide N content

---
layout: content
---

## Slide N+1 content
```

---

## Presenter Notes

Add at the **end** of each slide as HTML comments:

```markdown
## Slide Title

Content...

<!-- 
讲解提示：
- 先介绍 X 的背景
- 然后解释为什么这很重要
- 引出下一页
-->
```

---

## Image Handling

For Obsidian `![[image.png]]` embeds:
1. Convert to standard markdown: `![description](/image.png)`
2. Copy image to `slides-generator/public/`
3. Reference with leading `/` (maps to `public/` folder)

Common Obsidian attachment locations:
- `attachments/`, `assets/`, `images/`
- Same directory as the article
