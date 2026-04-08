# Web Development

## Core Concepts
- HTTP/HTTPS: 요청-응답 프로토콜, 상태 코드, 메서드(GET/POST/PUT/DELETE)
- REST vs GraphQL: API 설계 패러다임의 트레이드오프
- 클라이언트-서버 아키텍처: 프론트엔드(브라우저) ↔ 백엔드(서버) ↔ 데이터베이스
- 인증/인가: 세션, JWT, OAuth 2.0의 차이와 적용 시나리오
- 상태 관리: 서버 상태(DB) vs 클라이언트 상태(메모리/스토리지)
- 비동기 처리: Promise, async/await, 이벤트 루프
- SSR vs CSR vs SSG: 렌더링 전략과 트레이드오프

## Key References
- 표준: MDN Web Docs, W3C, WHATWG
- 프레임워크 문서: React, Next.js, FastAPI, Django, Express
- 아키텍처 패턴: 12-Factor App, Microservices, Serverless
- 보안: OWASP Top 10

## Common Misconceptions
- "REST는 표준" — REST는 아키텍처 스타일이지 프로토콜이 아님
- "SPA가 항상 빠르다" — 초기 로드 비용, SEO 문제 존재
- "JWT는 세션보다 안전" — 각각 다른 위협 모델에 적합
- "NoSQL이 SQL보다 확장성이 좋다" — 워크로드에 따라 다름

## Domain Map
```
Web
├── 프론트엔드: HTML/CSS/JS, React/Vue/Svelte, 상태관리, 빌드도구
├── 백엔드: API 서버, ORM, 인증, 캐싱, 큐
├── 데이터: RDBMS, NoSQL, 검색엔진, 캐시
├── 인프라: Docker, K8s, CI/CD, CDN, DNS
├── 보안: XSS, CSRF, SQLi, CORS, CSP
└── 성능: 번들 최적화, 레이지 로딩, 캐싱 전략
```

## Stack
- Backend: FastAPI / Django (Python) 또는 Express (Node.js)
- Frontend: React + TypeScript
- DB: PostgreSQL (기본), Redis (캐시)
- 배포: Docker + docker-compose

## Rules
- API는 REST 또는 GraphQL — 혼합하지 않는다
- 환경변수로 설정 관리 — `.env` 파일 사용, 시크릿은 코드에 절대 포함 금지
- CORS 설정을 명시적으로 한다 — `*`은 개발에서만
- DB 마이그레이션 도구 사용 (Alembic, Prisma 등) — 수동 SQL 금지
- API 응답은 일관된 형식: `{ data, error, meta }`

## Pitfalls
- N+1 쿼리: ORM 사용 시 `select_related`/`joinedload` 확인
- CORS 에러: 프론트엔드 도메인을 백엔드 allowed origins에 추가했는지 확인
- 비동기 함수에서 동기 DB 호출: SQLAlchemy는 async 세션 사용
- React 무한 렌더링: useEffect 의존성 배열 확인

## Quality Checklist
- [ ] `.env.example` 파일이 있는가?
- [ ] CORS가 명시적으로 설정되어 있는가?
- [ ] API 에러 응답이 일관된 형식인가?
- [ ] DB 마이그레이션이 설정되어 있는가?
- [ ] docker-compose로 로컬 실행이 가능한가?
