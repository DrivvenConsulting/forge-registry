# Workflows

Workflows are multi-step, multi-agent sequences that standardize common processes. They reference agents (and optionally rules/skills) by id and define inputs, outputs, handoffs, and conditionals.

## Relation to agents and bundles

- **Agents** define a single role (e.g. tech-lead, backend-engineer). Workflows **invoke** agents in sequence.
- **Bundles** group agents, rules, and skills by project type (backend, data-engineering, devops, frontend). Workflows **use** those agents; they do not replace bundles.
- **Rules** and **skills** are applied when an agent runs (per agent definition); workflows only specify which agent runs at each step.

## How to reference workflows in Cursor

- **Install path:** If your tooling supports it (e.g. `forge install workflow <id>`), workflows can be installed to `.cursor/workflows/<id>/` in consuming projects. A runner or orchestrator can then discover and execute steps from the workflow definition.
- **Documentation:** Use each workflow's `WORKFLOW.md` as the source of truth: run the listed agents in order, passing the documented inputs and using the outputs as context for the next step.
- **Orchestrator agent:** An agent can read `.cursor/workflows/<id>/WORKFLOW.md` (after install) and guide the user through each step or output the exact context for the next agent run.
- **Ready-to-use prompts:** For copy-paste prompts that run a workflow with plan mode and required inputs, see the **prompts** folder (e.g. `prompts/run-workflow.md`, `prompts/workflows/<workflow-id>.md`).

### Execution policy (plan mode and required inputs)

All workflows **start in plan mode** and **require input collection before run**:

- **Plan mode first:** The runner must present the plan (workflow steps and inputs) and wait for user confirmation before executing any step. Do not execute until the user confirms.
- **Required inputs before run:** The runner must prompt for all required inputs (see each workflow's Inputs table in `WORKFLOW.md`, or the manifest's `required_inputs` and `optional_inputs`). Do not execute until all required inputs are provided; optional inputs may use defaults or be prompted as needed.

Manifests may include `plan_mode_first: true`, `prompt_for_inputs_before_run: true`, and `required_inputs` / `optional_inputs` for tooling that enforces this behavior without parsing markdown.

No runner implementation lives in this registry; only declarative workflow definitions (manifest + WORKFLOW.md per workflow).

## Workflow list

| Id | Description |
|----|-------------|
| `issue-refinement` | Turn a parent GitHub issue in Todo into [dev]/[ops]/[qa] sub-issues and move root to Ready. |
| `issue-refinement-with-feasibility` | Refine an issue, then backend and devops validate [dev]/[ops] sub-issues for feasibility before implementation. |
| `backend-full-cycle` | Implement [dev] (and [ops] if any) work and run QA verification. |
| `backend-implement-and-integration-test` | Implement backend/infra, then run integration-tester on deployed AWS services. |
| `full-story-delivery` | End-to-end: refine → implement [ops] then [dev] → QA → optional integration test. |
| `data-engineering-delivery` | Implement data work; coordinate with backend/devops when same parent has [dev]/[ops]. |
| `frontend-delivery` | Single-step: run frontend-engineer with issue and frontend spec to produce a PR via Lovable. |
