## AWS CLI – integration validation helpers

This skill uses the AWS CLI in **read-only** mode to validate deployed services and to support the dedicated integration-check skills for Cognito, API Gateway, and Lambda.

### Core commands

- **Cognito user pools**
  - `aws cognito-idp list-user-pools --max-results 60 --region <region>`
  - `aws cognito-idp describe-user-pool --user-pool-id <user-pool-id> --region <region>`
- **Lambda**
  - `aws lambda list-functions --region <region>`
  - `aws lambda get-function --function-name <name> --region <region>`
  - `aws lambda invoke --function-name <name> --payload file://event.json --region <region> out.json`
- **API Gateway (REST)**
  - `aws apigateway get-rest-apis --region <region>`
  - `aws apigateway get-resources --rest-api-id <api-id> --region <region>`
  - `aws apigateway get-method --rest-api-id <api-id> --resource-id <resource-id> --http-method GET --region <region>`
- **Logs (CloudWatch)**
  - `aws logs filter-log-events --log-group-name /aws/lambda/<function-name> --region <region> --limit 50`

See `scripts/aws-discover-resources.sh` for a concrete read-only discovery script that runs a subset of these commands for Cognito, Lambda, API Gateway, DynamoDB, S3, and SNS.

### Official documentation

- AWS CLI reference: `https://docs.aws.amazon.com/cli/latest/index.html`
- Lambda testing and examples: `https://docs.aws.amazon.com/lambda/latest/dg/testing-guide.html`
- API Gateway testing: `https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-test-method.html`
- Cognito authentication: `https://docs.aws.amazon.com/cognito/latest/developerguide/authentication.html`

