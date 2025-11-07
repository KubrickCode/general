---
name: graphql
description: |
  GraphQL API schema design and implementation guide. Type definitions, query/mutation design, pagination, error handling standards.
  TRIGGER: GraphQL schema writing, type definition, Resolver implementation, Connection design, N+1 problem solving
---

# GraphQL API Standards

## Naming Conventions

### Field Naming

- Boolean: Require `is/has/can` prefix
- Date: Require `~At` suffix
- Use consistent terminology throughout the project (unify on either "create" or "add")

## Date Format

- ISO 8601 UTC
- Use DateTime type

## Pagination

### Relay Connection Specification

```graphql
type UserConnection {
  edges: [UserEdge!]!
  pageInfo: PageInfo!
}

type UserEdge {
  node: User!
  cursor: String!
}

type PageInfo {
  hasNextPage: Boolean!
  endCursor: String
}
```

- Parameters: `first`, `after`

## Sorting

- `orderBy: [{ field: "createdAt", order: DESC }]`

## Type Naming

- Input: `{Verb}{Type}Input`
- Connection: `{Type}Connection`
- Edge: `{Type}Edge`

## Input

- Separate creation and modification (required for creation, optional for modification)
- Avoid nesting - IDs only

## Errors

### extensions (default)

- `code`, `field` in `errors[].extensions`

### Union (type safety)

- `User | ValidationError`

## N+1

- DataLoader is mandatory

## Documentation

- `"""description"""` is required
- Explicitly state Input constraints

## Deprecation

- `@deprecated(reason: "...")`
- Never delete types
