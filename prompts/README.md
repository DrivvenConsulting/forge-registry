# Prompts

Reusable prompts for Cursor (or other tools). Use them by copy-pasting into chat or by referencing from an orchestrator. Focus: **running workflows** with plan mode first and required inputs before execution.

## How to use

- If your tooling supports it (e.g. `forge install prompts`), prompts can be installed to `.cursor/prompts/` in consuming projects.
- Otherwise, copy the content from the registry file you need and paste it into chat.
- When running a workflow, the agent should read the workflow definition from `.cursor/workflows/<workflow_id>/WORKFLOW.md` (after the workflow is installed).

## Execution policy reminder

Running a workflow means:

1. **Plan mode first:** Start in plan mode. Present the plan (workflow steps and inputs from the workflow's WORKFLOW.md). Do not execute any step until the user confirms the plan.
2. **Required inputs before run:** Prompt for all required inputs listed in that workflow's Inputs table (or manifest `required_inputs`). Do not execute until all required inputs are provided. Optional inputs may use defaults or be prompted as needed.
3. **Then execute:** After the user confirms and inputs are collected, run the workflow steps in order per WORKFLOW.md.

## Index

| Prompt | Workflow id | Description |
|--------|-------------|-------------|
| [run-workflow.md](run-workflow.md) | (template) | Generic: run any workflow by id; substitute WORKFLOW_ID. Plan mode + required inputs first. |
| [workflows/issue-refinement.md](workflows/issue-refinement.md) | `issue-refinement` | Run issue-refinement workflow with plan mode and required inputs. |
| [workflows/issue-refinement-with-feasibility.md](workflows/issue-refinement-with-feasibility.md) | `issue-refinement-with-feasibility` | Run issue-refinement-with-feasibility workflow with plan mode and required inputs. |
| [workflows/backend-full-cycle.md](workflows/backend-full-cycle.md) | `backend-full-cycle` | Run backend-full-cycle workflow with plan mode and required inputs. |
| [workflows/backend-implement-and-integration-test.md](workflows/backend-implement-and-integration-test.md) | `backend-implement-and-integration-test` | Run backend-implement-and-integration-test workflow with plan mode and required inputs. |
| [workflows/full-story-delivery.md](workflows/full-story-delivery.md) | `full-story-delivery` | Run full-story-delivery workflow with plan mode and required inputs. |
| [workflows/data-engineering-delivery.md](workflows/data-engineering-delivery.md) | `data-engineering-delivery` | Run data-engineering-delivery workflow with plan mode and required inputs. |
| [workflows/frontend-delivery.md](workflows/frontend-delivery.md) | `frontend-delivery` | Run frontend-delivery workflow with plan mode and required inputs. |
