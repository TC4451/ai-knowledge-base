---
title: Orient Skill — Repo Situational Awareness
category: tools
tags: [claude-code, skills, repo-awareness, diagnostics]
created: 2026-05-27
source: conversation
---

## TL;DR

Custom `/orient` skill provides instant situational awareness of any repo — runs parallel diagnostics and outputs a tiered briefing.

## Details

A custom skill at `.claude/skills/orient/SKILL.md` that runs read-only diagnostics on a repo and synthesizes a briefing.

**What it does:**
- Runs parallel checks: identity, structure, git history, branch state, health signals
- Outputs a tiered briefing: 3-line TL;DR first, then expandable sections (structure, recent commits, branch state, WIP, health, entry points)

**Triggers:** "orient", "what's going on", "brief me", "context", "catch me up", "what is this repo"

**Design choices:**
- Tiered output — TL;DR always shown first, deeper sections on demand
- Read-only — never mutates state
- Targets <10 second execution
- Adapts to repo size (limits output for large repos)
- Skips irrelevant sections silently
- Instruction-only (no scripts needed)

**Origin:** Inspired by repo-atlas (GitHub, 28 stars) but lighter — instant context at conversation start without generating persistent docs.

## When This Matters

At the start of new conversations or when switching repos and you need quick context without reading through files manually. Invoke with `/orient`.
