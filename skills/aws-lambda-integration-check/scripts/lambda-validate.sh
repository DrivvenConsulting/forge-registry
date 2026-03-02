#!/usr/bin/env bash
set -euo pipefail

# lambda-validate.sh
#
# Basic AWS Lambda integration validation helper.
# Performs:
#   - get-function (existence + config)
#   - optional invoke with a test event
#   - optional recent log inspection
#
# Requires:
#   - AWS CLI v2
#   - jq
#
# Usage:
#   FUNCTION_NAME=my-func REGION=sa-east-1 ./lambda-validate.sh
#
# Optional env vars:
#   PROFILE      - AWS profile name
#   EVENT_FILE   - path to JSON file with test event (for invoke)
#   SHOW_LOGS    - if set to "true", tail recent CloudWatch log events
#

if [[ -z "${FUNCTION_NAME:-}" ]]; then
  echo "FUNCTION_NAME must be set" >&2
  exit 1
fi

REGION="${REGION:-sa-east-1}"
PROFILE_OPT=""
if [[ -n "${PROFILE:-}" ]]; then
  PROFILE_OPT="--profile ${PROFILE}"
fi

echo "== Lambda: describe function =="
aws lambda get-function --function-name "${FUNCTION_NAME}" --region "${REGION}" ${PROFILE_OPT} \
  | jq '.Configuration | {FunctionName, Runtime, Handler, Timeout, MemorySize, Role, Environment}'

if [[ -n "${EVENT_FILE:-}" && -f "${EVENT_FILE}" ]]; then
  echo
  echo "== Lambda: invoke with test event (${EVENT_FILE}) =="
  OUT_FILE="$(mktemp)"
  aws lambda invoke \
    --function-name "${FUNCTION_NAME}" \
    --region "${REGION}" \
    ${PROFILE_OPT} \
    --payload "file://${EVENT_FILE}" \
    "${OUT_FILE}" >/dev/null

  echo "Response payload:"
  cat "${OUT_FILE}" | jq .
  rm -f "${OUT_FILE}"
else
  echo
  echo "Skipping invoke (EVENT_FILE not set or missing)."
fi

if [[ "${SHOW_LOGS:-false}" == "true" ]]; then
  echo
  echo "== CloudWatch Logs (recent events) =="
  LOG_GROUP="/aws/lambda/${FUNCTION_NAME}"
  aws logs filter-log-events \
    --log-group-name "${LOG_GROUP}" \
    --region "${REGION}" \
    ${PROFILE_OPT} \
    --limit 50 \
    | jq '.events[] | {timestamp, message}'
fi

echo
echo "Lambda validation helper completed."

