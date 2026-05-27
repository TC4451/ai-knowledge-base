#!/usr/bin/env bash
set -euo pipefail

# Generates README.md table of contents from entry frontmatter.
# Usage: ./scripts/generate-readme.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KB_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
README="$KB_ROOT/README.md"
CATEGORIES=("concepts" "tools" "workflows" "recipes")

declare -a ALL_TAGS=()

extract_frontmatter_field() {
    local file="$1"
    local field="$2"
    sed -n '/^---$/,/^---$/p' "$file" | grep "^${field}:" | sed "s/^${field}:[[:space:]]*//"
}

cat > "$README" << 'HEADER'
# AI Knowledge Base

A curated collection of AI usage learnings — Claude Code, Kiro, MCP, and more.
For both human reference and AI agent consumption.

## Quick Start

- **Browse**: Navigate by category below
- **Add an entry**: Copy `templates/entry.md`, fill it in, place in the right category
- **Aggregate from .claude dirs**: `./scripts/aggregate.sh`
- **Regenerate this README**: `./scripts/generate-readme.sh`

---

## Entries

HEADER

for category in "${CATEGORIES[@]}"; do
    category_dir="$KB_ROOT/$category"
    if [[ ! -d "$category_dir" ]]; then
        continue
    fi

    entries=()
    while IFS= read -r -d '' file; do
        entries+=("$file")
    done < <(find "$category_dir" -name "*.md" -type f -print0 | sort -z)

    if [[ ${#entries[@]} -eq 0 ]]; then
        continue
    fi

    # Category header
    category_title="$(echo "$category" | awk '{print toupper(substr($0,1,1)) substr($0,2)}')"
    echo "### $category_title" >> "$README"
    echo "" >> "$README"

    for file in "${entries[@]}"; do
        title="$(extract_frontmatter_field "$file" "title")"
        tags="$(extract_frontmatter_field "$file" "tags")"
        rel_path="${file#$KB_ROOT/}"

        if [[ -z "$title" ]]; then
            title="$(basename "$file" .md)"
        fi

        # Extract TL;DR line (skip blank lines after header)
        tldr="$(grep -A3 "^## TL;DR" "$file" 2>/dev/null | grep -v "^## TL;DR" | grep -v "^$" | head -1 | sed 's/^[[:space:]]*//')"

        echo "- [**$title**]($rel_path)" >> "$README"
        if [[ -n "$tldr" && "$tldr" != "##"* ]]; then
            echo "  $tldr" >> "$README"
        fi

        # Collect tags
        if [[ -n "$tags" ]]; then
            cleaned="$(echo "$tags" | tr -d '[]' | tr ',' '\n' | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')"
            while IFS= read -r tag; do
                if [[ -n "$tag" ]]; then
                    ALL_TAGS+=("$tag")
                fi
            done <<< "$cleaned"
        fi
    done

    echo "" >> "$README"
done

# Tag index
if [[ ${#ALL_TAGS[@]} -gt 0 ]]; then
    echo "---" >> "$README"
    echo "" >> "$README"
    echo "## Tags" >> "$README"
    echo "" >> "$README"

    sorted_unique_tags=($(printf '%s\n' "${ALL_TAGS[@]}" | sort -u))
    tag_line=""
    for tag in "${sorted_unique_tags[@]}"; do
        tag_line+=" \`$tag\`"
    done
    echo "$tag_line" >> "$README"
    echo "" >> "$README"
fi

echo "README.md generated with entries from ${#CATEGORIES[@]} categories."
