---
name: aws-api-gateway-integration-check
description: Validates API Gateway deployment, routes, auth integration, and real endpoint behavior.
---

# AWS API Gateway Integration Check

Ensure API Gateway routes behave as documented.

## When to Use
- After API Gateway deployment
- When diagnosing 4xx/5xx issues

## Best Practices

- Test **in the cloud**; use console "Test" or **TestInvokeMethod** (and for authorizers **TestInvokeAuthorizer**) to simulate real behavior including auth and integration.
- For **REST APIs:** Validate method request (query, headers, body) and integration (type: Lambda proxy vs non-proxy; mapping if non-proxy); note that proxy integration forwards the full request and expects Lambda to return `statusCode`, `headers`, `body`.
- **Request validation:** If enabled, ensure required parameters and body schema are validated (400 on failure); CloudWatch can show validation results.
- **Auth:** If using Cognito JWT authorizer, validate issuer, audience, and scopes; use TestInvokeAuthorizer with a valid token to confirm 200 and claims.

## Validation Steps

Follow in order. Use AWS APIs (e.g. GetRestApi, GetStage, GetMethod, TestInvokeMethod, TestInvokeAuthorizer), CLI, or HTTP client as available.

1. **API and stage:** Confirm REST/HTTP API and stage exist; obtain invoke URL and API ID.
2. **Resources and methods:** List resources and methods; verify expected routes (path + method) and integration type (Lambda proxy vs non-proxy).
3. **Integration:** For each critical route, confirm integration target (Lambda ARN or URI); for Lambda proxy, ensure no conflicting response mapping.
4. **Request validation:** If configured, verify required params/body and test with invalid request to get 400.
5. **Auth (Cognito JWT):** If authorizer is attached, obtain a valid ID/access token from Cognito (e.g. from aws-cognito-integration-check output); call TestInvokeAuthorizer (REST) or send request with `Authorization` header and check 200 vs 401; validate claims (iss, aud, exp) match authorizer config.
6. **Live request:** Execute real request (Postman MCP preferred if available, else HTTP client) to the stage URL; assert status, body, and headers; optionally compare with TestInvokeMethod result.
7. **CORS:** If documented, verify OPTIONS and expected CORS headers for browser use.

## Output

Report structured results per route/authorizer:

- **Pass/fail** per check
- **Status codes** and response snippets
- **Remediation** on failure (e.g. "Check authorizer audience vs token `aud`")
- **Severity:** Critical / High / Medium / Low (align with integration-test agent reporting)

## References

- [Use the API Gateway console to test a REST API method](https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-test-method.html)
- [Control access to HTTP APIs with JWT authorizers](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-jwt-authorizer.html)
- [Troubleshooting JWT authorizers](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-troubleshooting-jwt.html)
