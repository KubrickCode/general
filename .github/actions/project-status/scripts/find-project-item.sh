#!/bin/bash
# find-project-item.sh - Finds an issue/PR item in a project with pagination
# Usage: ./find-project-item.sh <project_id> <content_id> [max_pages]
# Outputs: item_id or empty string if not found

set -euo pipefail

PROJECT_ID="$1"
CONTENT_ID="$2"
MAX_PAGES="${3:-10}"

echo "::group::Searching for item in project" >&2
echo "Looking for content: $CONTENT_ID" >&2

CURSOR=""
FOUND=false
ITEM_ID=""

for ((i=1; i<=MAX_PAGES; i++)); do
  if [ -z "$CURSOR" ]; then
    ITEMS_QUERY=$(gh api graphql -f query='
      query($projectId: ID!) {
        node(id: $projectId) {
          ... on ProjectV2 {
            items(first: 100) {
              pageInfo {
                hasNextPage
                endCursor
              }
              nodes {
                id
                content {
                  ... on Issue { id }
                  ... on PullRequest { id }
                }
              }
            }
          }
        }
      }
    ' -f projectId="$PROJECT_ID")
  else
    ITEMS_QUERY=$(gh api graphql -f query='
      query($projectId: ID!, $cursor: String!) {
        node(id: $projectId) {
          ... on ProjectV2 {
            items(first: 100, after: $cursor) {
              pageInfo {
                hasNextPage
                endCursor
              }
              nodes {
                id
                content {
                  ... on Issue { id }
                  ... on PullRequest { id }
                }
              }
            }
          }
        }
      }
    ' -f projectId="$PROJECT_ID" -f cursor="$CURSOR")
  fi

  ITEM_ID=$(echo "$ITEMS_QUERY" | jq -r --arg CID "$CONTENT_ID" '.data.node.items.nodes[] | select(.content.id == $CID) | .id')

  if [ -n "$ITEM_ID" ] && [ "$ITEM_ID" != "null" ]; then
    FOUND=true
    break
  fi

  HAS_NEXT=$(echo "$ITEMS_QUERY" | jq -r '.data.node.items.pageInfo.hasNextPage')
  if [ "$HAS_NEXT" = "false" ]; then
    break
  fi

  CURSOR=$(echo "$ITEMS_QUERY" | jq -r '.data.node.items.pageInfo.endCursor')
  echo "Page $i completed, continuing..." >&2
done

echo "::endgroup::" >&2

if [ "$FOUND" = true ] && [ -n "$ITEM_ID" ] && [ "$ITEM_ID" != "null" ]; then
  echo "item_id=$ITEM_ID"
else
  echo "::warning::Item not found in project after searching $MAX_PAGES pages" >&2
  echo "item_id="
fi
