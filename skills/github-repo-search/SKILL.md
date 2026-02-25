---
name: github-repo-search
description: Search repos, issues, or code. Use when you need to discover related repositories or issues for context.
---

# GitHub Repo Search

Search for repositories, issues, or code within an organization or repo to discover related projects, open issues, or implementation patterns.

## When to Use

- You need to find related repositories (e.g. by org, topic, or name) for technical feasibility or context.
- You need to search issues or code to see how a feature is implemented elsewhere or what similar work exists.
- Your task involves discovery of existing repos or code before creating sub-issues or recommending approach.

Equip this skill when your role includes discovering related GitHub repos or code; do not hardcode tool names in agent logic.

## Steps

1. **Build search query** – Derive query terms from the issue or task (e.g. org name, topic, service name like "Cognito", "Lambda", "adlyze").
2. **Search repositories** – Use the available GitHub integration to search repositories with the query. Summarize which repos exist and what is relevant (e.g. Terraform, backend service, shared libs).
3. **Search issues or code (optional)** – If needed, use the integration to search issues or code with a focused query. Use results to inform feasibility, related work, or duplication.
4. **Summarize** – Report which repos and (if applicable) issues or code are relevant and how the current repo/issue relates to them.

## Do

- Use read-only search; do not modify repos or issues from this skill.
- Keep queries focused so results are actionable (e.g. org + topic, or repo + keyword).

## Do Not

- Reference specific tool or MCP names in agent instructions; the skill encapsulates the mechanism.
