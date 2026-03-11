---
description: Generate visual slides from an Obsidian article for 小红书 video recording
---

# Generate Video Slides

This workflow converts an Obsidian markdown article into beautiful vertical slides (3:4) optimized for 小红书 video.

## Prerequisites

- Node.js installed
- Dependencies installed in `slides-generator/` (run `npm install` if not)

## Workflow Steps

1. **Prepare your article**: Have your Obsidian markdown article ready (with text and screenshots).

2. **Provide the article**: Either:
   - Share the file path: "帮我用这篇文章生成幻灯片：`/path/to/article.md`"
   - Or paste the content directly in chat

3. **AI generates slides**: The AI will use the `generate-slides` skill to:
   - Analyze your article structure
   - Split content into well-paced slides
   - Generate Mermaid diagrams for key concepts
   - Add presenter notes for your reference
   - Save the result to `slides-generator/slides.md`

// turbo
4. **Preview the slides**: Run the dev server to preview:
   ```bash
   cd /Users/haoyangs/.gemini/antigravity/playground/glowing-aphelion/slides-generator && npm run dev
   ```

5. **Review and iterate**: Check the slides in your browser and request any changes.

// turbo
6. **Export to PNG**: When satisfied, export:
   ```bash
   cd /Users/haoyangs/.gemini/antigravity/playground/glowing-aphelion/slides-generator && npm run build
   ```

7. **Use in video**: The PNG files in `slides-generator/output/` are ready to use in your video recording.

## Tips

- **Content type badge**: The cover slide uses badges like `学习心得`, `项目进展`, `技术分享` — tell the AI which type your content is.
- **Image handling**: If your article references Obsidian attachments, make sure the image files are accessible from the path provided.
- **Customization**: You can edit `slides-generator/slides.md` directly — it's just Markdown!
- **Theme**: To modify colors/styles, edit `slides-generator/theme/styles/index.css`.
