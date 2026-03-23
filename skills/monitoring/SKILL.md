---
name: monitoring
description: Produce a feedback report from a deployed feature: metrics vs success criteria, flagged issues, and improvement opportunities as raw ideas for Phase 1.
---

# Monitoring (Phase 5)

Produce a feedback report after a feature is deployed: compare metrics to success criteria, flag issues, and list improvement opportunities formatted as **raw ideas for Phase 1**. Immediate fixes are routed to Phase 2 as hotfix tasks (skip Phase 1); improvements trigger a full Phase 1→5 cycle. **Human reviews and decides: hotfix or new feature.**

## When to Use

- You are in Phase 5 (Feedback & Monitoring).
- You have a deployed feature reference, acceptance criteria (or spec excerpt), and access to production logs or metrics.

Equip this skill when your role is monitoring or feedback analysis. The runner or environment may provide access to logs, metrics, or monitoring dashboards.

## Steps

1. **Ingest inputs** – Deployed feature ref (e.g. release, env URL, feature flag), acceptance criteria or spec excerpt, and production logs or metrics.
2. **Compare metrics to success criteria** – Assess whether the feature meets the success metrics defined in the spec.
3. **Flag issues** – List any problems (e.g. errors, latency, missing behavior) with severity or impact.
4. **List improvement opportunities** – Format each as a raw idea suitable for Phase 1 (Discovery).
5. **Route recommendations** – Immediate fixes → Phase 2 (hotfix tasks, skip Phase 1). Improvements → full Phase 1→5 cycle. State clearly; human reviews and decides hotfix vs new feature.

## Do

- Produce a structured feedback report (metrics vs criteria, issues, improvement ideas).
- Use raw-idea format for improvements so they can be fed into Phase 1.

## Do Not

- Deploy or change production from this skill; report only.
- Bypass human review for the decision between hotfix and new feature.
