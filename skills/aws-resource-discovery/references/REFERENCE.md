## AWS resource discovery

Use this skill for **read-only** exploration of existing AWS resources. It is typically used in feasibility analysis and Phase 4 integration validation to confirm that Cognito, API Gateway, Lambda, DynamoDB, S3, SNS, and related services are present and named as expected.

### Core commands

The following AWS CLI commands are commonly used:

- Cognito user pools:
  - `aws cognito-idp list-user-pools --max-results 60 --region <region>`
  - `aws cognito-idp describe-user-pool --user-pool-id <user-pool-id> --region <region>`
- Lambda:
  - `aws lambda list-functions --region <region>`
  - `aws lambda get-function --function-name <name> --region <region>`
- API Gateway:
  - `aws apigateway get-rest-apis --region <region>`
  - `aws apigateway get-resources --rest-api-id <api-id> --region <region>`
- DynamoDB:
  - `aws dynamodb list-tables --region <region>`
- S3:
  - `aws s3api list-buckets`
- SNS:
  - `aws sns list-topics --region <region>`

You can also reuse `skills/aws-cli/scripts/aws-discover-resources.sh` as a practical discovery helper.

### Official documentation

- AWS CLI reference: `https://docs.aws.amazon.com/cli/latest/index.html`
- Service guides (Lambda, API Gateway, Cognito, DynamoDB, S3, SNS) linked under: `https://aws.amazon.com/documentation/`

