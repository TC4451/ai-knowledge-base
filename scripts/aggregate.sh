#!/usr/bin/env bash
set -euo pipefail

# Aggregates .claude/ content from across the machine into _raw/ inbox.
# Usage: ./scripts/aggregate.sh [search_root]
# Default search root: $HOME

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KB_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
RAW_DIR="$KB_ROOT/_raw"
SEARCH_ROOT="${1:-$HOME}"

dirs_found=0
entries_collected=0
duplicates_skipped=0

hash_file() {
    shasum -a 256 "$1" | awk '{print $1}'
}

existing_hashes() {
    find "$RAW_DIR" -name "*.md" -exec shasum -a 256 {} \; | awk '{print $1}'
}

stage_file() {
    local src="$1"
    local project_path="$2"
    local filename
    filename="$(basename "$src")"

    local content_hash
    content_hash="$(hash_file "$src")"

    if echo "$KNOWN_HASHES" | grep -q "$content_hash"; then
        duplicates_skipped=$((duplicates_skipped + 1))
        return
    fi

    local safe_project
    safe_project="$(echo "$project_path" | tr '/' '_' | sed 's/^_//')"
    local dest="$RAW_DIR/${safe_project}__${filename}"

    # Avoid overwriting existing files
    if [[ -f "$dest" ]]; then
        dest="${dest%.md}__$(date +%s).md"
    fi

    cp "$src" "$dest"
    entries_collected=$((entries_collected + 1))
}

echo "Scanning for .claude/ directories under: $SEARCH_ROOT"
echo "---"

KNOWN_HASHES="$(existing_hashes)"

while IFS= read -r claude_dir; do
    dirs_found=$((dirs_found + 1))
    project_path="$(dirname "$claude_dir")"

    # Collect memory files
    if [[ -d "$claude_dir/projects" ]]; then
        while IFS= read -r memory_dir; do
            if [[ -d "$memory_dir" ]]; then
                find "$memory_dir" -name "*.md" -type f | while read -r f; do
                    stage_file "$f" "$project_path"
                done
            fi
        done < <(find "$claude_dir/projects" -type d -name "memory")
    fi

    # Collect CLAUDE.md if present in the project root
    local_claude_md="$(dirname "$claude_dir")/CLAUDE.md"
    if [[ -f "$local_claude_md" ]]; then
        stage_file "$local_claude_md" "$project_path"
    fi

    # Collect rules files
    if [[ -d "$claude_dir/rules" ]]; then
        find "$claude_dir/rules" -name "*.md" -type f | while read -r f; do
            stage_file "$f" "$project_path"
        done
    fi

done < <(find "$SEARCH_ROOT" -name ".claude" -type d -not -path "*/.git/*" -not -path "*/node_modules/*" 2>/dev/null)

echo ""
echo "Results:"
echo "  Directories found:    $dirs_found"
echo "  Entries collected:    $entries_collected"
echo "  Duplicates skipped:   $duplicates_skipped"
echo ""
echo "Raw entries staged in: $RAW_DIR"
