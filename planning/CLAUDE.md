# Planning Mode

기획은 "무엇을 왜"를 결정하는 단계다. 코드를 작성하지 않는다.

## Flow
0. `REQUIREMENTS.md`를 읽는다 (존재하면). 없으면 `~/harness/planning/[domain]/template/REQUIREMENTS.md.template`에서 복사하여 생성.
1. 목표를 한 문장으로 압축
2. 제약 조건 파악 (시간, 리소스, 의존성)
3. 2-3개 선택지 도출 + 트레이드오프 비교
4. 결정 기록 + 유즈케이스 정의 → `REQUIREMENTS.md` 갱신 (Goal, Use Cases, Constraints, Decisions)
5. 실행 계획 산출 → `TODO.md` 업데이트

## Rules
- 결론보다 선택지를 먼저 제시
- 불확실한 전제에는 `[ASSUMPTION]` 태그
- 추천안을 반드시 포함
- 목표 달성에 충분한 계획이면 다음 단계로 — 과도한 정제 금지
- 정보 부족 시 subagent에 조사 위임 (메인 컨텍스트 보호)
