#!/usr/bin/env bash
set -euo pipefail

# cognito-validate.sh
#
# Basic AWS Cognito User Pool and App Client validation helper.
# Performs:
#   - describe-user-pool
#   - describe-user-pool-client
#   - optional InitiateAuth (USER_PASSWORD_AUTH) when credentials are provided
#
# Requires:
#   - AWS CLI v2
#   - jq
#
# Usage:
#   REGION=sa-east-1 USER_POOL_ID=us-east-1_Example APP_CLIENT_ID=1example ./cognito-validate.sh
#
# Optional env vars:
#   PROFILE           - AWS profile name
#   TEST_USERNAME     - username for InitiateAuth
#   TEST_PASSWORD     - password for InitiateAuth
#

if [[ -z "${USER_POOL_ID:-}" ]]; then
  echo "USER_POOL_ID must be set" >&2
  exit 1
fi

if [[ -z "${APP_CLIENT_ID:-}" ]]; then
  echo "APP_CLIENT_ID must be set" >&2
  exit 1
fi

REGION="${REGION:-sa-east-1}"
PROFILE_OPT=""
if [[ -n "${PROFILE:-}" ]]; then
  PROFILE_OPT="--profile ${PROFILE}"
fi

echo "Using region: ${REGION}"

echo
echo "== Describe User Pool =="
aws cognito-idp describe-user-pool \
  --user-pool-id "${USER_POOL_ID}" \
  --region "${REGION}" \
  ${PROFILE_OPT} \
  | jq '.UserPool | {Id, Name, Status, MfaConfiguration, Policies}'

echo
echo "== Describe App Client =="
aws cognito-idp describe-user-pool-client \
  --user-pool-id "${USER_POOL_ID}" \
  --client-id "${APP_CLIENT_ID}" \
  --region "${REGION}" \
  ${PROFILE_OPT} \
  | jq '.UserPoolClient | {ClientId, ClientName, ExplicitAuthFlows, CallbackURLs, AllowedOAuthFlows, AllowedOAuthScopes}'

if [[ -n "${TEST_USERNAME:-}" && -n "${TEST_PASSWORD:-}" ]]; then
  echo
  echo "== InitiateAuth (USER_PASSWORD_AUTH) =="
  aws cognito-idp initiate-auth \
    --auth-flow USER_PASSWORD_AUTH \
    --client-id "${APP_CLIENT_ID}" \
    --auth-parameters USERNAME="${TEST_USERNAME}",PASSWORD="${TEST_PASSWORD}" \
    --region "${REGION}" \
    ${PROFILE_OPT} \
    > /tmp/cognito-initiate-auth.json

  echo "Tokens (redacted payload fields):"
  jq '{AuthenticationResult: {IdToken: (.AuthenticationResult.IdToken | (.[0:20] + "...")), AccessToken: (.AuthenticationResult.AccessToken | (.[0:20] + "...")), ExpiresIn: .AuthenticationResult.ExpiresIn}}' /tmp/cognito-initiate-auth.json
fi

echo
echo "Cognito validation helper completed."

