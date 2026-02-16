---
name: aws-cognito-integration-check
description: Validates Cognito User Pool, App Client, and auth flow readiness.
---

# AWS Cognito Integration Check

Validate that Cognito is correctly provisioned and usable for real authentication flows.

## When to Use
- After deploying Cognito resources
- When API Gateway uses a Cognito Authorizer

## Best Practices

- Validate **User Pool and App Client** existence and **ExplicitAuthFlows** (e.g. `ALLOW_USER_SRP_AUTH`, `ALLOW_USER_PASSWORD_AUTH`, `ALLOW_REFRESH_TOKEN_AUTH`) match the intended auth flow (SDK vs managed login).
- For **API Gateway JWT authorizer:** Ensure issuer (`iss`) and audience (`aud` or `client_id`) match the authorizer configuration; token must contain required claims (`kid`, `iss`, `aud`/`client_id`, `exp`, `nbf`, `iat`, and scope if required).
- **Domain:** If using hosted UI or OIDC endpoints, confirm user pool domain is set and reachable (e.g. `https://<domain>.auth.<region>.amazoncognito.com`).
- **Security:** Align with least privilege; avoid exposing detailed errors that enable account enumeration.

## Validation Steps

Follow in order. Use AWS APIs (e.g. DescribeUserPool, DescribeUserPoolClient, InitiateAuth), CLI, or SDK as available.

1. **Environment inputs:** Collect region, User Pool ID, App Client ID; optionally domain name and callback URLs if using hosted UI.
2. **User Pool:** Describe User Pool; confirm status and policies (e.g. password policy, MFA if required).
3. **App Client:** Describe App Client; verify ExplicitAuthFlows, supported identity providers, and (if OAuth) callback URLs and scopes.
4. **Domain:** If applicable, confirm domain and JWKS URL (e.g. `https://cognito-idp.<region>.amazonaws.com/<userPoolId>/.well-known/jwks.json`) for JWT validation.
5. **Auth smoke test:** Perform InitiateAuth (e.g. USER_PASSWORD_AUTH or USER_SRP_AUTH with test credentials); assert tokens in response (IdToken, AccessToken, RefreshToken); decode JWT and verify `iss`, `aud`/`client_id`, `exp` for use with API Gateway.
6. **Token for API Gateway:** If API Gateway uses Cognito authorizer, use the IdToken (or AccessToken per authorizer config) in the next step of the integration-check flow (aws-api-gateway-integration-check); document token source (e.g. "Obtained via InitiateAuth for App Client X").

## Output

Report structured results:

- **Pass/fail** per check
- On **success:** provide token (or token placeholder) and issuer/audience for downstream API Gateway validation
- On **failure:** remediation (e.g. "Enable ALLOW_USER_PASSWORD_AUTH on App Client")
- **Severity:** Critical / High / Medium / Low (align with integration-test agent reporting)

## References

- [Authentication with Amazon Cognito user pools](https://docs.aws.amazon.com/cognito/latest/developerguide/authentication.html)
- [Security best practices for Amazon Cognito user pools](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-security-best-practices.html)
