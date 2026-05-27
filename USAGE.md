# Usage Guide

## Adding Entries

### Mid-conversation (easiest)

While in a Claude Code session, say:

> "Save this to the KB — [describe the learning]"

Claude will create the entry, categorize it, and commit it.

### Manually

1. Copy `templates/entry.md` to the appropriate category folder
2. Rename to a descriptive kebab-case filename (e.g., `my-new-learning.md`)
3. Fill in the frontmatter and content sections
4. Run `./scripts/generate-readme.sh` to update the table of contents
5. Commit your changes

## Aggregating from .claude Directories

The aggregator script scans your machine for `.claude/` directories and collects memory files, CLAUDE.md content, and rules into the `_raw/` inbox.

```bash
./scripts/aggregate.sh
```

By default it searches from `$HOME`. To search a different root:

```bash
./scripts/aggregate.sh /path/to/search
```

### Triaging the Inbox

After aggregation, review `_raw/` entries. You can do this manually or ask Claude:

> "Triage the _raw/ inbox"

Claude will read each raw entry and propose:
- **Categorize**: move to `concepts/`, `tools/`, `workflows/`, or `recipes/` with proper formatting
- **Skip**: delete if it's project-specific or stale
- **Merge**: update an existing entry if there's overlap

## Regenerating the README

The table of contents in `README.md` is auto-generated from entry frontmatter:

```bash
./scripts/generate-readme.sh
```

Run this after adding, moving, or deleting entries.

## Categories

| Folder | What goes here |
|--------|---------------|
| `concepts/` | Mental models, "how X works", clarification of confusing topics |
| `tools/` | Tool-specific reference (Claude Code, Kiro, MCP servers, etc.) |
| `workflows/` | Multi-step procedures and processes |
| `recipes/` | Quick copy-paste patterns and short how-tos |

## Skill Auto-Setup

This repo tracks which Claude Code skills should be installed globally in `skills-manifest.txt`. When Claude starts a session in this repo, it checks whether all listed skills are present in `~/.claude/skills/` and reports any that are missing.

To update the manifest:

```bash
ls ~/.claude/skills/ > skills-manifest.txt
```

## For AI Agents

Agents discover this KB via:
- A **Claude memory entry** that points here from any session
- The **CLAUDE.md** in this repo with detailed instructions

Agents should:
1. Read `README.md` first for the table of contents
2. Read entries relevant to the current task (use the TL;DR for quick scanning)
3. Follow `CLAUDE.md` instructions for saving new entries
