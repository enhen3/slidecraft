#!/bin/bash
# ============================================
# XHS Slides Builder
# Builds Slidev slides and exports to PNG
# ============================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../../../../slides-generator" && pwd)"
OUTPUT_DIR="$PROJECT_DIR/output"

echo "🎨 XHS Slides Builder"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check if slides.md exists
if [ ! -f "$PROJECT_DIR/slides.md" ]; then
  echo "❌ Error: slides.md not found at $PROJECT_DIR/slides.md"
  echo "   Please generate slides first using the generate-slides skill."
  exit 1
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

echo "📦 Project: $PROJECT_DIR"
echo "📤 Output:  $OUTPUT_DIR"
echo ""

# Check if dependencies are installed
if [ ! -d "$PROJECT_DIR/node_modules" ]; then
  echo "📥 Installing dependencies..."
  cd "$PROJECT_DIR" && npm install --cache /tmp/.npm-cache
  echo ""
fi

# Export to PNG
echo "🖼️  Exporting slides to PNG..."
cd "$PROJECT_DIR" && npx slidev export --format png --output "$OUTPUT_DIR" 2>&1

echo ""
echo "✅ Done! PNG slides saved to:"
echo "   $OUTPUT_DIR/"
echo ""
echo "📋 Files generated:"
ls -la "$OUTPUT_DIR/"*.png 2>/dev/null || echo "   (no PNG files found)"
