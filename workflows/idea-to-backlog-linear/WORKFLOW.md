---
name: WORKFLOW
model: inherit
---

# Agent Workflow (Linear)

This document defines the pipeline order, handoffs, and branching rules for the agent set when work tracking is **Linear**. Use it to orchestrate agents (manually or via a parent agent).

## Pipeline overview

```mermaid
flowchart LR
  subgraph discovery [Discovery]
    Idea[idea_shaper]
  end
  Refiner[requirements_refiner]
  Channel[channel_specialist_google_ads]
  Feasibility[feasibility_guide]

  Idea --> Refiner
  Refiner --> Channel
  Channel --> Feasibility
  Feasibility -->|approved| impl
```

## Work tracking

**All work items (issues) are created and updated in Linear only:**

- **Team and project:** Designated Linear **team** and **project** (e.g. Drivven, Adlyze). Supplied as inputs or derived from context.
- When creating issues: use **linear-issue-operations** to create the issue in the designated team/project; use **linear-issue-status** to set the new issue state to **Backlog** (or document in the work item body if the integration cannot update the state).

Linear statuses (use these exact names):

| Status | When |
|--------|------|
| **Backlog** | After requirements_refiner (and channel_specialist when applicable); before feasibility approval. |
| **Ready** | After feasibility_guide approves. |
| **Available** | When implementation work is in progress. |
| **Reviewed** | When PR(s) are under review. |
| **Approved** | When review is approved. |
| **Released** | Shipped and accepted. |
| **Canceled**, **Duplicate** | Exceptional resolution. |

If the Linear integration cannot move the issue state, agents document the intended status (e.g. in the work item body or in the artifact) so a human or parent agent can move the item.

## Artifact format

Agents (**idea_shaper**, **requirements_refiner**, **channel_specialist_google_ads**, **feasibility_guide**) return **JSON** as their primary output. Implementation (e.g. PRs) is performed in other repositories.

### Artifact paths

All agents write artifacts under **`artifacts/feature-definitions/<feature_name>/`** where `<feature_name>` is a snake_case slug (e.g. `google_sso`, `export_daily_reports`). Canonical filenames:

| File | Producer |
|------|----------|
| `feature-definition.json` | idea_shaper |
| `linear_issue.json` | requirements_refiner (issue definition used for Linear) |
| `technical-feasibility.json` | feasibility_guide |
| `channel-feasibility-google-ads.json` | channel_specialist_google_ads (mandatory for every feature) |

The parent agent or inputs must supply `<feature_name>` so each agent can write to the correct folder.

## Inputs

| Name | Required | Description |
|------|----------|-------------|
| feature_name | Yes | Snake_case slug for the feature (e.g. `google_sso`). |
| raw_idea | No | Raw idea or problem statement for idea_shaper. |
| team | No | Linear team (e.g. Drivven). Default or context if omitted. |
| project | No | Linear project (e.g. Adlyze). Default or context if omitted. |

## Stages

### 1. Problem framing (choose one path)

| Agent | When to use | Inputs | Output | Next step |
|-------|-------------|--------|--------|-----------|
| **idea_shaper** | Only a problem statement and context alignment are needed (quick validation, or before human-led discovery). | Raw idea; optional Confluence vision. | **JSON artifact** (`feature-definition.json`: feature_id, title, problem_statement, context_alignment, assumptions, feature_distinctiveness, user_journeys when present). | Pass **entire** JSON artifact to **requirements_refiner**. |

- Use **idea_shaper** for problem-only framing.

### 2. Requirements

| Agent | Inputs | Output | Next step |
|-------|--------|--------|-----------|
| **requirements_refiner** | **Entire** idea_shaper JSON output (full `feature-definition.json`); target **team** and **project** in Linear. | **JSON artifact** (issue definition: title, description, user_stories, acceptance_criteria, assumptions, references). Writes to `artifacts/feature-definitions/<feature_name>/linear_issue.json`. Creates work item in Linear via **linear-issue-operations**; sets state to **Backlog** via **linear-issue-status**. | Run **channel_specialist_google_ads** (mandatory), then **feasibility_guide**. |

- **requirements_refiner** receives the **entire** JSON output from idea_shaper (the full `feature-definition.json`), not only the problem statement. It uses all provided fields (e.g. user_journeys, context_alignment) to derive user stories and acceptance criteria.
- After creating the work item in Linear, the next step is channel validation, then technical feasibility.

### 3. Channel validation (mandatory)

| Agent | Inputs | Output | Next step |
|-------|--------|--------|-----------|
| **channel_specialist_google_ads** | Work item in **Backlog** in Linear; work item identifier (e.g. LIN-123); team/project. | **JSON artifact** (channel feasibility: scope/available_data, constraints, risks, recommendation). Writes to `artifacts/feature-definitions/<feature_name>/channel-feasibility-google-ads.json`. May append Channel Feasibility section to the work item via **linear-issue-operations**. | Run **feasibility_guide**. |

- This agent runs **after** the work item is created (Backlog) and **before** technical feasibility (feasibility_guide). **Channel validation is mandatory for every feature.**
- **The channel-feasibility artifact must be produced for every feature.** When the feature does not touch Google Ads (or the channel), the agent still runs and produces the artifact with an explicit statement that the feature does not touch the channel (e.g. `feature_scope: "does_not_touch_google_ads"`, `recommendation: "proceed"`, and a short explanation in `recommendation_guidance` or `available_data_explanation`).

### 4. Technical feasibility

| Agent | Inputs | Output | Next step |
|-------|--------|--------|-----------|
| **feasibility_guide** | Work item in **Backlog** in Linear **with** Channel Feasibility artifact/section (required for every feature); architecture context. | **JSON artifact** (technical feasibility: technical_feasibility, data_considerations, dependencies, blocker_reason). Writes to `artifacts/feature-definitions/<feature_name>/technical-feasibility.json`. Adds Technical Feasibility section to work item via **linear-issue-operations**; if approved moves to **Ready** via **linear-issue-status**, else stays **Backlog**. | If **Ready**: hand off for implementation. If **Backlog**: address blockers before re-running feasibility. |

- The **channel-feasibility artifact** (e.g. `channel-feasibility-google-ads.json`) must exist for every feature before running feasibility_guide. When the feature does not touch the channel, the artifact explicitly states so (e.g. `feature_scope: "does_not_touch_google_ads"`). If the artifact is missing, run channel_specialist_google_ads first.

## Branching rules

1. **Channel Feasibility says "adjust requirements"**  
   Loop back to **requirements_refiner**: either update the existing work item (with a comment or description edit describing the adjustment) via **linear-issue-operations** or create a follow-up issue. Do not move to feasibility_guide until requirements are updated and channel specialist is re-run.

2. **Technical Feasibility is "blocked"**  
   Leave the work item in **Backlog**. Do not move to Ready. Document in the work item what is blocking and what would unblock (via **linear-issue-operations**). Optionally create a follow-up issue for the blocker.

3. **Work item touches multiple channels**  
   Run each relevant channel specialist (e.g. channel_specialist_google_ads) and ensure all Channel Feasibility sections are on the work item before running feasibility_guide.

4. **Linear team and project**  
   All work-item creation and state updates target the designated Linear team and project only. Use **linear-issue-status** to set state to **Ready** when feasibility is approved; use the exact status name **Ready**.
