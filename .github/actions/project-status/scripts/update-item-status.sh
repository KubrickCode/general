#!/bin/bash
# update-item-status.sh - Updates a project item's status field
# Usage: ./update-item-status.sh <project_id> <item_id> <field_id> <option_id>

set -euo pipefail

PROJECT_ID="$1"
ITEM_ID="$2"
FIELD_ID="$3"
OPTION_ID="$4"

echo "::group::Updating item status" >&2
echo "Item: $ITEM_ID -> Option: $OPTION_ID" >&2

RESULT=$(gh api graphql -f query='
  mutation($projectId: ID!, $itemId: ID!, $fieldId: ID!, $optionId: String!) {
    updateProjectV2ItemFieldValue(input: {
      projectId: $projectId
      itemId: $itemId
      fieldId: $fieldId
      value: {singleSelectOptionId: $optionId}
    }) {
      projectV2Item {
        id
      }
    }
  }
' -f projectId="$PROJECT_ID" -f itemId="$ITEM_ID" -f fieldId="$FIELD_ID" -f optionId="$OPTION_ID")

if [ "$(echo "$RESULT" | jq -r '.data.updateProjectV2ItemFieldValue.projectV2Item.id')" = "null" ]; then
  echo "::error::Failed to update item status"
  exit 1
fi

echo "Successfully updated item status" >&2
echo "::endgroup::" >&2
