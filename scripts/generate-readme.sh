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

📚 A curated collection of AI usage learnings — Claude Code, Kiro, MCP, and more. For both human reference and AI agent consumption.

🔄 **Automatically aggregates** new knowledge from `.claude/` directories across your machine, and **ensures your AI skills are always installed** via a manifest-based auto-setup check.

### TL;DR

```bash
# Add a learning mid-conversation
"Save this to the KB — [your learning here]"

# Aggregate knowledge from all .claude/ dirs
./scripts/aggregate.sh

# Regenerate the README after changes
./scripts/generate-readme.sh
```

---

## Table of Contents

- [Entries](#entries) — Browse knowledge by category
- [Usage](#usage) — How to add, aggregate, and manage entries
- [For AI Agents](#for-ai-agents) — How agents discover and use this KB
- [Tags](#tags) — Cross-cutting topic index

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

# Usage section
cat >> "$README" << 'USAGE'
---

## Usage

### Adding Entries

**Mid-conversation (easiest):**

> "Save this to the KB — [describe the learning]"

Claude will create the entry, categorize it, and commit it.

**Manually:**

1. Copy `templates/entry.md` to the appropriate category folder
2. Rename to a descriptive kebab-case filename (e.g., `my-new-learning.md`)
3. Fill in the frontmatter and content sections
4. Run `./scripts/generate-readme.sh` to update the table of contents
5. Commit your changes

### Aggregating from .claude Directories

The aggregator script scans your machine for `.claude/` directories and collects memory files, CLAUDE.md content, and rules into the `_raw/` inbox.

```bash
./scripts/aggregate.sh
```

By default it searches from `$HOME`. To search a different root:

```bash
./scripts/aggregate.sh /path/to/search
```

**Triaging the inbox:** After aggregation, review `_raw/` entries manually or ask Claude:

> "Triage the _raw/ inbox"

Claude will propose: **Categorize** (move to proper folder), **Skip** (delete stale/specific), or **Merge** (update existing).

### Regenerating the README

The table of contents above is auto-generated from entry frontmatter:

```bash
./scripts/generate-readme.sh
```

Run this after adding, moving, or deleting entries.

### Categories

| Folder | What goes here |
|--------|---------------|
| `concepts/` | Mental models, "how X works", clarification of confusing topics |
| `tools/` | Tool-specific reference (Claude Code, Kiro, MCP servers, etc.) |
| `workflows/` | Multi-step procedures and processes |
| `recipes/` | Quick copy-paste patterns and short how-tos |

### Skill Auto-Setup

This repo tracks which Claude Code skills should be installed globally in `skills-manifest.txt`. When Claude starts a session in this repo, it checks whether all listed skills are present in `~/.claude/skills/` and reports any that are missing.

To update the manifest:

```bash
ls ~/.claude/skills/ > skills-manifest.txt
```

### For AI Agents

Agents discover this KB via:
- A **Claude memory entry** that points here from any session
- The **CLAUDE.md** in this repo with detailed instructions

Agents should:
1. Read `README.md` first for the table of contents
2. Read entries relevant to the current task (use the TL;DR for quick scanning)
3. Follow `CLAUDE.md` instructions for saving new entries
USAGE

# Tag index (last section)
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
