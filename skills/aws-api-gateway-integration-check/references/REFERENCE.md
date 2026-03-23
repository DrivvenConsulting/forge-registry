## AWS API Gateway integration check – CLI helper

Use this together with the `aws-api-gateway-integration-check` skill to validate that REST APIs, resources, methods, and integrations are configured correctly and reachable.

### Helper script

- `scripts/api-gateway-smoke-test.sh`
  - Lists REST APIs in a region.
  - Optionally lists resources and a specific method for an API.
  - Optionally performs a live HTTP request with `curl`.

Examples:

```bash
REGION=sa-east-1 \
API_ID=abc123 \
./scripts/api-gateway-smoke-test.sh
```

```bash
REGION=sa-east-1 \
BASE_URL="https://abc123.execute-api.sa-east-1.amazonaws.com/prod" \
PATH="/health" \
./scripts/api-gateway-smoke-test.sh
```

### Core AWS CLI commands

- `aws apigateway get-rest-apis --region <region>`
- `aws apigateway get-resources --rest-api-id <api-id> --region <region>`
- `aws apigateway get-method --rest-api-id <api-id> --resource-id <resource-id> --http-method GET --region <region>`

For deeper method testing, you can use the TestInvoke APIs from AWS SDKs or the console:

- TestInvokeMethod
- TestInvokeAuthorizer

### Official documentation

- Testing REST API methods: `https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-test-method.html`
- JWT authorizers (HTTP APIs): `https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-jwt-authorizer.html`
- REST API deployment and stages: `https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-deploy-api.html`

