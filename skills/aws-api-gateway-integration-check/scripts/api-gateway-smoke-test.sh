#!/usr/bin/env bash
set -euo pipefail

# api-gateway-smoke-test.sh
#
# Basic AWS API Gateway (REST) smoke test helper.
# Performs:
#   - get-rest-apis
#   - get-resources / get-method for a specific API
#   - optional live HTTP request via curl
#
# Requires:
#   - AWS CLI v2
#   - jq
#   - curl
#
# Usage:
#   REGION=sa-east-1 API_ID=abc123 ./api-gateway-smoke-test.sh
#   REGION=sa-east-1 BASE_URL="https://abc123.execute-api.sa-east-1.amazonaws.com/prod" PATH="/health" ./api-gateway-smoke-test.sh
#

REGION="${REGION:-sa-east-1}"

PROFILE_OPT=""
if [[ -n "${PROFILE:-}" ]]; then
  PROFILE_OPT="--profile ${PROFILE}"
fi

echo "Using region: ${REGION}"

echo
echo "== REST APIs in region =="
aws apigateway get-rest-apis --region "${REGION}" ${PROFILE_OPT} \
  | jq -r '.items[] | "\(.name) (\(.id))"'

if [[ -n "${API_ID:-}" ]]; then
  echo
  echo "== Resources for API ${API_ID} =="
  aws apigateway get-resources --rest-api-id "${API_ID}" --region "${REGION}" ${PROFILE_OPT} \
    | jq -r '.items[] | "\(.id) \(.path)"'

  if [[ -n "${RESOURCE_ID:-}" && -n "${HTTP_METHOD:-}" ]]; then
    echo
    echo "== Method ${HTTP_METHOD} on resource ${RESOURCE_ID} =="
    aws apigateway get-method \
      --rest-api-id "${API_ID}" \
      --resource-id "${RESOURCE_ID}" \
      --http-method "${HTTP_METHOD}" \
      --region "${REGION}" ${PROFILE_OPT} \
      | jq '{httpMethod, authorizationType, apiKeyRequired, methodIntegration}'
  fi
fi

if [[ -n "${BASE_URL:-}" && -n "${PATH:-}" ]]; then
  FULL_URL="${BASE_URL%/}${PATH}"
  echo
  echo "== Live request to ${FULL_URL} =="
  curl -i "${FULL_URL}"
fi

echo
echo "API Gateway smoke test helper completed."

