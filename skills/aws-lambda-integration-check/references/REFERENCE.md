## AWS Lambda integration check – CLI helper

Use this together with the `aws-lambda-integration-check` skill to validate that a Lambda function exists, is configured correctly, and can be invoked successfully.

### Helper script

- `scripts/lambda-validate.sh`
  - Describes the function via `aws lambda get-function`.
  - Optionally invokes it with a test event.
  - Optionally shows recent CloudWatch log events.

Example:

```bash
FUNCTION_NAME=my-function \
REGION=sa-east-1 \
EVENT_FILE=assets/lambda-test-event.json \
SHOW_LOGS=true \
./scripts/lambda-validate.sh
```

### Core AWS CLI commands

- `aws lambda get-function --function-name <name> --region <region>`
- `aws lambda invoke --function-name <name> --payload file://event.json --region <region> out.json`
- `aws logs filter-log-events --log-group-name /aws/lambda/<name> --limit 50 --region <region>`

### Official documentation

- Lambda testing guide: `https://docs.aws.amazon.com/lambda/latest/dg/testing-guide.html`
- Lambda Developer Guide: `https://docs.aws.amazon.com/lambda/latest/dg/welcome.html`

