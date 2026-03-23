---
name: terraform
description: Provision and update infrastructure using Terraform; use terraform-github-actions and rules infrastructure-terraform, ci-cd-terraform-integration.
---

# Terraform (Phase 3 – Infrastructure)

When touching infrastructure in Phase 3 (Implementation), use this skill. It is satisfied by **terraform-github-actions** (workflow patterns, backend config, var files) and the project rules **infrastructure-terraform** and **ci-cd-terraform-integration**. Use for provisioning, updating, and CI/CD for Terraform.

## When to Use

- You are in Phase 3 (Implementation) and the work item is infrastructure or DevOps ([ops]).
- You need to add or change Terraform resources, backend config, or GitHub Actions for Terraform.

Equip this skill when your role is DevOps or infrastructure. Follow **infrastructure-terraform** (folder structure, tagging, backend per environment) and **ci-cd-terraform-integration** (fmt, validate, plan, apply per env). Use **terraform-github-actions**, **github-actions-lambda-deploy**, **github-actions-lint-python** as needed for workflows. **If Terraform, GitHub Actions, or the required CLI/MCP integrations are not available or not authenticated in the current environment, stop execution, explain what is missing, and ask the user to either authorize or run the commands in an appropriate environment. Do not attempt to create new credentials or reconfigure authentication silently.**

## Steps

1. **Read work item** – Scope: Terraform resources, env vars, secrets, CI/CD, observability.
2. **Provision or update infrastructure** – Add or change Terraform (resources, variables, outputs). Use environment-specific backend and var files; do not hardcode environment names or resource identifiers. **Define resources in feature-specific files** (e.g. `lambda.tf`, `api_gateway.tf`, `vpc.tf`) instead of putting everything into `main.tf`.
3. **Configure CI/CD** – Add or update GitHub Actions for Terraform (init, plan, apply per environment). Use **terraform-github-actions** patterns.
4. **Observability and validation** – Document logging, health checks; add steps to validate deployment.
5. **Gap handling** – If a gap is discovered not covered by any subtask, stop, create a gap report, and route back to Phase 2. Never patch silently.

## Do

- Use backend config and var files per environment (e.g. `backend/{environment}/`, `environments/{environment}/terraform.tfvars`).
- Always run `terraform fmt` locally after creating or editing any Terraform file, and ensure fmt and validate run on PRs.

## Do Not

- Hardcode secrets, URLs, or environment-specific values in code.
- Patch gaps silently; always document and route back to Phase 2.
