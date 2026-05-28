---
title: ccstatusline - Claude Code Status Line Formatter
category: tools
tags: [claude-code, terminal, customization, status-line, npm]
created: 2026-05-28
source: conversation
---

## TL;DR

ccstatusline is an npm package that provides a highly customizable status line for Claude Code CLI, showing model info, git branch, token usage, block timer, and more.

## Details

### Installation

Requires Node.js. On Amazon Cloud Desktop where `npx` alias conflicts with Brazil:

```bash
# Install nvm first (if no node)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.zshrc
nvm install --lts

# Use the real npx binary (bypasses Brazil alias)
$HOME/.nvm/versions/node/v24.16.0/bin/npx -y ccstatusline@latest
```

### Configuration

- Run the TUI interactively to pick widgets, colors, themes
- Config saved to: `~/.config/ccstatusline/settings.json`
- Automatically updates Claude Code settings at: `~/.claude/settings.json`

### Claude Code settings.json format

```json
{
  "statusLine": {
    "type": "command",
    "command": "npx -y ccstatusline@latest",
    "padding": 0,
    "refreshInterval": 10
  }
}
```

For pinned installs (no auto-update): choose "Pinned global install" in TUI, then command becomes just `"ccstatusline"`.

### Key Features

- 50+ widgets: model name, git branch/PR/status, token usage, context %, block timer, session cost, weekly usage, thinking effort, vim mode, compaction counter, memory usage, CWD, custom text
- Powerline mode with arrow separators and themes
- Multi-line support (unlimited lines)
- Widget merging, flex separators, right-alignment
- Git PR links (GitHub + GitLab)
- Short bar / progress bar display modes
- Global minimalist mode for label-free output

### Useful Aliases

```bash
# Add to ~/.zshrc to bypass Brazil npx alias
alias npx-real="$HOME/.nvm/versions/node/v24.16.0/bin/npx"
```

### Repo

https://github.com/sirmalloc/ccstatusline

## When This Matters

When customizing Claude Code terminal appearance, monitoring token/context usage, tracking block timers, or wanting git status visible in the status line.
