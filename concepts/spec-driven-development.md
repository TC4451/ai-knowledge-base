---
title: Spec-Driven Development in Kiro
category: concepts
tags: [kiro, specs, development-methodology, ai-coding]
created: 2026-05-27
source: conversation
---

## TL;DR

Kiro's "spec-based features" means building features through a 3-phase process: Requirements → Design → Tasks, then autonomous implementation.

## Details

Spec-driven development in Kiro formalizes AI-assisted coding into structured phases:

1. **Requirements** (`requirements.md`) — What needs to be built: user stories, acceptance criteria
2. **Design** (`design.md`) — How it will be built: architecture, components, interfaces
3. **Tasks** (`tasks.md`) — Step-by-step implementation plan with traceability to requirements

**How it works:**
- Click **+** under "Specs" in the Kiro panel (or choose "Spec" from chat)
- Describe your feature idea
- Kiro walks you through each phase iteratively
- Once approved, Kiro implements tasks one by one

**Why it matters:** Instead of "vibe coding" (chatting with AI hoping for the best), you get a structured plan that acts as a contract between your intent and the AI's output. The spec lives in `.kiro/specs/` alongside your code.

This is essentially Amazon's BRD → Design → Tasks workflow, but with AI drafting each phase and the developer reviewing/refining before implementation begins.

**Related Kiro concepts:**
- **Steering** (`.kiro/steering/`) — persistent project knowledge (product.md, tech.md, structure.md)
- **Powers** (`.kiro/powers/`) — reusable domain-specific agent capabilities

## When This Matters

When someone mentions "spec-based features," "spec mode," or "SDD" in the context of Kiro or AI-assisted development at Amazon.
