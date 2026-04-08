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
