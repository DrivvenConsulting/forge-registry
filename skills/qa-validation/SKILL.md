---
name: qa-validation
description: Validate implementation against spec and acceptance criteria; produce pass/fail per criterion and a recommendation (Approve / Fix / Escalate).
---

# QA Validation (Phase 4)

Validate that the implementation satisfies the spec and every acceptance criterion. Produce a QA report with pass/fail per criterion, evidence, and a recommendation (Approve / Fix / Escalate). Every test must map to an acceptance criterion or a real integration point; no superficial tests.

## When to Use

- You are in Phase 4 (Testing & Validation).
- You need to verify that implementation (PRs, code, deployment refs) meets the spec and acceptance criteria.
- The **qa-tester** agent uses this skill in **AC validation mode** (and in discovery-assisted mode after resolving endpoints).

Equip this skill when your role is QA or AC verification. Use project rules (e.g. foundation-global-principles, framework-fastapi, security-authentication) as the standard to verify against. **Human must review and sign off before deployment.**

## Steps

1. **Load spec and acceptance criteria** – From the spec file or parent issue, extract every acceptance criterion.
2. **Load implementation refs** – PR(s), commit(s), or deployment refs to validate.
3. **Map each AC to implementation** – For each acceptance criterion, determine where it is implemented (endpoint, service, test, config) and whether it is satisfied.
4. **Set status per AC** – pass (implemented and verifiable), fail (missing or incorrect), or partial (describe what is missing).
5. **Add evidence** – File path, test name, or short description for each AC.
6. **Produce recommendation** – Approve (ready for human sign-off), Fix (issues to address), or Escalate (blockers or ambiguity).
7. **Note** – Human must review and sign off before deployment.

## Do

- Map every test to an acceptance criterion or real integration point.
- Include evidence (file, test, or one-line description) for each AC.

## Do Not

- Create superficial tests that do not map to AC or integration points.
- Deploy without human sign-off.
