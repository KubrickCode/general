---
name: nestjs
description: |
  NestJS 프레임워크 개발을 위한 모범 사례와 코딩 규칙. 도메인 중심 아키텍처, 의존성 주입, 데코레이터 패턴 활용.
  TRIGGER: NestJS 프로젝트, @Module/@Controller/@Injectable 데코레이터, REST/GraphQL API 개발, 의존성 주입 패턴
---

# NestJS Development Standards

## 모듈 구성 원칙

### 도메인 중심 모듈화

기능별이 아닌 비즈니스 도메인별로 모듈을 구성함.

- ❌ Bad: `controllers/`, `services/`, `repositories/`
- ✅ Good: `users/`, `products/`, `orders/`

### 단일 책임 모듈

하나의 모듈은 하나의 도메인만 담당함.

- 공통 기능은 `common/` 또는 `shared/` 등 공용 모듈로 분리
- 도메인 간 통신은 반드시 Service를 통해서만

## 의존성 주입 규칙

### 생성자 주입만 사용

속성 주입(@Inject)은 금지.

```typescript
// ✅ Good
constructor(private readonly userService: UserService) {}

// ❌ Bad
@Inject() userService: UserService;
```

### Provider 등록 위치

Provider는 사용되는 모듈에서만 등록함.

- Global provider는 최소화
- forRoot/forRootAsync는 AppModule에서만 사용

## 데코레이터 사용 규칙

### 커스텀 데코레이터 우선

반복되는 데코레이터 조합은 커스텀 데코레이터로 추상화함.

```typescript
// 3개 이상 데코레이터 조합 시 커스텀 데코레이터 생성
@Auth() // @UseGuards + @ApiBearerAuth + @CurrentUser 통합
```

### 데코레이터 순서

위에서 아래로 실행 순서대로 배치함.

1. 메타데이터 데코레이터 (@ApiTags, @Controller, @Resolver)
2. 가드/인터셉터 (@UseGuards, @UseInterceptors)
3. 라우트 데코레이터 (@Get, @Post, @Query, @Mutation)
4. 파라미터 데코레이터 (@Body, @Param, @Args)

## DTO/Entity 규칙

### DTO는 순수 데이터 전송만

비즈니스 로직 금지, validation만 허용함.

```typescript
// ✅ Good: Validation만
class CreateUserDto {
  @IsEmail()
  email: string;
}

// ❌ Bad: 비즈니스 로직 포함
class CreateUserDto {
  toEntity(): User {} // 금지
}
```

### Entity와 DTO 분리

Entity를 직접 반환하지 않고 항상 DTO로 변환함.

- Request: CreateInput, UpdateInput (GraphQL) / CreateDto, UpdateDto (REST)
- Response: Type 정의 또는 plain object

## 에러 처리

### 도메인별 Exception Filter

각 도메인은 자체 Exception Filter를 가짐.

```typescript
@Module({
  providers: [
    {
      provide: APP_FILTER,
      useClass: UserExceptionFilter,
    },
  ],
})
```

### 명시적 에러 throw

모든 에러 상황에서 명시적으로 Exception을 throw함.

- REST: HttpException 계열 사용
- GraphQL: GraphQLError 또는 커스텀 에러 사용
- 암묵적 null/undefined 반환 금지
- 에러 메시지는 사용자가 이해할 수 있는 수준으로
