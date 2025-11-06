---
name: project-structure
description: |
  프로젝트 폴더 구조 설계 가이드. 모노레포, NestJS, React, Go, NPM 패키지, IDE(VSCode 등)/Chrome Extension 등 다양한 프로젝트 타입별 표준 디렉토리 구조를 정의.
  TRIGGER: 프로젝트 구조 설계, 폴더 구조 질문, 디렉토리 구성, 프로젝트 생성, 모노레포 구조, NestJS/React/Go 프로젝트 구조
---

# Project Structure Guide

## 모노레포

```
project-root/
├── src/                         # 모든 서비스/앱
├── infra/                       # 통합 인프라
├── docs/                        # 문서
├── .devcontainer/               # Dev Container 설정
├── .github/                     # 워크플로우, 템플릿
├── .vscode/                     # VSCode 설정
├── .claude/                     # Claude 설정
├── .gemini/                     # Gemini 설정
├── package.json                 # 루트 package.json. 릴리즈, 버전 관리용
├── go.work                      # Go 워크스페이스 (go 사용 시)
├── justfile                     # Just 태스크 러너
├── .gitignore
├── .prettierrc
├── .prettierignore
└── README.md
```

## NestJS

```
project-root/
├── src/
│   ├── domains/
│   ├── common/
│   ├── config/
│   ├── database/
│   ├── app.module.ts
│   └── main.ts
├── tests/
├── package.json
└── tsconfig.json
```

## React

```
project-root/
├── src/
│   ├── pages/              # 페이지별 모듈
│   ├── domains/            # 도메인 공용 코드
│   ├── components/         # 공용 UI 컴포넌트
│   ├── layouts/            # 레이아웃 관련
│   ├── libs/               # 기능 라이브러리 (auth, api, theme)
│   ├── shared/             # 순수 유틸리티
│   ├── app.tsx
│   └── main.tsx
├── public/
├── package.json
├── vite.config.ts
└── tsconfig.json
```

## Go

```
project-root/
├── cmd/                    # 실행 진입점 (main.go)
├── internal/               # 비공개 패키지
├── pkg/                    # 공개 패키지
├── configs/                # 설정 파일
├── scripts/                # 유틸리티 스크립트
├── tests/                  # 통합 테스트
├── docs/                   # 문서
├── go.mod
└── go.sum
```

## NPM

```
project-root/
├── cli/                        # CLI 실행 진입점
├── internal/                   # 비공개 패키지
├── pkg/                        # 공개 패키지
├── configs/                    # 설정 파일
├── scripts/                    # 유틸리티 스크립트
├── tests/                      # 통합 테스트
├── docs/                       # 문서
├── dist/                       # 빌드 결과물
├── package.json
├── tsconfig.json
└── README.md
```

## IDE Extension

```
project-root/
├── extension/                   # Extension 진입점 (activate/deactivate)
├── internal/                    # 비공개 패키지
├── pkg/                         # 공개 패키지
├── view/                        # WebView (있을 경우)
├── configs/                     # 설정 파일
├── scripts/                     # 유틸리티 스크립트
├── tests/                       # 통합 테스트
├── public/                      # 정적 리소스 (아이콘 등)
├── dist/                        # 빌드 결과물
├── package.json
├── tsconfig.json
└── .vscodeignore
```

## Chrome Extension

```
project-root/
├── background/                  # Service Worker (Background Script)
├── content/                     # Content Scripts
├── popup/                       # Popup (Extension UI)
├── internal/                    # 비공개 패키지
├── pkg/                         # 공개 패키지
├── configs/                     # 설정 파일
├── scripts/                     # 유틸리티 스크립트
├── tests/                       # 통합 테스트
├── public/                      # 정적 리소스
├── dist/                        # 빌드 결과물
├── package.json
└── tsconfig.json
```
