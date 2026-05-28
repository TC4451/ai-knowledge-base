---
title: Install External Claude Code Skills
category: recipes
tags: [claude-code, skills, setup, installation]
created: 2026-05-27
source: conversation
---

## TL;DR

Install skills from K-Dense-AI/scientific-agent-skills and anthropics/skills repos via sparse clone + copy to ~/.claude/skills/.

## Details

### From K-Dense-AI/scientific-agent-skills (GitHub)

Skills: **paper-lookup**, **networkx**, **matplotlib**

```bash
git clone --depth 1 --filter=blob:none --sparse https://github.com/K-Dense-AI/scientific-agent-skills.git /tmp/scientific-agent-skills
cd /tmp/scientific-agent-skills && git sparse-checkout set skills/paper-lookup skills/networkx skills/matplotlib
cp -R /tmp/scientific-agent-skills/skills/paper-lookup ~/.claude/skills/
cp -R /tmp/scientific-agent-skills/skills/networkx ~/.claude/skills/
cp -R /tmp/scientific-agent-skills/skills/matplotlib ~/.claude/skills/
```

### From anthropics/skills (GitHub)

Skills: **docx**

```bash
git clone --depth 1 --filter=blob:none --sparse https://github.com/anthropics/skills.git /tmp/anthropic-skills
cd /tmp/anthropic-skills && git sparse-checkout set skills/docx
cp -R /tmp/anthropic-skills/skills/docx ~/.claude/skills/
```

### Custom (created locally)

- **orient** — repo situational awareness scan (see [Orient Skill](../tools/orient-skill.md))

### Verify installation

```bash
diff <(cat skills-manifest.txt) <(ls ~/.claude/skills/)
```

## When This Matters

When setting up a fresh machine, onboarding someone, or reinstalling skills after a config reset. Run these commands then verify against `skills-manifest.txt`.
