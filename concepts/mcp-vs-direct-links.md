---
title: MCP Tools vs Direct Links
category: concepts
tags: [claude-code, mcp, urls, amazon-internal]
created: 2026-05-27
source: conversation
---

## TL;DR

Use MCP tools (ReadInternalWebsites) for Amazon-internal URLs; use direct fetch for public URLs.

## Details

**MCP tools** are required when the URL needs Midway authentication — anything with `amazon` in the hostname, or `a2z.com` / `aws.dev` domains. The `ReadInternalWebsites` tool handles this auth transparently.

**Direct fetch** works for public URLs (GitHub, Stack Overflow, AWS public docs, etc.) — no special auth needed.

In practice, you can just paste any link. Claude will route it through the appropriate tool automatically. But if you're wondering why a fetch failed, check whether the URL is internal (needs MCP) or public (direct).

## When This Matters

When you paste a URL and Claude can't fetch it, or when you're deciding how to share a link with Claude in a prompt.
