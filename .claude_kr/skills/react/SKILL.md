---
name: react
description: |
  React 컴포넌트 개발을 위한 모범 사례와 코딩 규칙. 컴포넌트 구조, 상태 관리, Hook 사용법, 성능 최적화.
  TRIGGER: React 컴포넌트, .tsx/.jsx 파일, useState/useEffect Hook, 상태 관리, 조건부 렌더링, props 설계
---

# React Development Standards

## 컴포넌트 구조

### 파일당 컴포넌트 규칙

export되는 컴포넌트는 가능하면 하나만, 내부 사용 컴포넌트는 필요시 여러개 허용(권장하진 않음).

- export default 사용 금지 (리팩토링과 트리쉐이킹 문제)
- named export만 사용
- 내부 헬퍼 컴포넌트는 export 금지
- 컴포넌트 파일 내 순서: 메인 export 컴포넌트 → 추가 export 컴포넌트 → 내부 헬퍼 컴포넌트

## 상태 관리 규칙

### 상태 관리 계층

1. **로컬 상태 (useState)**: 단일 컴포넌트에서만 사용
2. **Props Drilling**: 최대 2단계까지만 허용
3. **Context API**: 3단계 이상 prop drilling 필요시
4. **전역 상태 (Zustand 등)**:
   - 5개 이상 컴포넌트에서 공유
   - 서버 상태 동기화 필요
   - 복잡한 상태 로직 (computed, actions)
   - 개발자 도구 지원 필요시

## Hook 사용 규칙

### 커스텀 Hook 추출 기준

- 3개 이상의 useState/useEffect 조합
- 2개 이상의 컴포넌트에서 재사용
- 50줄 이상의 로직

### useEffect 사용 최소화

- useEffect는 외부 시스템 동기화에만 사용
- 상태 업데이트는 이벤트 핸들러에서 처리
- 계산된 값은 useMemo 또는 컴포넌트 내 직접 계산
- 정말 필요한 경우만 사용하고 주석으로 이유 명시

```typescript
// ❌ Bad: useEffect로 상태 동기화
useEffect(() => {
  setFullName(`${firstName} ${lastName}`);
}, [firstName, lastName]);

// ✅ Good: 직접 계산
const fullName = `${firstName} ${lastName}`;
```

## Props 규칙

### 공용 컴포넌트 Props 추가 규칙

- 새 prop 추가 전 구조 재검토 필수(공용 레벨의 무분별한 prop 추가 방지)
- 단일 책임 원칙 위반 여부 확인
- 3개 이상의 선택적 props는 composition 패턴 고려
- variant prop으로 통합 가능한지 검토

## 조건부 렌더링

### 기본 규칙

```typescript
// 단순 조건: && 연산자
{isLoggedIn && <UserMenu />}

// 양자택일: 삼항 연산자
{isLoggedIn ? <UserMenu /> : <LoginButton />}

// 복잡한 조건: 별도 함수 또는 early return
const renderContent = () => {
  if (status === 'loading') return <Loader />;
  if (status === 'error') return <Error />;
  return <Content />;
};
```

### Activity 컴포넌트

- 숨겨진 부분을 미리 렌더링하거나 상태 유지가 필요한 경우 사용
- visible/hidden 모드로 관리
- 탭 전환, 모달 내용 등 자주 토글되는 UI에 활용

## 메모이제이션

### React Compiler 사용

- 자동 메모이제이션에 의존
- 수동 메모이제이션(React.memo, useMemo, useCallback)은 특수한 경우에만 사용
- 컴파일러가 최적화하지 못하는 경우 escape hatch로 활용
