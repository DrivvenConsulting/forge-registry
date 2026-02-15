---
name: github-actions-lambda-deploy
description: Add or update a GitHub Actions job that deploys a Python Lambda by packaging, uploading to S3, and updating function code. Use when creating or changing CI workflows that deploy AWS Lambda functions.
---

# Skill: GitHub Actions – Deploy Lambda (Python)

Add a CI job that builds a Python Lambda package, uploads it to S3, and updates the Lambda function code.

## When to use

- You are adding or changing a CI/CD workflow that deploys an AWS Lambda function.
- The Lambda runtime is Python and dependencies are in `requirements.txt` with application code in `src/` (or equivalent).
- You need the job to run after Terraform (or other infra) when the pipeline uses `needs: terraform`.

## Steps

1. **Checkout** – Use `actions/checkout@v4` (or current major).
2. **Configure AWS credentials** – Use OIDC: `aws-actions/configure-aws-credentials@v4` with `role-to-assume: arn:aws:iam::${{ vars.AWS_ACCOUNT_ID }}:role/TerraformDeployRole` and `aws-region: ${{ env.AWS_REGION }}`. Do not use static keys; use GitHub vars (e.g. `vars.AWS_ACCOUNT_ID`, `vars.AWS_REGION`) for account and region.
3. **Set env and outputs** – In a step with `id: env`, set `ENVIRONMENT` from workflow (e.g. `github.event.inputs.environment` or branch: main → prod, development → dev). Map to a Terraform-style name (e.g. prod → `production`, dev → `development`). Derive `BUCKET` and `FUNCTION_NAME` from that and `vars.AWS_ACCOUNT_ID` (e.g. `BUCKET="<project>-lambda-${TF_ENVIRONMENT}-${AWS_ACCOUNT_ID}"`, `FUNCTION_NAME="<project>-${TF_ENVIRONMENT}"`). Write them to `GITHUB_OUTPUT` so later steps use `steps.env.outputs.BUCKET` and `steps.env.outputs.FUNCTION_NAME`. Do not hardcode bucket or function names; derive from env and account.
4. **Set up Python** – Use `actions/setup-python@v5` with the project’s Python version (e.g. `"3.12"`).
5. **Build package** – Install dependencies into a directory, copy application code, then zip:
   - `pip install -r requirements.txt --target package/`
   - `cp -r src/* package/` (adjust if the app lives elsewhere)
   - `cd package && zip -r ../lambda.zip . && cd ..`
6. **Upload and update Lambda** – Upload the zip to S3 with a unique key (e.g. `<project>-${{ github.sha }}.zip`), then call:
   - `aws s3 cp lambda.zip "s3://${{ steps.env.outputs.BUCKET }}/$KEY"`
   - `aws lambda update-function-code --function-name "${{ steps.env.outputs.FUNCTION_NAME }}" --s3-bucket "${{ steps.env.outputs.BUCKET }}" --s3-key "$KEY"`

## Job conditions

- Run only on push to protected branches (e.g. main, development) or on `workflow_dispatch` (optionally with a “skip deploy” input). Use `if:` so the job does not run on every PR unless intended.
- Use `needs: terraform` (or the relevant infra job) when Terraform provisions the bucket and Lambda so they exist before deploy.

## Do

- Use repository variables for `AWS_ACCOUNT_ID` and `AWS_REGION`; use OIDC for credentials.
- Derive S3 bucket and Lambda function name from environment and account (e.g. from Terraform naming).
- Gate the job on push or workflow_dispatch so deploys are controlled.

## Do not

- Hardcode S3 bucket names, function names, account IDs, or regions in the workflow.
- Run deploy on every pull request unless the project explicitly requires it.
- Store AWS access keys in the workflow; use OIDC only.

## Example job (reference)

```yaml
deploy-lambda:
  name: Deploy Lambda
  runs-on: ubuntu-latest
  needs: terraform
  if: >
    (github.event_name == 'push' && (github.ref == 'refs/heads/main' || github.ref == 'refs/heads/development'))
    || (github.event_name == 'workflow_dispatch' && !inputs.skip_deploy)
  env:
    ENVIRONMENT: ${{ github.event.inputs.environment || (github.ref == 'refs/heads/main' && 'prod' || 'dev') }}
    AWS_REGION: ${{ vars.AWS_REGION || 'sa-east-1' }}
  environment: ${{ github.event.inputs.environment || (github.ref == 'refs/heads/main' && 'prod' || 'dev') }}

  steps:
    - name: Checkout
      uses: actions/checkout@v4

    - name: Configure AWS credentials
      uses: aws-actions/configure-aws-credentials@v4
      with:
        role-to-assume: arn:aws:iam::${{ vars.AWS_ACCOUNT_ID }}:role/TerraformDeployRole
        aws-region: ${{ env.AWS_REGION }}

    - name: Set env and account
      id: env
      run: |
        if [ "${{ env.ENVIRONMENT }}" = "prod" ]; then
          TF_ENVIRONMENT=production
        else
          TF_ENVIRONMENT=development
        fi
        AWS_ACCOUNT_ID="${{ vars.AWS_ACCOUNT_ID }}"
        BUCKET="<project>-lambda-${TF_ENVIRONMENT}-${AWS_ACCOUNT_ID}"
        FUNCTION_NAME="<project>-${TF_ENVIRONMENT}"
        echo "BUCKET=$BUCKET" >> $GITHUB_OUTPUT
        echo "FUNCTION_NAME=$FUNCTION_NAME" >> $GITHUB_OUTPUT

    - name: Set up Python
      uses: actions/setup-python@v5
      with:
        python-version: "3.12"

    - name: Install dependencies and build package
      run: |
        pip install -r requirements.txt --target package/
        cp -r src/* package/
        cd package && zip -r ../lambda.zip . && cd ..

    - name: Upload to S3 and update Lambda
      run: |
        KEY="<project>-${{ github.sha }}.zip"
        aws s3 cp lambda.zip "s3://${{ steps.env.outputs.BUCKET }}/$KEY"
        aws lambda update-function-code \
          --function-name "${{ steps.env.outputs.FUNCTION_NAME }}" \
          --s3-bucket "${{ steps.env.outputs.BUCKET }}" \
          --s3-key "$KEY"
```

Replace `<project>` with the actual project or service name (e.g. `adlyze-auth`).

## Related rules

- `ci-cd-github-actions`: no hardcoded secrets or env-specific paths; use vars and OIDC.
- `aws-lambda`: handler structure, env vars for config, thin handlers.
