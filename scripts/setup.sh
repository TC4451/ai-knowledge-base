#!/usr/bin/env bash
set -euo pipefail

# Sets up Claude Code memory entry so "save this to the KB" works from any directory.
# Usage: ./scripts/setup.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KB_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Claude Code stores per-project memory under ~/.claude/projects/<encoded-path>/memory/
# For global awareness, we use the home directory project scope
HOME_ENCODED="$(echo "$HOME" | sed 's|/|-|g')"
MEMORY_DIR="$HOME/.claude/projects/${HOME_ENCODED}/memory"

mkdir -p "$MEMORY_DIR"

MEMORY_FILE="$MEMORY_DIR/ai-knowledge-base-location.md"
INDEX_FILE="$MEMORY_DIR/MEMORY.md"

# Write the memory entry
cat > "$MEMORY_FILE" << EOF
---
name: ai-knowledge-base-location
description: Location and purpose of the AI knowledge base repo — consult when questions relate to AI tooling, Claude Code, Kiro, or MCP
metadata:
  type: reference
---

The user maintains a curated AI knowledge base at \`$KB_ROOT/\`.

It contains categorized entries (concepts, tools, workflows, recipes) about Claude Code, Kiro, MCP, and other AI tools. Entries have YAML frontmatter and TL;DR lines for quick agent scanning.

**How to use:** Read \`README.md\` for the table of contents, then read relevant entries. Follow \`CLAUDE.md\` in that repo for instructions on saving new entries.

**How to add:** When the user says "save this to the KB", create an entry in the appropriate category folder following \`templates/entry.md\` format, then run \`./scripts/generate-readme.sh\`.
EOF

# Add to MEMORY.md index (create or append)
ENTRY="- [AI Knowledge Base location](ai-knowledge-base-location.md) — curated KB at $KB_ROOT/, consult for AI tool learnings"

if [[ -f "$INDEX_FILE" ]]; then
    if ! grep -q "ai-knowledge-base-location" "$INDEX_FILE"; then
        echo "$ENTRY" >> "$INDEX_FILE"
    else
        echo "Memory entry already exists in index. Skipping."
    fi
else
    echo "$ENTRY" > "$INDEX_FILE"
fi

echo ""
echo "Setup complete!"
echo ""
echo "  Memory entry written to: $MEMORY_FILE"
echo "  KB location registered:  $KB_ROOT/"
echo ""
echo "  Claude Code will now know about this KB in all future sessions."
echo "  Say \"save this to the KB\" from any directory and it will work."
echo ""
