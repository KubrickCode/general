---
description: 장황한 자연어 요청을 구조화된 이중언어 문서로 변환 (한글 검토용 + 영어 AI 프롬프트용)
---

# 요청 청사진 문서 생성

**모든 종류의** 장황하고 구조화되지 않은 자연어 요청을 명확하고 체계적인 마크다운 문서로 변환한다: $ARGUMENTS

## 이 커맨드의 목적

**중요**: 이 커맨드는 모든 종류의 요청에 사용 가능합니다 - 기술적, 비기술적, 의사결정, 계획, 진로 상담, 개인 질문, 브레인스토밍 등. "기술적이지 않다"는 이유로 거절하지 마세요.

사용자의 비정형적인 자연어 요청을 분석하여:

1. **한글 버전**: 사용자가 검토하고 확인할 수 있는 구조화된 문서
2. **영어 버전**: 다른 AI 에이전트에게 전달할 최적화된 프롬프트 문서

이를 통해:

- AI 할루시네이션 감소
- 컨텍스트 비용 절감
- 요청 의도의 명확한 전달
- 작업 범위와 제약사항의 구체화

## 지원하는 요청 유형

- ✅ 소프트웨어 개발 및 코딩 작업
- ✅ 진로 결정 및 이직 고민
- ✅ 개인 조언 및 인생 상담
- ✅ 비즈니스 전략 및 기획
- ✅ 리서치 및 분석 질문
- ✅ 의사결정 딜레마
- ✅ 창작 및 디자인 프로젝트
- ✅ 재무 계획 논의
- ✅ 구조화된 사고가 필요한 모든 주제

## 출력 원칙

**CRITICAL**: 상황에 맞게 유연하게 구조화하라. 불필요한 섹션을 강제로 채우지 말 것.

### 기본 원칙

1. **간단한 요청 → 간단한 문서**: 3-4개 섹션이면 충분
2. **복잡한 요청 → 상세한 문서**: 필요한 만큼만 섹션 추가
3. **기술 요청 아니면**: 기술 환경, 의존성 등 섹션 불필요
4. **핵심은 명확화**: 장황함을 줄이고 핵심만 구조화

### 문서 구조

**루트 경로**에 마크다운 파일 생성:

```markdown
# [요청 제목]

---

## 📋 한글 버전 (검토용)

> 사용자가 요청 내용을 검토하고 확인하기 위한 버전

[상황에 맞게 필요한 섹션만 포함]

### 예시 가능한 섹션들 (선택적)

- 🎯 요청 개요
- 📖 목적 및 배경
- ✅ 구체적 요구사항
- 🚫 제약사항 및 주의사항
- 🎨 기대 결과
- 🛠️ 기술 환경 (기술 관련일 때만)
- 📊 우선순위 (필요시)
- 📚 참고 자료 (있으면)
- 💬 추가 컨텍스트 (필요시)

---

## 📋 English Version (For AI Prompt)

> **CRITICAL: All responses, conversations, and outputs MUST be in Korean (한글).**
>
> This section is optimized for AI agent consumption. The AI agent must communicate entirely in Korean regardless of the prompt language.

[한글 버전과 동일한 구조, 영어로 작성]
[같은 섹션만 포함, 불필요한 섹션 추가하지 말 것]

---

## 🔄 Next Steps

1. Review the Korean version
2. Modify if needed
3. Share the English version with the next AI agent
```

### 실제 예시

**간단한 비기술 요청 (진로 고민)**

```markdown
# 이직 준비 방식 결정: 퇴사 후 vs 재직 중

---

## 📋 한글 버전

### 🎯 요청 개요

퇴사 후 이직 준비를 할지, 재직하면서 이직 준비를 할지 결정

### 📖 현재 상황

- 고지능자로 경력 단절 기간에 대해 설명할 자신 있음
- "현실은 빡빡해서"라고 표현 (구체적인 제약 사항은 명확화 필요)
- 두 가지 선택지 사이에서 고민 중

### ✅ 핵심 고려사항

1. 어떤 요소들이 이 결정에 영향을 줄까?
2. 각 접근법의 장단점은?
3. 선택한 경로에 필요한 실행 단계는?

### 🎨 기대 결과

각 옵션에 대한 논리적 근거가 포함된 명확한 의사결정 프레임워크

---

## 📋 English Version

> **CRITICAL: All responses must be in Korean.**

### 🎯 Request Overview

Decide whether to resign before job hunting or stay employed during the transition

### 📖 Current Situation

- High-capability individual confident in explaining employment gaps during career breaks
- User describes "reality is tight/constrained" (specific constraints not clarified)
- Facing choice between two paths

### ✅ Key Considerations

1. What factors should guide this decision?
2. What are pros/cons of each approach?
3. What action steps are needed for chosen path?

### 🎨 Expected Outcome

Clear decision-making framework with reasoning for each option
```

**간단한 요청 (회의록 템플릿)**

```markdown
# 회의록 작성 양식 만들기

---

## 📋 한글 버전

### 🎯 요청 개요

팀 회의에 사용할 간단한 회의록 템플릿 작성

### ✅ 구체적 요구사항

1. 날짜, 참석자, 안건 섹션 포함
2. 액션 아이템 체크리스트 형태
3. 다음 회의 날짜 기록란

### 🎨 기대 결과

마크다운 형식의 재사용 가능한 템플릿 파일

---

## 📋 English Version

> **CRITICAL: All responses must be in Korean.**

[한글 버전과 동일한 구조]
```

**복잡한 기술 요청**

```markdown
# 사용자 인증 시스템 리팩토링

---

## 📋 한글 버전

### 🎯 요청 개요

JWT 기반 인증을 OAuth2로 마이그레이션하면서 기존 사용자 세션 유지

### 📖 목적 및 배경

- 현재 JWT 만료 시간 관리 복잡함
- 소셜 로그인 지원 필요
- 보안 강화 필요

### ✅ 구체적 요구사항

1. OAuth2 Provider 연동 (Google, GitHub)
2. 기존 JWT 사용자 자동 마이그레이션
3. Refresh token 로직 구현

### 🚫 제약사항

- 기존 사용자 세션 끊기면 안 됨
- 데이터베이스 스키마 대폭 변경 불가
- API 엔드포인트 URL 유지

### 🛠️ 기술 환경

- NestJS, Passport.js
- PostgreSQL
- Redis (세션 저장)
- `/src/auth/` 디렉토리

### 📊 우선순위

- High: OAuth2 기본 연동
- Medium: 자동 마이그레이션
- Low: 기존 코드 정리

---

## 📋 English Version

> **CRITICAL: All responses must be in Korean.**

[same structure as Korean version]
```

## 파일 명명 규칙

생성되는 파일명: `blueprint-[간략한-제목]-[타임스탬프].md`

예시:

- `blueprint-user-auth-implementation-20250110-143022.md`
- `blueprint-api-refactoring-20250110-150530.md`

## 사용 예시

**기본 사용:**

```
/blueprint
```

**특정 초점으로 사용:**

```
/blueprint 인증 시스템에 집중
```

**복잡한 요청 정리:**

```
/blueprint 이전 대화 내용 전체를 기반으로
```

## 워크플로우

1. **사용자 → Agent A**: 장황하게 자연어로 요청 설명
2. **Agent A**: `/blueprint` 실행하여 구조화된 문서 생성 (루트 경로)
3. **사용자**: 한글 버전 검토 및 수정
4. **사용자 → Agent B**: 영어 버전 프롬프트 전달
5. **Agent B**: 구조화된 지시사항을 바탕으로 작업 수행 (한글로 대화)

## 주요 특징

### 이중 언어 구조

- **한글 섹션**: 직관적 검토, 빠른 이해, 한국어 사용자 친화적
- **영어 섹션**: 프롬프트 엔지니어링 최적화, AI 성능 향상, 명확한 지시

### 언어 정책

영어 버전 상단에 **CRITICAL** 표시와 함께 "모든 대화는 한글로" 명시하여:

- AI 에이전트가 영어 프롬프트를 받더라도 한글로 응답
- 사용자 경험의 일관성 유지
- 의사소통 효율성 보장

### 구조화된 정보

- **목적**: 왜 이 작업이 필요한지
- **요구사항**: 구체적으로 무엇을 해야 하는지
- **제약사항**: 무엇을 피하고 지켜야 하는지
- **성공 기준**: 언제 완료된 것으로 볼 것인지
- **기술 환경**: 어떤 도구와 파일을 사용할 것인지

## 이점

1. **할루시네이션 감소**: 명확한 구조와 구체적 요구사항으로 AI의 추측 최소화
2. **컨텍스트 효율**: 불필요한 장황함 제거, 핵심 정보만 전달
3. **검증 가능성**: 사용자가 요청 내용을 명확히 확인 가능
4. **재사용성**: 유사한 작업에 템플릿으로 활용 가능
5. **협업 향상**: 여러 AI 에이전트 간 작업 전달 시 명확한 의사소통

## 작성 가이드라인

**핵심 원칙: 절대 추측하거나 추론하지 말 것. 사용자가 명시적으로 말한 내용만 기록할 것.**

문서 생성 시:

### ✅ 해야 할 것:

- **사용자의 정확한 표현 그대로 기록** (애매한 표현도 그대로)
- **모호한 용어는 모호하게 유지** - 해석하지 말 것
- **명시적으로 언급된 내용만** 요구사항, 제약사항, 컨텍스트에 포함
- **불명확한 경우 사용자의 원래 표현 보존**
- **명확화 질문 표시** ("명확히 필요: ..."로 표시)하되 추측하지 말 것

### ❌ 하지 말아야 할 것:

- **"암묵적" 요구사항 추출하지 말 것** - 명시적인 것만
- **모호한 표현 해석하지 말 것** (예: "빡빡하다"를 재정, 시간 등 구체적 문제로 해석 금지)
- **사용자가 언급하지 않은 세부사항 추가하지 말 것**
- **약어나 일상 언어를 공식적인 가정으로 확장하지 말 것**
- **사용자가 말한 것 이상으로 상황 추론하지 말 것**

### 예시:

- 사용자 말: "현실은 빡빡해서"
- ❌ 틀림: "재정적 상황이 빡빡함", "재정 압박", "예산 제한"
- ✅ 맞음: "현실/상황이 빡빡하다고 표현 (사용자 원문 그대로 - 구체적 내용은 명확화 필요)"

## 추가 옵션

사용자가 원하는 경우:

- 특정 섹션 강조 또는 생략
- 커스텀 템플릿 구조 적용
- 추가 메타데이터 포함
- 특정 형식의 체크리스트 생성
