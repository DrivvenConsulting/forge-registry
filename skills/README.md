## Skill assets layout

Skills that interact with CLIs, HTTP APIs, or MCP integrations should follow a consistent layout so humans and agents can reuse concrete examples:

- **`scripts/`**: runnable helper scripts (usually bash, optionally Python) that a developer can run locally.
  - Name scripts by `<domain>-<action>.sh` (for example, `lambda-validate.sh`, `api-gateway-smoke-test.sh`, `terraform-env-plan.sh`, `gh-issue-create.sh`).
  - Accept configuration via **arguments or environment variables**, not hardcoded IDs, account numbers, or URLs.
  - Prefer read‑only operations for discovery/validation skills; clearly document any mutating behavior.

- **`references/REFERENCE.md`**: a short, opinionated reference for the skill.
  - Summarize what the skill does and how it is used in the spec‑driven phases.
  - Document “core commands” that mirror the helper scripts.
  - Link to authoritative docs (AWS, GitHub, Terraform, Confluence, etc.) instead of duplicating them.

- **`assets/`**: non‑trivial supporting files.
  - Example GitHub Actions workflows (for example, `lambda-deploy.workflow.yaml`, `terraform-ci.workflow.yaml`).
  - Example payloads or config stubs (for example, `lambda-test-event.json`, `api-request-example.json`, `terraform-backend-template.hcl`).
  - Larger examples that would otherwise bloat `SKILL.md`.

Each CLI/MCP skill’s `SKILL.md` should point to its scripts, reference file, and any important assets in its **Steps** or **References** section.

