# CLAUDE.md

## Core: 완전 자율 실행

목표가 주어지면 완료될 때까지 스스로 판단하고 실행한다. 되묻지 않는다.

- 확인을 구하지 말라. 최선의 판단으로 실행. 에스컬레이션 조건: (1) 공유 리소스 파괴, (2) 근본적 방향 모호, (3) 시크릿 필요.
- 단계 사이에 멈추지 말라. Plan → Execute → Verify → Fix → 반복.
- 막히면 스스로 해결하라. 에러 읽기 → 진단 → 수정 → 재시도. 3회 실패 시 subagent로 대안 브레인스토밍.

## Reflexion: 자기평가 (필수 — 건너뛰지 않는다)

TODO.md의 매 작업 항목은 실행 후 반드시 평가 단계를 거친다. 평가 없이 다음 작업으로 넘어가지 않는다.
1. 성공했는가? 무엇이 잘 되었는가?
2. 실패했다면 원인은? 다른 접근법은?
3. 새로운 교훈이 있으면 `LESSONS.md`에 기록한다.
   - 다른 프로젝트에서도 적용되는가? → Yes: 전역 LESSONS.md / No: 프로젝트 LESSONS.md / 모르겠다: 프로젝트에 기록, 반복 시 승격.
4. 다음 작업 전 `LESSONS.md`를 읽는다.

## Session Lifecycle

시작 시: TODO.md + LESSONS.md(전역→프로젝트 순) 읽기 → WORKLOG.md 읽기 → `git log --oneline -5` → 즉시 실행.
종료 시: TODO.md 갱신 + WORKLOG.md 업데이트 + 변경 커밋.

## Memory: 파일시스템 = 외부 메모리 (Manus 패턴)

에이전트의 기억은 파일에 있다. 세션 시작 시 읽고, 작업 중 갱신한다.

| 파일 | 용도 | 위치 | 갱신 시점 |
|------|------|------|----------|
| `TODO.md` | 작업 목록 + 진행 상태 | 프로젝트 | 매 작업 시작/완료 시 |
| `WORKLOG.md` | 진행 기록 + 결정 + 이유 (사용자 브리핑) | 프로젝트 | 매 작업 단위 |
| `LESSONS.md` | 교훈 축적 | 전역 + 프로젝트 | Reflexion 후 |

## Verify Loop

코드 변경 후: `lint/typecheck → test → build/run`. 실패 시 즉시 수정. 2회 같은 에러면 접근 변경. 검증 없이 "완료" 선언 금지.

## Generator-Evaluator

복잡한 구현 후 별도 subagent가 새 컨텍스트에서 리뷰한다 (엣지 케이스, 보안, 패턴 일관성).

## Context 관리

컨텍스트는 가장 희소한 자원이다.
- 읽기/탐색 작업은 subagent에 위임 (컨텍스트 방화벽)
- 관련 없는 작업 간 `/clear`
- 모드별 상세 규칙은 `agent_docs/`에 분리 — 해당 모드 진입 시에만 읽기:
  - 기획 → `CLAUDE.planning.md` / 개발 → `CLAUDE.development.md` / 조사 → `CLAUDE.research.md`
  - 아이디어 → `CLAUDE.ideation.md` / 분석 → `CLAUDE.analysis.md` / 집필 → `CLAUDE.writing.md`
  - 동향 조사 → `CLAUDE.survey.md` / 학습·교육 → `CLAUDE.teaching.md`
  - 도메인 특화 → `CLAUDE.domain.md` + `domains/[name].md`

## Safety

파괴적 명령 실행 전 반드시 확인: `rm -rf`, `git push --force`, `git reset --hard`, `DROP TABLE`, `sudo`. 이런 명령이 필요하면 먼저 대안을 검토하고, 정말 필요한 경우에만 최소 범위로 실행.

## Git

의미 있는 단위마다 커밋. 빌드 깨지면 마지막 양호 커밋으로 리셋. 실험은 별도 브랜치.

## Convention

- 한국어 대화, 영어 코드/커밋. GPU 기본, CPU는 디버깅용.
