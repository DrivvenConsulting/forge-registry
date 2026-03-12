# Workflows

Workflows are multi-step, multi-agent sequences that standardize common processes. They reference agents (and optionally rules/skills) by id and define inputs, outputs, handoffs, and conditionals.

## Relation to agents and bundles

- **Agents** define a single role (e.g. tech-lead, backend-engineer). Workflows **invoke** agents in sequence. Agents are role-only and use **skills** for all GitHub, Confluence, and AWS interactions (issues, PRs, project board, discovery); ensure the interaction skills used by each agent are available (e.g. via bundle or install).
- **Bundles** group agents, rules, and skills by project type (backend, data-engineering, devops, frontend). Workflows **use** those agents; they do not replace bundles.
- **Rules** and **skills** are applied when an agent runs (per agent definition); workflows only specify which agent runs at each step. Do not hardcode tool or MCP names in workflow docs.

## How to reference workflows in Cursor

- **Install path:** If your tooling supports it (e.g. `forge install workflow <id>`), workflows can be installed to `.cursor/workflows/<id>/` in consuming projects. A runner or orchestrator can then discover and execute steps from the workflow definition.
- **Documentation:** Use each workflow's `WORKFLOW.md` as the source of truth: run the listed agents in order, passing the documented inputs and using the outputs as context for the next step.
- **Orchestrator agent:** An agent can read `.cursor/workflows/<id>/WORKFLOW.md` (after install) and guide the user through each step or output the exact context for the next agent run.

### Execution policy (plan mode and required inputs)

All workflows **start in plan mode** and **require input collection before run**:

- **Plan mode first:** The runner must present the plan (workflow steps and inputs) and wait for user confirmation before executing any step. Do not execute until the user confirms.
- **Required inputs before run:** The runner must prompt for all required inputs (see each workflow's Inputs table in `WORKFLOW.md`, or the manifest's `required_inputs` and `optional_inputs`). Do not execute until all required inputs are provided; optional inputs may use defaults or be prompted as needed.

Manifests may include `plan_mode_first: true`, `prompt_for_inputs_before_run: true`, and `required_inputs` / `optional_inputs` for tooling that enforces this behavior without parsing markdown.

No runner implementation lives in this registry; only declarative workflow definitions (manifest + WORKFLOW.md per workflow).

## Canonical spec-driven workflows (Phases 1–5)

The **AI Spec-Driven Development Framework** uses one workflow per phase plus a full-cycle workflow. These are the canonical orchestration layer for the lifecycle (see [REFACTORING.md](REFACTORING.md)):

| Id | Phases | Description |
|----|--------|-------------|
| `discovery` | 1 | Raw idea → spec (requirements, acceptance criteria, success metrics). |
| `planning` | 2 | Spec → GitHub issues with subtasks mapped to acceptance criteria. |
| `implementation` | 3 | Issue ID(s) → code commits, infrastructure changes. |
| `testing-validation` | 4 | Issue(s) + implementation + spec → QA report; human sign-off before deployment. |
| `feedback-monitoring` | 5 | Deployed feature + criteria + logs → feedback report; human decides hotfix vs new feature. |
| `full-cycle` | 1→5 | Raw idea → Discovery → Planning → Implementation → Testing → deployment → Feedback & Monitoring. |

Domain-specific or legacy multi-phase pipelines (e.g. `idea-to-backlog`, `backend-full-cycle`) remain available and may conceptually compose or align with these phases.

**Canonical agents for phase workflows:** Phase 1 (discovery) is run with **product-owner** in spec-writing mode. Phase 4 (testing-validation) is run with **qa-tester** (AC validation and, when needed, integration validation mode). See the main [README](README.md) for role consolidation.

### Skill mapping (canonical workflows)

Runners and bundles should equip the following registry skills when running the canonical phase workflows. Framework names used in workflow prose map to these ids:

| Framework skill name | Registry skill id(s) |
|---------------------|---------------------|
| spec-writing        | spec-writing        |
| github-issue         | github-issue, github-issue-operations, github-issue-creation-standards, github-sub-issue-linking, github-project-board |
| aws-context          | aws-context, aws-resource-discovery |
| api-implementation   | api-implementation, backend-task-breakdown |
| ui-implementation    | ui-implementation, lovable-prompts |
| terraform            | terraform, terraform-github-actions |
| qa-validation        | qa-validation       |
| aws-cli              | aws-cli, aws-cognito-integration-check, aws-api-gateway-integration-check, aws-lambda-integration-check |
| monitoring           | monitoring          |
| problem-shaping      | problem-shaping     |
| feasibility-assessment | feasibility-assessment |

## Workflow list

| Id | Description |
|----|-------------|
| `discovery` | Phase 1: raw idea → spec. |
| `planning` | Phase 2: spec → GitHub issues. |
| `implementation` | Phase 3: issue(s) → code/infra. |
| `testing-validation` | Phase 4: implementation + spec → QA report. |
| `feedback-monitoring` | Phase 5: deployed feature → feedback report. |
| `full-cycle` | Phases 1→5: idea → feedback report. |
| `backend-full-cycle` | Implement [dev] (and [ops] if any) work and run QA verification. |
| `backend-implement-and-integration-test` | Implement backend/infra, then run qa-tester (integration validation mode) on deployed AWS services. |
| `full-story-delivery` | End-to-end: refine → implement [ops] then [dev] → QA → optional integration test. |
| `data-engineering-delivery` | Implement data work; coordinate with backend/devops when same parent has [dev]/[ops]. |
| `frontend-delivery` | Single-step: run frontend-engineer with issue and frontend spec to produce a PR via Lovable. |
| `idea-to-backlog` | Pipeline from problem framing (idea_shaper) through requirements, channel validation, feasibility, implementation (backend/data/devops), and QA; work tracking via DrivvenConsulting/projects/6. |
| `idea-to-backlog-linear` | Deprecated alias of `idea-to-backlog`; work tracking is standardized on GitHub (DrivvenConsulting/projects/6). |
| `backlog-to-ready` | From Backlog: refine with tech-lead, create applicable subissues ([dev], [ops], [qa], [int], [data], [front]), refine each with specialist agents, move parent to Ready. |
| `backlog-to-ready-linear` | Deprecated alias of `backlog-to-ready`; work tracking is standardized on GitHub (DrivvenConsulting/projects/6). |
