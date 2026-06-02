---
name: claude-issue-implementer
description: "Trigger a Claude managed agent session to implement an issue when @claude is mentioned"
---

# Claude Issue Implementer Workflow

Launches a Claude managed agent session whenever `@claude` is mentioned in a new issue or issue comment. The agent receives the GitHub repository as a mounted resource and a shared memory store for context.

## Triggers

| Event | Condition |
|-------|-----------|
| `issue_comment` (created) | Comment is on an issue (not a PR) and contains `@claude` |
| `issues` (opened, assigned) | Issue body or title contains `@claude` |

## Jobs

| Job | Runner | Timeout |
|-----|--------|---------|
| `claude` | `ubuntu-latest` | 10 min |

## Agent Configuration

The workflow uses Anthropic managed agents. Configure the following GitHub Actions variables to point to your own agent, environment, and vault:

| Variable | Description |
|----------|-------------|
| `CLAUDE_AGENT_ISSUE_ID` | Agent ID (e.g. `agent_...`) for issue implementation |
| `CLAUDE_ENV_ID` | Anthropic environment ID |
| `CLAUDE_VAULT_ID` | Anthropic vault ID |

## Required Secrets / Variables

| Name | Type | Description |
|------|------|-------------|
| `ANTHROPIC_API_KEY` | secret | Anthropic API key |
| `GH_PAT` | secret | GitHub personal access token for repo mounting |
| `CLAUDE_AGENT_ISSUE_ID` | var | Agent ID for this workflow |
| `CLAUDE_ENV_ID` | var | Anthropic environment ID |
| `CLAUDE_VAULT_ID` | var | Anthropic vault ID |
