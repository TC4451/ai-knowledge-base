# AI Knowledge Base — Agent Instructions

## About This Repo

This is a curated knowledge base of AI usage learnings. It contains entries about Claude Code, Kiro, MCP, and other AI tools — organized for both human browsing and agent consumption.

## How to Use This KB

1. **Start with README.md** — it's an auto-generated table of contents grouped by category
2. **Read entries relevant to the current task** — each has a TL;DR for quick scanning
3. **Entry format**: YAML frontmatter (title, category, tags) + TL;DR + Details + When This Matters

## How to Save a New Entry

When the user says "save this to the KB" or similar:

1. Determine the category: `concepts/`, `tools/`, `workflows/`, or `recipes/`
2. Create a new `.md` file using the format in `templates/entry.md`
3. Use a descriptive kebab-case filename (e.g., `mcp-vs-direct-links.md`)
4. Fill in frontmatter: title, category, tags, today's date, source: conversation
5. Write a one-line TL;DR, then Details, then When This Matters
6. Run `./scripts/generate-readme.sh` to update the table of contents
7. Commit with message: "Add: <title>"

## How to Triage the Inbox

When the user asks to triage `_raw/`:

1. Read each file in `_raw/`
2. For each, decide: categorize (move to proper folder with proper format), skip (delete), or merge (update existing entry)
3. Ask the user to confirm before acting
4. After triage, regenerate README and commit

## Skill Auto-Setup

At session start, check that all skills listed in `skills-manifest.txt` exist in `~/.claude/skills/`. If any are missing:

1. Report which skills are missing
2. Ask the user if they'd like to install them
3. The user installs via their normal method — this repo only tracks what should be present
