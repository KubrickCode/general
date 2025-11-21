#!/bin/bash
# get-project-data.sh - Fetches project ID and status field information
# Usage: ./get-project-data.sh <owner> <project_number> [status_field_name]
# Outputs: PROJECT_ID, STATUS_FIELD_ID, and all status option IDs

set -euo pipefail

OWNER="$1"
PROJECT_NUMBER="$2"
STATUS_FIELD_NAME="${3:-Status}"

echo "::group::Fetching project data" >&2

PROJECT_DATA=$(gh api graphql -f query='
  query($owner: String!, $number: Int!) {
    user(login: $owner) {
      projectV2(number: $number) {
        id
        fields(first: 20) {
          nodes {
            ... on ProjectV2SingleSelectField {
              id
              name
              options {
                id
                name
              }
            }
          }
        }
      }
    }
  }
' -f owner="$OWNER" -F number="$PROJECT_NUMBER")

if [ -z "$PROJECT_DATA" ] || [ "$(echo "$PROJECT_DATA" | jq -r '.data.user.projectV2')" = "null" ]; then
  echo "::error::Failed to fetch project data"
  exit 1
fi

PROJECT_ID=$(echo "$PROJECT_DATA" | jq -r '.data.user.projectV2.id')
STATUS_FIELD_ID=$(echo "$PROJECT_DATA" | jq -r --arg name "$STATUS_FIELD_NAME" '.data.user.projectV2.fields.nodes[] | select(.name == $name) | .id')
STATUS_OPTIONS=$(echo "$PROJECT_DATA" | jq -c --arg name "$STATUS_FIELD_NAME" '.data.user.projectV2.fields.nodes[] | select(.name == $name) | .options')

if [ -z "$STATUS_FIELD_ID" ] || [ "$STATUS_FIELD_ID" = "null" ]; then
  echo "::error::Status field '$STATUS_FIELD_NAME' not found in project"
  exit 1
fi

if [ -z "$STATUS_OPTIONS" ] || [ "$STATUS_OPTIONS" = "null" ]; then
  echo "::error::Status options not found for field '$STATUS_FIELD_NAME'"
  exit 1
fi

echo "project_id=$PROJECT_ID"
echo "status_field_id=$STATUS_FIELD_ID"
echo "status_options=$STATUS_OPTIONS"

echo "::endgroup::" >&2
