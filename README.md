# AI Knowledge Base

📚 A curated collection of AI usage learnings — Claude Code, Kiro, MCP, and more. For both human reference and AI agent consumption.

🔄 **Automatically aggregates** new knowledge from `.claude/` directories across your machine, and **ensures your AI skills are always installed** via a manifest-based auto-setup check.

### TL;DR

```bash
# Clone and set up
git clone https://github.com/TC4451/ai-knowledge-base.git
cd ai-knowledge-base
./scripts/setup.sh          # Install global rule (enables "save this to the KB" from any directory)

# Check skills are installed
diff <(cat skills-manifest.txt) <(ls ~/.claude/skills/)

# Add a learning mid-conversation (works from any directory after setup)
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

### Concepts

- [**MCP Tools vs Direct Links**](concepts/mcp-vs-direct-links.md)
  Use MCP tools for URLs behind corporate auth; use direct fetch for public URLs.
- [**Skills vs Agents in Claude Code**](concepts/skills-vs-agents.md)
  Skills are inline slash-commands that run in your conversation; Agents are isolated workers spawned for parallel or noisy tasks.
- [**Spec-Driven Development in Kiro**](concepts/spec-driven-development.md)
  Kiro's "spec-based features" means building features through a 3-phase process: Requirements → Design → Tasks, then autonomous implementation.

### Tools

- [**ccstatusline - Claude Code Status Line Formatter**](tools/ccstatusline.md)
  ccstatusline is an npm package that provides a highly customizable status line for Claude Code CLI, showing model info, git branch, token usage, block timer, and more.
- [**Obsidian for Enterprise Use**](tools/obsidian-for-enterprise.md)
  Obsidian works well in enterprise environments — but cloud sync features are typically restricted for vaults containing company data.
- [**Orient Skill — Repo Situational Awareness**](tools/orient-skill.md)
  Custom `/orient` skill provides instant situational awareness of any repo — runs parallel diagnostics and outputs a tiered briefing.

### Workflows

- [**Superpowers Project Workflow**](workflows/superpowers-project-workflow.md)
  The standard project workflow chains skills in order: using-superpowers → brainstorming → planning-with-files → grill-me → writing-plans → executing-plans.

### Recipes

- [**Install External Claude Code Skills**](recipes/install-external-skills.md)
  Install skills from K-Dense-AI/scientific-agent-skills and anthropics/skills repos via sparse clone + copy to ~/.claude/skills/.
- [**Save a Learning to the KB Mid-Conversation**](recipes/save-to-kb-mid-conversation.md)
  Say "save this to the KB" during any Claude session to capture a learning without breaking flow.

---

## Usage

### Setup

Run the setup script to register this KB with Claude Code. This creates a **global rule** at `~/.claude/rules/` so Claude knows where the KB lives — enabling "save this to the KB" from **any directory, in any session**.

```bash
./scripts/setup.sh
```

After setup, saying "save this to the KB" in any Claude Code session will write directly to this repo, regardless of your current working directory.

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
- A **global rule** at `~/.claude/rules/ai-knowledge-base.md` (installed by `./scripts/setup.sh`) that routes "save this to the KB" commands to this repo from any directory
- The **CLAUDE.md** in this repo with detailed instructions when working inside the repo

Agents should:
1. Read `README.md` first for the table of contents
2. Read entries relevant to the current task (use the TL;DR for quick scanning)
3. Follow `CLAUDE.md` instructions for saving new entries
---

## Tags

 `agents` `ai-coding` `architecture` `claude-code` `customization` `development-methodology` `diagnostics` `enterprise` `installation` `kiro` `knowledge-base` `mcp` `note-taking` `npm` `obsidian` `project-lifecycle` `repo-awareness` `setup` `skills` `specs` `status-line` `superpowers` `terminal` `urls` `workflow`

