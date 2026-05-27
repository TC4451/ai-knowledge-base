---
title: Skills vs Agents in Claude Code
category: concepts
tags: [claude-code, skills, agents, architecture]
created: 2026-05-27
source: conversation
---

## TL;DR

Skills are inline slash-commands that run in your conversation; Agents are isolated workers spawned for parallel or noisy tasks.

## Details

**Skills** (triggered via `/name`):
- Run inline in the current conversation
- Share your context — they see everything
- Execute one at a time
- Output lands directly in the conversation
- Think of them as macros or plugins

**Agents** (spawned via the Agent tool):
- Get their own isolated context window
- Don't see conversation history — must be briefed in the prompt
- Can run multiple in parallel
- Return a summary when done — Claude relays the result
- Used for broad searches, parallel work, or tasks that would flood context

| Aspect | Skills | Agents |
|--------|--------|--------|
| Context | Shared | Isolated |
| Triggered by | User (`/name`) or Claude | Claude only |
| Parallelism | Sequential | Parallel |
| Output | Inline | Summarized |

## When This Matters

When deciding whether to use a slash command vs ask Claude to spawn a background worker. Skills for structured workflows you want to follow step-by-step; agents for research or exploration you want done in the background.
