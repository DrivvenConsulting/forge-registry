---
name: aws-lambda-integration-check
description: Validates Lambda readiness, configuration, permissions, and real invocations.
---

# AWS Lambda Integration Check

Ensure Lambda is runnable and correctly integrated.

## When to Use
- After Lambda deployment
- When used behind API Gateway

## Best Practices

- Prefer **cloud-based validation** over mocks/emulators for integration checks; cloud tests validate IAM, quotas, timeouts, and real service behavior.
- Validate **configuration**: timeout, memory, environment variables, and execution role (e.g. CloudWatch Logs permission).
- For integration tests: verify the function is **actually invoked** by the trigger (e.g. API Gateway) and that **input/output** match expectations; do not rely only on direct invoke with a static payload.

## Validation Steps

Follow in order. Use AWS APIs (e.g. GetFunction, Invoke, GetPolicy), CLI, or SDK as available.

1. **Existence and config:** Describe function (e.g. GetFunction); confirm runtime, handler, timeout, memory, env vars; note role ARN.
2. **Permissions:** Confirm resource-based policy allows API Gateway (or other trigger) to invoke; confirm execution role has required permissions (e.g. CloudWatch, downstream services).
3. **Direct invoke:** Invoke with a test event (e.g. API Gateway proxy event JSON); assert success and expected response shape (e.g. `statusCode`, `body` for proxy).
4. **Via API Gateway:** If applicable, call the deployed API endpoint and assert response; confirms integration + IAM end-to-end.
5. **CloudWatch:** Optionally check recent log streams for the function to confirm execution and absence of runtime errors.

## Output

Report structured results for each check:

- **Pass/fail** per check
- **Evidence:** response codes, snippet of response, resource IDs
- **Remediation hints** on failure (e.g. "Add lambda:InvokeFunction to API Gateway execution role")
- **Severity:** Critical / High / Medium / Low (align with integration-test agent reporting)

## References

- [How to test serverless functions and applications](https://docs.aws.amazon.com/lambda/latest/dg/testing-guide.html)
- [Best practices for testing serverless applications](https://docs.aws.amazon.com/prescriptive-guidance/latest/serverless-application-testing/best-practices.html)
