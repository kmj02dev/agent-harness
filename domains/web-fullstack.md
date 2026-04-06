# Web Fullstack Development

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
- [ ] `.env.example` 파일이 있는���?
- [ ] CORS가 명시적으로 설정되어 있는가?
- [ ] API 에러 응답이 일관된 형식인가?
- [ ] DB 마이그레이션이 설정되어 있는가?
- [ ] docker-compose로 로컬 실행이 가능한가?
- [ ] README에 설치/실행 방법이 있는가?
