---
name: claude-pr-main-closed
description: "Notify a Claude managed agent when a PR targeting main is closed or merged"
---

# Claude PR Main Closed Workflow

Fires when any pull request targeting `main` is closed (merged or unmerged). Extracts the linked issue number from the PR body (`Closes/Fixes/Resolves #N`) and sends a notification to a Claude managed agent.

## Triggers

| Event | Branch |
|-------|--------|
| `pull_request` (closed) | `main` |

## Jobs

| Job | Runner |
|-----|--------|
| `run` | `ubuntu-latest` |

## Agent Configuration

The workflow hard-codes an agent ID in the YAML. Replace the value of the `agent` parameter in the `client.beta.sessions.create(...)` call with your own agent ID, or parameterize it via a repository variable.

## Required Secrets / Variables

| Name | Type | Description |
|------|------|-------------|
| `ANTHROPIC_API_KEY` | secret | Anthropic API key |
| `GH_PAT` | secret | GitHub personal access token for repo mounting |
