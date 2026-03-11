#!/usr/bin/env bash
# Generate a Claude Code communication style from sample text.
# Usage: ./generate-style.sh <style-name> <file1> [file2] [file3] ...
#
# Feeds the text to Claude, which analyzes voice patterns and outputs
# a style directive file compatible with the DVP /style system.
#
# Example:
#   ./generate-style.sh shelby ~/texts/remarkably-bright-creatures.txt ~/texts/short-stories.txt
#
# Output: ~/.claude/styles/<style-name>.md (and updates /style command awareness)
set -euo pipefail

if [ $# -lt 2 ]; then
    echo "Usage: $0 <style-name> <file1> [file2] ..."
    echo ""
    echo "Analyzes writing samples and generates a Claude Code communication style."
    echo "The style will be saved to ~/.claude/styles/<style-name>.md"
    exit 1
fi

STYLE_NAME="$1"
shift
STYLE_FILE="$HOME/.claude/styles/${STYLE_NAME}.md"
COMBINED=$(mktemp)

# Combine all input files
for f in "$@"; do
    if [ ! -f "$f" ]; then
        echo "Error: file not found: $f"
        rm -f "$COMBINED"
        exit 1
    fi
    echo "--- Source: $(basename "$f") ---" >> "$COMBINED"
    cat "$f" >> "$COMBINED"
    echo "" >> "$COMBINED"
done

SAMPLE_CHARS=$(wc -c < "$COMBINED")
echo "Analyzing ${SAMPLE_CHARS} characters of source text..."

# Build the analysis prompt
PROMPT=$(cat << 'ANALYSIS'
You are analyzing writing samples to extract a communication style profile for an AI assistant.

Read the provided text carefully and identify:

1. **Mechanics** — sentence structure, punctuation habits, capitalization, paragraph length, use of fragments vs. complete sentences, dialogue style
2. **Tone** — formal vs. casual register, humor style (if any), emotional range, warmth vs. distance, confidence level
3. **Vocabulary** — word choice patterns, jargon/specialized language, colloquialisms, reading level
4. **Rhythm** — pacing, use of short vs. long sentences, how ideas build, transitions
5. **Distinctive patterns** — anything that makes this voice recognizable and unique

Then produce a style directive file in this exact format:

```
## Communication Style: [Name]

[One-line description of the voice — who it sounds like and the overall feel]

### Mechanics
[Bullet points about sentence structure, punctuation, formatting]

### Tone
[Bullet points about emotional register, humor, warmth, confidence]

### Vocabulary
[Bullet points about word choice, reading level, distinctive phrases]

### Rhythm
[Bullet points about pacing, sentence variation, how ideas build]

### What NOT to do
[Bullet points about common AI behaviors that would break this voice]
[Always include: "Still be helpful and accurate. The voice is style, not substance — get the work done."]
```

Be specific and actionable. Give concrete examples from the source text where possible. The goal is that an AI reading this file will naturally produce text that feels like it was written by the same author.
ANALYSIS
)

# Use Claude to analyze
RESPONSE=$(cat "$COMBINED" | claude --print -p "$(echo "$PROMPT")")

# Write the style file
echo "$RESPONSE" > "$STYLE_FILE"

rm -f "$COMBINED"

echo ""
echo "Style file written to: $STYLE_FILE"
echo ""
echo "To use it: /style $STYLE_NAME"
echo ""
echo "Preview:"
echo "---"
head -20 "$STYLE_FILE"
echo "---"
