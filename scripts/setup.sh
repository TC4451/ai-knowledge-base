#!/usr/bin/env bash
set -euo pipefail

# Sets up a global Claude Code rule so "save this to the KB" works from any directory.
# Usage: ./scripts/setup.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KB_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
RULES_DIR="$HOME/.claude/rules"
RULE_FILE="$RULES_DIR/ai-knowledge-base.md"

mkdir -p "$RULES_DIR"

cat > "$RULE_FILE" << EOF
# AI Knowledge Base

When the user says "save this to the KB", "add this to the knowledge base", or similar:

1. Write the entry to \`$KB_ROOT/\` in the appropriate category folder (\`concepts/\`, \`tools/\`, \`workflows/\`, or \`recipes/\`)
2. Use the entry format from \`$KB_ROOT/templates/entry.md\`
3. Run \`$KB_ROOT/scripts/generate-readme.sh\` to update the table of contents
4. Commit the changes in that repo

Do NOT save to \`.claude/projects/.../memory/\`. The knowledge base is a git repo at \`$KB_ROOT/\`.
EOF

echo ""
echo "Setup complete!"
echo ""
echo "  Global rule written to: $RULE_FILE"
echo "  KB location registered: $KB_ROOT/"
echo ""
echo "  Claude Code will now route \"save this to the KB\" to this repo"
echo "  from any directory, in any session."
echo ""
