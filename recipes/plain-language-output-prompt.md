---
title: Plain-Language Output Prompt
category: recipes
tags: [claude-code, prompting, communication, output-style]
created: 2026-06-17
source: conversation
---

## TL;DR

Drop this line into a prompt to get clear, jargon-free answers: "Use simplistic, scientific, easy vocab, and straightforward language for most efficient communication."

## Details

**The prompt:**

```
Use simplistic, scientific, easy vocab, and straightforward language for most efficient communication.
```

**How to use it:**

- **One-off:** paste it into any chat when you want a plain-language answer for that turn.
- **Always-on:** install it as a global rule at `~/.claude/rules/` so Claude follows it in every
  session and project (this entry's companion rule does exactly that). A reference snippet stored
  here in the KB does NOT auto-apply — it's a copy-paste source.

**Why it works:** it constrains vocabulary and sentence structure, which reduces filler and
ambiguity. Pairs well with the `caveman` skill when you want even more aggressive token reduction.

## When This Matters

Use when you want answers you can read fast — explanations, summaries, docs — without dense or
flowery phrasing. Skip it when you specifically need precise domain terminology.
