---
name: graphql
description: |
  GraphQL API 스키마 설계 및 구현 가이드. 타입 정의, 쿼리/뮤테이션 설계, 페이지네이션, 에러 처리 등 표준.
  TRIGGER: GraphQL 스키마 작성, 타입 정의, Resolver 구현, Connection 설계, N+1 문제 해결
---

# GraphQL API Standards

## 네이밍 규칙

### 필드 네이밍

- boolean: `is/has/can` 접두사 강제
- 날짜: `~At` 접미사 강제
- 같은 개념은 프로젝트 전체 동일 용어 (create vs add 중 하나로 통일)

## 날짜 형식

- ISO 8601 UTC
- DateTime 타입 사용

## 페이지네이션

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

- 파라미터: `first`, `after`

## 정렬

- `orderBy: [{ field: "createdAt", order: DESC }]`

## 타입 네이밍

- Input: `{동사}{타입}Input`
- Connection: `{타입}Connection`
- Edge: `{타입}Edge`

## Input

- 생성/수정 분리 (생성은 필수, 수정은 선택)
- 중첩 피하기 - ID만

## 에러

### extensions (기본)

- `errors[].extensions`에 `code`, `field`

### Union (타입 안정성)

- `User | ValidationError`

## N+1

- DataLoader 강제

## 문서화

- `"""설명"""` 필수
- Input 제약사항 명시

## Deprecation

- `@deprecated(reason: "...")`
- 타입 삭제 금지
