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

## Tags

 `agents` `ai-coding` `architecture` `claude-code` `development-methodology` `enterprise` `kiro` `knowledge-base` `mcp` `note-taking` `obsidian` `project-lifecycle` `skills` `specs` `superpowers` `urls` `workflow`

