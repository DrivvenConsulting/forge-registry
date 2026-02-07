# Skill: Terraform and GitHub Actions

Run Terraform from GitHub Actions using environment-specific backend config and variable files, with clear separation of state per environment.

## When to use

- You are adding or changing a CI/CD workflow that runs Terraform (plan/apply).
- You need to ensure Terraform init, plan, and apply use the correct backend and tfvars for each environment (e.g. dev, prod).
- You are reviewing or documenting how Terraform and GitHub Actions should be wired.

## Steps

1. **Environment selection** – Set `ENVIRONMENT` from workflow input or branch (e.g. `workflow_dispatch` input, or main → prod, develop → dev). Do not hardcode environment names in the workflow.
2. **Terraform init** – Always run with the right backend config:
   - `terraform init -backend-config=backend/${{ env.ENVIRONMENT }}/backend.hcl`
   - Use separate state per environment (e.g. different S3 key or prefix).
3. **Terraform plan** – Use the matching variable file:
   - `terraform plan -var-file=environments/${{ env.ENVIRONMENT }}/terraform.tfvars -out=tfplan`
4. **Terraform apply** – Run only on protected branches or after approval; use `tfplan` from the plan step or re-run plan with the same var file.
5. **CI on PRs** – On pull requests, run `terraform fmt -check -recursive` and `terraform validate`; run `terraform plan` with the appropriate env so reviewers see the impact.

## Do

- Use `backend/{environment}/backend.hcl` and `environments/{environment}/terraform.tfvars` for every Terraform command.
- Tag resources when possible (per infrastructure-terraform).
- Keep secrets out of workflow files; use GitHub Secrets or AWS/OIDC.

## Do not

- Use one backend state for multiple environments.
- Hardcode environment names or paths (e.g. `prod`) in the workflow.
- Skip `terraform fmt` and `terraform validate` on PRs.

## Related rules

- `ci-cd-terraform-integration`: backend config and var files per environment; required Terraform steps.
- `infrastructure-terraform`: tagging, folder structure, Terraform for all infra.
