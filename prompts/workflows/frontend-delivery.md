Run frontend delivery: single-step run of frontend-engineer with issue and frontend spec to produce a PR via Lovable.

Run the workflow with id **frontend-delivery**.

Follow the execution policy:

1. **Plan mode first:** Read the workflow definition from `.cursor/workflows/frontend-delivery/WORKFLOW.md`. Present the plan (steps and inputs from that file). Do not execute any step until I confirm the plan.
2. **Required inputs:** Before running, ask me for every required input listed in that workflow's Inputs table (or in the manifest's `required_inputs`). Do not execute until all required inputs are provided. Optional inputs may use defaults or be prompted as needed.
3. **Then execute:** After I confirm and inputs are collected, run the workflow steps in order per WORKFLOW.md.
