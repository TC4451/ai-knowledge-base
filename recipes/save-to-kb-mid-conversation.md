---
title: Save a Learning to the KB Mid-Conversation
category: recipes
tags: [claude-code, knowledge-base, workflow]
created: 2026-05-27
source: conversation
---

## TL;DR

Say "save this to the KB" during any Claude session to capture a learning without breaking flow.

## Details

**Pattern:**

```
You: "Save this to the KB — [describe the learning in one sentence]"
```

Claude will:
1. Determine the right category (`concepts/`, `tools/`, `workflows/`, or `recipes/`)
2. Create a `.md` file with proper frontmatter
3. Write TL;DR + Details + When This Matters
4. Run `./scripts/generate-readme.sh` to update the table of contents
5. Commit with message "Add: <title>"

**Variations:**

- "Save this to the KB under tools" — if you want to specify the category
- "Add this to the knowledge base" — same thing
- "KB: [learning]" — shorthand

**Requirements:**
- Claude needs access to the KB repo (via memory pointer or working directory)
- The KB repo must be at the path Claude's memory specifies

## When This Matters

Whenever you learn something useful mid-conversation and don't want to lose it or break your current flow to manually document it.
