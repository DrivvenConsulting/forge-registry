---
name: claude-pr-fix
description: "Trigger a Claude managed agent session to apply fixes when @claude is mentioned in a PR comment"
---

# Claude PR Fix Workflow

Launches a Claude managed agent session when `@claude` is mentioned in a PR comment or a PR review comment. Passes the comment body and PR number to the agent for in-context fixes or suggestions.

## Triggers

| Event | Condition |
|-------|-----------|
| `issue_comment` (created) | Comment is on a pull request and contains `@claude` |
| `pull_request_review_comment` (created) | Comment contains `@claude` |

## Jobs

| Job | Runner | Timeout |
|-----|--------|---------|
| `claude` | `ubuntu-latest` | — |

## Agent Configuration

The workflow hard-codes an agent ID in the YAML. Replace the value of the `agent` parameter in the `client.beta.sessions.create(...)` call with your own agent ID, or parameterize it via a repository variable.

## Required Secrets / Variables

| Name | Type | Description |
|------|------|-------------|
| `ANTHROPIC_API_KEY` | secret | Anthropic API key |
| `GH_PAT` | secret | GitHub personal access token for repo mounting |
