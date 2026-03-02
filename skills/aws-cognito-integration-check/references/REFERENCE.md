## AWS Cognito integration check – CLI helper

Use this together with the `aws-cognito-integration-check` skill to validate that a User Pool and App Client are configured correctly and ready for authentication flows (and for use with API Gateway JWT authorizers).

### Helper script

- `scripts/cognito-validate.sh`
  - Describes a User Pool and App Client.
  - Optionally performs `InitiateAuth` using test credentials.

Example:

```bash
REGION=sa-east-1 \
USER_POOL_ID=us-east-1_example \
APP_CLIENT_ID=1example23456789 \
TEST_USERNAME="test@example.com" \
TEST_PASSWORD="ExamplePassword123!" \
./scripts/cognito-validate.sh
```

### Core AWS CLI commands

- `aws cognito-idp describe-user-pool --user-pool-id <user-pool-id> --region <region>`
- `aws cognito-idp describe-user-pool-client --user-pool-id <user-pool-id> --client-id <app-client-id> --region <region>`
- `aws cognito-idp initiate-auth --auth-flow USER_PASSWORD_AUTH --client-id <app-client-id> --auth-parameters USERNAME=<u>,PASSWORD=<p> --region <region>`

### Official documentation

- Cognito authentication flows: `https://docs.aws.amazon.com/cognito/latest/developerguide/authentication.html`
- User pool security best practices: `https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-security-best-practices.html`

