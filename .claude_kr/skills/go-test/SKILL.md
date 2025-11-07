---
name: go-test
description: |
  Go 테스트 코드 작성을 위한 표준 testing 패키지 가이드. 테이블 기반 테스트, 서브테스트, 벤치마크 패턴.
  TRIGGER: _test.go 파일 작업, testing.T, t.Run, 테이블 테스트, 벤치마크, 테스트 작성 요청
---

# Go 테스트 코드 작성 가이드

## 테스트 파일 구조

테스트 대상 파일과 1:1 매칭. 테스트 파일은 대상 파일과 동일한 디렉토리에 위치.

## 파일 명명

`{대상파일명}_test.go` 형식.

**예시:** `user.go` → `user_test.go`

## 테스트 계층

메서드(함수) 단위로 대단원 구성, 각 케이스별로 소단원 작성. 복잡한 메서드는 시나리오별 중단원 추가 가능.

## 테스트 범위 선택

자명하거나 지나치게 단순한 로직(단순 getter, 상수 반환)은 생략. 비즈니스 로직, 조건 분기, 외부 의존성이 있는 코드를 우선 테스트.

## 테스트 케이스 구성

기본 성공 케이스 최소 1개 필수. 주요 초점은 실패 케이스, 경계값(boundary), 엣지 케이스, 예외 상황에 둠.

## 테스트 독립성

각 테스트는 독립적으로 실행 가능해야 함. 테스트 간 실행 순서 의존 금지. 공유 상태 사용 시 각 테스트마다 초기화.

## Given-When-Then 패턴

테스트 코드를 3단계로 구조화—Given(준비), When(실행), Then(검증). 복잡한 테스트는 주석이나 빈 줄로 단계 구분.

## 테스트 데이터

하드코딩된 의미 있는 값 사용. 랜덤 데이터는 재현 불가능한 실패를 유발하므로 피함. 필요시 시드 고정.

## 모킹 원칙

외부 의존성(API, DB, 파일 시스템)은 모킹. 같은 프로젝트 내 모듈은 가급적 실제 사용, 복잡도가 높을 때만 모킹.

## 테스트 재사용

반복되는 모킹 설정, 픽스처, 헬퍼 함수는 공통 유틸로 추출. 단, 과도한 추상화로 테스트 가독성을 해치지 않도록 주의.

## 통합/E2E 테스트

유닛 테스트가 우선. 통합/E2E는 복잡한 흐름이나 여러 모듈 상호작용이 코드만으로 파악 어려울 때 작성. 별도 디렉토리(`tests/integration`, `tests/e2e`)에 위치.

## 테스트 명명

테스트 이름은 "무엇을 테스트하는가"를 명확히 표현. "~할 때 ~해야 한다" 형태 권장. 구현 세부사항보다 행동(behavior) 중심.

## 단언(Assertion) 수

하나의 테스트에서 여러 관련 단언은 허용하되, 서로 다른 개념을 검증하는 경우 테스트 분리.

## 테스트 함수

`func TestXxx(t *testing.T)` 형식. 메서드별로 `TestMethodName` 함수 작성, `t.Run()`으로 서브테스트 구성.

## 서브테스트

`t.Run("케이스명", func(t *testing.T) {...})` 패턴. 각 케이스는 독립적으로 실행 가능, 병렬 실행 시 `t.Parallel()` 호출.

## 테이블 기반 테스트

여러 케이스가 유사한 구조면 테이블 기반 테스트 권장. `[]struct{ name, input, want, wantErr }`로 케이스 정의.

**예시:**

```go
tests := []struct {
    name    string
    input   int
    want    int
    wantErr bool
}{
    {"정상 케이스", 5, 10, false},
    {"음수 입력", -1, 0, true},
}
for _, tt := range tests {
    t.Run(tt.name, func(t *testing.T) {
        got, err := Func(tt.input)
        if (err != nil) != tt.wantErr { ... }
        if got != tt.want { ... }
    })
}
```

## 모킹

인터페이스 기반 의존성 주입 활용. 수동 모킹 우선, 복잡한 경우 gomock 고려. 테스트 전용 구현체는 `_test.go` 내 정의.

## 에러 검증

`errors.Is()`, `errors.As()` 사용. 에러 메시지 문자열 비교는 피하고, sentinel 에러나 에러 타입으로 검증.

## Setup/Teardown

`TestMain(m *testing.M)`으로 전역 setup/teardown. 개별 테스트 준비는 각 Test 함수 내 또는 헬퍼 함수로 추출.

## 테스트 헬퍼

반복되는 준비/검증은 `testXxx(t *testing.T, ...)` 헬퍼로 추출. 첫 인자로 `*testing.T` 받아 `t.Helper()` 호출.

## 벤치마크

성능 중요 코드는 `func BenchmarkXxx(b *testing.B)` 작성. `b.N` 루프로 반복, `b.ResetTimer()`로 준비 시간 제외.
