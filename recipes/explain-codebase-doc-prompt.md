---
title: Explain a Large Codebase as docs/pipeline.md
category: recipes
tags: [claude-code, prompting, documentation, onboarding, codebase]
created: 2026-07-10
source: conversation
---

## TL;DR

A structured prompt that makes Claude produce a verified, honest `docs/pipeline.md` that teaches a large codebase — with mermaid diagrams, a file:function legend, bottom-up walkthroughs, live values from real runs, and a coverage/render gate before it claims done.

## Details

The prompt works well because it forces three things most codebase explanations skip:
verify every named symbol (grep/read it, don't recall it), pull live values from real
runs (labeled "Live:", no invented numbers), and gate on coverage + mermaid render
before declaring done. It also asks Claude to report the architecture reading *before*
writing, so you can correct course early.

**The prompt:**

```
# Task: explain this codebase as a `docs/pipeline.md`

Create docs/pipeline.md that teaches this repo to someone new to it. Don't modify
source unless I ask.

## Ground rules (do these, don't skip)
- VERIFY, don't narrate from memory. Before naming any file, function, class,
  shape, or number: read it, grep it, or run it. If you can't verify a claim,
  say so instead of writing it.
- PULL LIVE VALUES. Run the real entry points on a real (or sample) input and
  quote actual outputs — counts, shapes, sizes, scores, sample records. Label
  them "Live:". No invented numbers.
- BE HONEST about gaps: duplication, divergence, dead code, loose coupling,
  names that imply more than the code does. Flag them; don't smooth over.
- Plain, concrete language. Short sentences. Concrete specifics over adjectives.

## Step 0 — discover the architecture (report before writing the doc)
- Map the modules/packages and the import (dependency) graph: who imports whom.
- Find the dependency DIRECTION and whether it's acyclic.
- Find the SEAM(s): chokepoint file(s) where one layer reaches another
  (adapter / bridge / client / API boundary). Note anything that bypasses them.
- Find the ENTRY POINTS and major flows (there may be one, or several parallel).
- Identify how it's built / run / tested; run the tests and report pass/fail
  honestly. Green tests = the pieces actually connect.
Pause and show me this reading before writing the doc.

## The doc has these sections, in order:

### 1. Diagram 1 — Structure: layers, dependency direction, seams  (mermaid `flowchart`)
- One color band per package/layer. Highlight seam/boundary nodes in a strong accent.
- Arrows show import/dependency direction only. Make cycles (or their absence) visible.
- Short caption: the 2–3 structural facts someone must know first.

### 2. Diagram 2 — Data / control flow  (mermaid `flowchart`)
- Show the actual runtime path from input → output.
- If there are parallel flows, draw them as lanes that converge on the shared core.
- Include the alternatives/controls/baselines, not just the happy path.
- Visual grammar: solid = main path, dotted = optional/alternative; mark any
  feedback/loop and when it's active.
- Caption: what it shows + any subtlety it deliberately omits.

### 3. File : function legend
- Table mapping each diagram node → `path/to/file : function`.

### 4. One walkthrough per major flow
Numbered, BOTTOM-UP steps (leaf/base first, following the data as it grows).
For EACH step:
- Bold header: `Step N — path/file: one-line what-it-is`.
- 2–4 plain sentences on what it does and why it exists.
- An `in → out` line with concrete SHAPES, e.g.
  `> in: JSON dict · out: (Warehouse[11 modules], FlowMatrix[11×11])`.
  Mark in-place mutations and "no return value" honestly.
- A "Live:" value pulled from a real run.
- Under the step, an italic bullet list of HELPER files that feed it, each
  naming its real key functions with a one-line what-it-does:
  `- path/file.py — func_a() does X; func_b() does Y.`
- End each walkthrough with a one-sentence "in one breath" summary.

## Coverage + verification gate (before telling me it's done)
- Every non-trivial module in scope appears in exactly one walkthrough step or
  helper bullet. List anything deliberately omitted and why.
- Every function/class name you wrote actually exists (grep each one).
- Every mermaid block RENDERS (compile it, e.g. `mmdc`); fix syntax until it does.
- Report the coverage checklist and the render result.
```

**Tuning notes:**
- The output filename (`docs/pipeline.md`) is arbitrary — rename per repo.
- Mermaid render check needs the `mmdc` CLI (`@mermaid-js/mermaid-cli`); drop that
  line if you don't have it, but you lose the "diagram actually compiles" guarantee.
- Pairs well with the [[plain-language-output-prompt]] for the plain-language rule.

## When This Matters

Use when onboarding onto an unfamiliar repo, or producing durable architecture docs you
want to trust. Best for medium-to-large codebases with real entry points and tests to
run — the "Live:" and coverage gates need something runnable to verify against.
