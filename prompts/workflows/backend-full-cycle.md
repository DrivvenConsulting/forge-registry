Run backend full cycle: implement [dev] (and [ops] if any) work and run QA verification.

Run the workflow with id **backend-full-cycle**.

Follow the execution policy:

1. **Plan mode first:** Read the workflow definition from `.cursor/workflows/backend-full-cycle/WORKFLOW.md`. Present the plan (steps and inputs from that file). Do not execute any step until I confirm the plan.
2. **Required inputs:** Before running, ask me for every required input listed in that workflow's Inputs table (or in the manifest's `required_inputs`). Do not execute until all required inputs are provided. Optional inputs may use defaults or be prompted as needed.
3. **Then execute:** After I confirm and inputs are collected, run the workflow steps in order per WORKFLOW.md.
