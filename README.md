# AI Knowledge Base

📚 A curated collection of AI usage learnings — Claude Code, Kiro, MCP, and more. For both human reference and AI agent consumption.

🔄 **Automatically aggregates** new knowledge from `.claude/` directories across your machine, and **ensures your AI skills are always installed** via a manifest-based auto-setup check.

---

## Table of Contents

- [Entries](#entries) — Browse knowledge by category
- [Usage](#usage) — How to add, aggregate, and manage entries
- [For AI Agents](#for-ai-agents) — How agents discover and use this KB
- [Tags](#tags) — Cross-cutting topic index

---

## Entries

### Concepts

- [**MCP Tools vs Direct Links**](concepts/mcp-vs-direct-links.md)
  Use MCP tools for URLs behind corporate auth; use direct fetch for public URLs.
- [**Skills vs Agents in Claude Code**](concepts/skills-vs-agents.md)
  Skills are inline slash-commands that run in your conversation; Agents are isolated workers spawned for parallel or noisy tasks.
- [**Spec-Driven Development in Kiro**](concepts/spec-driven-development.md)
  Kiro's "spec-based features" means building features through a 3-phase process: Requirements → Design → Tasks, then autonomous implementation.

### Tools

- [**Obsidian for Enterprise Use**](tools/obsidian-for-enterprise.md)
  Obsidian works well in enterprise environments — but cloud sync features are typically restricted for vaults containing company data.

### Workflows

- [**Superpowers Project Workflow**](workflows/superpowers-project-workflow.md)
  The standard project workflow chains skills in order: using-superpowers → brainstorming → planning-with-files → grill-me → writing-plans → executing-plans.

### Recipes

- [**Save a Learning to the KB Mid-Conversation**](recipes/save-to-kb-mid-conversation.md)
  Say "save this to the KB" during any Claude session to capture a learning without breaking flow.

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
---

## Tags

 `agents` `ai-coding` `architecture` `claude-code` `development-methodology` `enterprise` `kiro` `knowledge-base` `mcp` `note-taking` `obsidian` `project-lifecycle` `skills` `specs` `superpowers` `urls` `workflow`

