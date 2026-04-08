# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

**Forge Registry** is a declarative asset registry — all content is YAML and Markdown. There is no build system, package manager, test suite, or compiled code. Assets are installed into consuming projects via `forge install` or by copying directly.

## Asset types and structure

Every asset lives in its own directory with two required files: a `manifest.yaml` and a content `.md` file.

| Directory | Asset type | Content file | Count |
|-----------|-----------|--------------|-------|
| `agents/` | Role definitions | `agent.md` | 10 |
| `bundles/` | Project-type presets | `manifest.yaml` only | 6 |
| `rules/` | Coding/infra standards | `RULE.md` | 18 |
| `skills/` | Tool interaction capabilities | `SKILL.md` | 33 |
| `workflows/` | Multi-step sequences | `WORKFLOW.md` | 12 |

Skills may also include `scripts/` (runnable bash/Python helpers), `references/REFERENCE.md` (opinionated reference doc), and `assets/` (example workflows, payloads, config stubs).

## Core design principles

**Agents are role-only.** Agents never reference MCP servers, specific tool names, or CLIs directly. All GitHub, Confluence, and AWS interactions (issues, PRs, project board, resource discovery) are done exclusively through skills. The `agent.md` has a "Skills to equip by context" section that lists which skill IDs to activate per situation.

**Bundles wire everything together.** A bundle's `manifest.yaml` lists all `agent`, `rule`, `skill`, and `workflow` items for a given project type. Installing a bundle into a consuming project (e.g. `backend`) gives that project the right context for all phases.

**Workflows are purely declarative.** No runner implementation lives in this registry — only `manifest.yaml` + `WORKFLOW.md` per workflow. All workflows use `plan_mode_first: true` and `prompt_for_inputs_before_run: true`.

## Canonical spec-driven lifecycle

The six canonical workflows implement the AI Spec-Driven Development Framework:

| Workflow ID | Phase | Description |
|------------|-------|-------------|
| `discovery` | 1 | Raw idea → spec (requirements, AC, success metrics) |
| `planning` | 2 | Spec → GitHub issues with subtasks per AC |
| `implementation` | 3 | Issues → code/infra PRs, with gap handling |
| `testing-validation` | 4 | Implementation + spec → QA report + human sign-off |
| `feedback-monitoring` | 5 | Deployed feature → feedback report |
| `full-cycle` | 1→5 | End-to-end pipeline |

**Gap handling:** When implementation uncovers a spec gap, never patch silently — stop, create a gap report, and route back to Phase 1 or 2. This is enforced by the `spec-driven-gap-handling` rule.

**Key always-on rules:** `foundation-global-principles` (simplicity, clarity, explicitness) and `spec-driven-gap-handling` apply to all phases.

## Adding or editing assets

When adding a new agent, rule, skill, or workflow, follow the existing pattern:

1. Create a directory under the appropriate top-level folder.
2. Add `manifest.yaml` with at minimum `version`, `description`, and `project_types`.
3. Add the content file (`agent.md`, `RULE.md`, `SKILL.md`, or `WORKFLOW.md`).
4. If the asset belongs to one or more bundles, add it to those `bundles/<name>/manifest.yaml` under `items:` with the correct `kind` and `id`.

For skills that wrap CLIs or APIs, follow the layout in `skills/README.md`: add `scripts/` (named `<domain>-<action>.sh`), `references/REFERENCE.md`, and `assets/` as needed. Scripts must accept configuration via arguments or environment variables — no hardcoded IDs, account numbers, or URLs.

## Key references within the repo

- `README.md` — asset overview, workflow diagrams, how each path (workflow, bundle, or direct) works
- `workflows/README.md` — execution policy, skill mapping table, full workflow list
- `skills/README.md` — skill asset layout conventions
