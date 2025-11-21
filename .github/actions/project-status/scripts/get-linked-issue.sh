#!/bin/bash
# get-linked-issue.sh - Gets the first linked issue from a PR
# Usage: ./get-linked-issue.sh <owner> <repo> <pr_number>
# Outputs: has_linked_issue, issue_number, issue_node_id

set -euo pipefail

OWNER="$1"
REPO="$2"
PR_NUMBER="$3"

echo "::group::Fetching linked issue for PR #$PR_NUMBER" >&2

LINKED_ISSUES=$(gh api graphql -f query='
  query($owner: String!, $repo: String!, $prNumber: Int!) {
    repository(owner: $owner, name: $repo) {
      pullRequest(number: $prNumber) {
        closingIssuesReferences(first: 10) {
          nodes { number }
        }
      }
    }
  }
' -f owner="$OWNER" -f repo="$REPO" -F prNumber="$PR_NUMBER")

ISSUE_NUMBER=$(echo "$LINKED_ISSUES" | jq -r '.data.repository.pullRequest.closingIssuesReferences.nodes[0].number')

if [ -z "$ISSUE_NUMBER" ] || [ "$ISSUE_NUMBER" = "null" ]; then
  echo "No linked issue found" >&2
  echo "::endgroup::" >&2
  echo "has_linked_issue=false"
  exit 0
fi

echo "Found linked issue: #$ISSUE_NUMBER" >&2

# Get issue node ID for project status update
ISSUE_ID=$(gh issue view "$ISSUE_NUMBER" --repo "$OWNER/$REPO" --json id --jq '.id')

if [ -z "$ISSUE_ID" ] || [ "$ISSUE_ID" = "null" ]; then
  echo "::error::Failed to get issue node ID" >&2
  echo "::endgroup::" >&2
  echo "has_linked_issue=false"
  exit 0
fi

echo "::endgroup::" >&2
echo "has_linked_issue=true"
echo "issue_number=$ISSUE_NUMBER"
echo "issue_node_id=$ISSUE_ID"
