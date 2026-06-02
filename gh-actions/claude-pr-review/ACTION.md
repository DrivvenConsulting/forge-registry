---
name: claude-pr-review
description: "Trigger a Claude managed agent session to review pull requests opened against main or development"
---

# Claude PR Review Workflow

Launches a Claude managed agent session for every pull request opened, synchronized, or reopened against `main` or `development`. The agent receives the PR metadata and mounted repo to perform a thorough code review.

## Triggers

| Event | Branches |
|-------|----------|
| `pull_request` (opened, synchronize, reopened) | `main`, `development` |

## Jobs

| Job | Runner | Timeout |
|-----|--------|---------|
| `review` | `ubuntu-latest` | 10 min |

## Agent Configuration

Configure the following GitHub Actions variables to point to your own agent, environment, and vault:

| Variable | Description |
|----------|-------------|
| `CLAUDE_AGENT_REVIEW_ID` | Agent ID for PR review |
| `CLAUDE_ENV_ID` | Anthropic environment ID |
| `CLAUDE_VAULT_ID` | Anthropic vault ID |

## Required Secrets / Variables

| Name | Type | Description |
|------|------|-------------|
| `ANTHROPIC_API_KEY` | secret | Anthropic API key |
| `GH_PAT` | secret | GitHub personal access token for repo mounting |
| `CLAUDE_AGENT_REVIEW_ID` | var | Agent ID for this workflow |
| `CLAUDE_ENV_ID` | var | Anthropic environment ID |
| `CLAUDE_VAULT_ID` | var | Anthropic vault ID |
