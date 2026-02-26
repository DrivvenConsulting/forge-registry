Run idea-to-backlog pipeline: idea → requirements → channel validation → feasibility → implementation → QA (work tracking via DrivvenConsulting/projects/6).

Run the workflow with id **idea-to-backlog**.

When updating the GitHub issue with channel or technical feasibility, add only human-readable Markdown summaries to the issue; do not comment or paste raw JSON on the issue.

Follow the execution policy:

1. **Plan mode first:** Read the workflow definition from `.cursor/workflows/idea-to-backlog/WORKFLOW.md`. Present the plan (steps and inputs from that file). Do not execute any step until I confirm the plan.
2. **Required inputs:** Before running, ask me for every required input listed in that workflow's Inputs table (or in the manifest's `required_inputs`). Do not execute until all required inputs are provided. Optional inputs may use defaults or be prompted as needed.
3. **Then execute:** After I confirm and inputs are collected, run the workflow steps in order per WORKFLOW.md.
