---
description: "Gap handling protocol and human review checkpoints for the AI Spec-Driven Development Framework (Phases 1–5)"
alwaysApply: false
---

# Spec-Driven Gap Handling & Human Checkpoints

## Purpose

Ensure agents in the spec-driven lifecycle never silently patch gaps and that human review is enforced at deployment and when routing feedback. See [REFACTORING.md](../../REFACTORING.md) for the full framework.

## Gap Handling Protocol

1. **Agent stops and documents the gap** – When an agent discovers that something is missing (e.g. a requirement not in the spec, or a task not in the subtasks), it must stop and document the gap in a gap report. Do not invent requirements or tasks.
2. **Route back** – Gap in the **spec** (missing requirement, unclear acceptance criterion) → route back to **Phase 1** (Discovery). Gap in **tasks** (missing subtask or scope) → route back to **Phase 2** (Planning). Cycle resumes only after the gap is addressed (spec updated or tasks created).
3. **Agents never silently patch** – Do not implement, assume, or document work that is not covered by the spec or by an explicit subtask. Always surface the gap and route back.

## Human Review Checkpoints

- **Phase 4 (Testing & Validation):** Human must review and sign off before deployment. Do not deploy without human approval after QA report (Approve / Fix / Escalate).
- **Phase 5 (Feedback & Monitoring):** Human reviews the feedback report and decides: **hotfix** (immediate fixes → Phase 2 as hotfix tasks, skip Phase 1) or **new feature** (improvements → full Phase 1→5 cycle). Agents do not decide; they recommend and the human decides.

## Do

- Document every gap with a short gap report (what is missing, where it was expected).
- Route spec gaps to Phase 1; task gaps to Phase 2.
- Enforce human sign-off before deployment (Phase 4).
- Enforce human decision on hotfix vs new feature (Phase 5).

## Do Not

- Silently patch or implement work not covered by the spec or subtasks.
- Deploy without human sign-off after Phase 4.
- Decide hotfix vs new feature in Phase 5 without human review.
