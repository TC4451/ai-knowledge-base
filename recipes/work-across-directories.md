---
title: Work Across Two Directories with additionalDirectories
category: recipes
tags: [claude-code, config, workspace, settings]
created: 2026-06-18
source: conversation
---

## TL;DR

Give Claude Code seamless read/write access to folders outside the current working directory by adding them to `additionalDirectories` in settings (or the `--add-dir` CLI flag) — so docs can live in one folder and code in another.

## Details

By default Claude Code can only touch files under the directory you start it in. To
let it work across two (or more) folders at once, list the extra folders.

**Persistent — `settings.json`:**

```json
{
  "additionalDirectories": ["/Users/you/Desktop/docs"]
}
```

Put this in `.claude/settings.json` (project), `.claude/settings.local.json` (project,
not committed), or `~/.claude/settings.json` (global). Paths can be absolute or
relative to the settings file.

**One-off — CLI flag:**

```
claude --add-dir /Users/you/Desktop/docs
```

You can pass `--add-dir` more than once to add several folders.

**Example use:** start Claude in your code repo, add your separate notes/docs folder via
`additionalDirectories`. Claude can now read the docs and edit the code in the same
session — no copying files between folders, no symlinks.

## When This Matters

Use when your project's docs, design notes, or shared assets live in a different folder
than the code, and you want Claude to read and edit both without leaving its working
directory or you pasting paths each turn.
