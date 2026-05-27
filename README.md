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

### Concepts

- [**MCP Tools vs Direct Links**](concepts/mcp-vs-direct-links.md)
  Use MCP tools (ReadInternalWebsites) for Amazon-internal URLs; use direct fetch for public URLs.
- [**Skills vs Agents in Claude Code**](concepts/skills-vs-agents.md)
  Skills are inline slash-commands that run in your conversation; Agents are isolated workers spawned for parallel or noisy tasks.
- [**Spec-Driven Development in Kiro**](concepts/spec-driven-development.md)
  Kiro's "spec-based features" means building features through a 3-phase process: Requirements → Design → Tasks, then autonomous implementation.

### Tools

- [**Obsidian at Amazon**](tools/obsidian-at-amazon.md)
  Obsidian is AppSec-approved at Amazon, available via IT Marketplace, used by 4000+ Amazonians — but Obsidian Sync is not allowed for work vaults.

### Workflows

- [**Superpowers Project Workflow**](workflows/superpowers-project-workflow.md)
  The standard project workflow chains skills in order: using-superpowers → brainstorming → planning-with-files → grill-me → writing-plans → executing-plans.

### Recipes

- [**Save a Learning to the KB Mid-Conversation**](recipes/save-to-kb-mid-conversation.md)
  Say "save this to the KB" during any Claude session to capture a learning without breaking flow.

---

## Tags

 `agents` `ai-coding` `amazon` `amazon-internal` `architecture` `claude-code` `development-methodology` `it-marketplace` `kiro` `knowledge-base` `mcp` `note-taking` `obsidian` `project-lifecycle` `skills` `specs` `superpowers` `urls` `workflow`

