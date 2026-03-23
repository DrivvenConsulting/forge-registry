#!/usr/bin/env bash
set -euo pipefail

# aws-discover-resources.sh
#
# Read-only AWS resource discovery helper for QA and feasibility checks.
# Requires:
#   - AWS CLI v2
#   - Credentials/profile with read-only access
#
# Usage:
#   REGION=sa-east-1 PROFILE=default ./aws-discover-resources.sh
#
# Optional env vars:
#   REGION           - AWS region (default: sa-east-1)
#   PROFILE          - AWS profile name (if unset, default AWS CLI resolution applies)
#   NAME_FILTER      - substring to filter resource names (case-sensitive)
#

REGION="${REGION:-sa-east-1}"
PROFILE_OPT=""
if [[ -n "${PROFILE:-}" ]]; then
  PROFILE_OPT="--profile ${PROFILE}"
fi

NAME_FILTER="${NAME_FILTER:-}"

echo "Using region: ${REGION}"
if [[ -n "${PROFILE_OPT}" ]]; then
  echo "Using profile: ${PROFILE}"
fi
if [[ -n "${NAME_FILTER}" ]]; then
  echo "Filtering resources by name containing: ${NAME_FILTER}"
fi

echo
echo "== Cognito User Pools =="
aws cognito-idp list-user-pools --max-results 60 --region "${REGION}" ${PROFILE_OPT} \
  | jq -r '.UserPools[] | "\(.Name) (\(.Id))"' \
  | (if [[ -n "${NAME_FILTER}" ]]; then grep "${NAME_FILTER}" || true; else cat; fi)

echo
echo "== Lambda Functions =="
aws lambda list-functions --region "${REGION}" ${PROFILE_OPT} \
  | jq -r '.Functions[] | "\(.FunctionName) (\(.FunctionArn))"' \
  | (if [[ -n "${NAME_FILTER}" ]]; then grep "${NAME_FILTER}" || true; else cat; fi)

echo
echo "== API Gateway (REST APIs) =="
aws apigateway get-rest-apis --region "${REGION}" ${PROFILE_OPT} \
  | jq -r '.items[] | "\(.name) (\(.id))"' \
  | (if [[ -n "${NAME_FILTER}" ]]; then grep "${NAME_FILTER}" || true; else cat; fi)

echo
echo "== DynamoDB Tables =="
aws dynamodb list-tables --region "${REGION}" ${PROFILE_OPT} \
  | jq -r '.TableNames[]' \
  | (if [[ -n "${NAME_FILTER}" ]]; then grep "${NAME_FILTER}" || true; else cat; fi)

echo
echo "== S3 Buckets (global) =="
aws s3api list-buckets ${PROFILE_OPT} \
  | jq -r '.Buckets[] | .Name' \
  | (if [[ -n "${NAME_FILTER}" ]]; then grep "${NAME_FILTER}" || true; else cat; fi)

echo
echo "== SNS Topics =="
aws sns list-topics --region "${REGION}" ${PROFILE_OPT} \
  | jq -r '.Topics[] | .TopicArn' \
  | (if [[ -n "${NAME_FILTER}" ]]; then grep "${NAME_FILTER}" || true; else cat; fi)

echo
echo "Discovery complete."

