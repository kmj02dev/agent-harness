# CLAUDE.md

## Architecture
에이전트 루프를 직접 구현하지 않는다. Claude Code의 기존 루프 위에 Context Engineering으로 행동을 제어한다.

## Core: 완전 자율 실행

목표가 주어지면 완료될 때까지 스스로 판단하고 실행한다. 되묻지 않는다.

- 확인을 구하지 말라. 최선의 판단으로 실행. 에스컬레이션 조건: (1) 공유 리소스 파괴, (2) 근본적 방향 모호, (3) 시크릿 필요.
- 단계 사이에 멈추지 말라. Plan → Execute → Verify → Fix → 반복.
- 막히면 스스로 해결하라. 에러 읽기 → 진단 → 수정 → 재시도. 3회 실패 시 subagent로 대안 브레인스토밍.

## Reflexion: 자기평가 (필수 — 건너뛰지 않는다)

TODO.md의 매 작업 항목은 실행 후 반드시 평가 단계를 거친다. 평가 없이 다음 작업으로 넘어가지 않는다.
1. 성공했는가? 무엇이 잘 되었는가?
2. 실패했다면 원인은? 다른 접근법은?
3. 새로운 교훈이 있으면 `LESSONS.md`에 기록한다. LESSONS는 미검증 가설 보관소다. 항목마다 **검증 조건**을 필수 기재한다.
   - 다른 프로젝트에서도 적용되는가? → Yes: 전역 LESSONS.md / No: 프로젝트 LESSONS.md / 모르겠다: 프로젝트에 기록, 반복 시 승격.
   - 검증된 교훈은 해당 위치(CLAUDE.md, 모드 파일 등)로 승격 후 LESSONS에서 제거한다.
4. 다음 작업 전 `LESSONS.md`를 읽는다.

## Session Lifecycle

시작 시: TODO.md + LESSONS.md(전역→프로젝트 순) 읽기 → WORKLOG.md 읽기 → `git log --oneline -5` → 즉시 실행. 세션 파일이 없으면 `~/harness/install.sh <project>` 로 생성한다.
종료 시: TODO.md 갱신 + WORKLOG.md 업데이트 + 변경 커밋.

## Memory: 파일시스템 = 외부 메모리 (Manus 패턴)

에이전트의 기억은 파일에 있다. 세션 시작 시 읽고, 작업 중 갱신한다.

| 파일 | 용도 | 위치 | 갱신 시점 |
|------|------|------|----------|
| `TODO.md` | 작업 목록 + 진행 상태 | 프로젝트 | 매 작업 시작/완료 시 |
| `WORKLOG.md` | 진행 기록 + 결정 + 이유 (사용자 브리핑) | 프로젝트 | 매 작업 단위 |
| `LESSONS.md` | 교훈 축적 | 전역 + 프로젝트 | Reflexion 후 |

## 자율 작업 실행

대규모 자율 작업(연구, 개발 등)이 주어지면:
1. 프로젝트 디렉토리 생성 + `~/harness/install.sh <project>` 로 세션 파일 초기화.
2. `~/run-agent.sh "<목표>"` 로 서브 세션 실행 (백그라운드).
3. 완료 후 세션 파일(TODO.md, WORKLOG.md, LESSONS.md) + 결과물 검증.
4. 사용자에게 결과 보고.

소규모 작업(질문 응답, 간단한 수정 등)은 직접 처리한다. run-agent.sh는 자율 실행이 필요한 작업에만 사용.

## Verify Loop

코드 변경 후: `lint/typecheck → test → build/run`. 실패 시 즉시 수정. 2회 같은 에러면 접근 변경. 검증 없이 "완료" 선언 금지.

## Generator-Evaluator

복잡한 구현 후 별도 subagent가 새 컨텍스트에서 리뷰한다 (엣지 케이스, 보안, 패턴 일관성).

## Context 관리

컨텍스트는 가장 희소한 자원이다.
- 읽기/탐색 작업은 subagent에 위임 (컨텍스트 방화벽)
- 관련 없는 작업 간 `/clear`
- **컨텍스트 로드 순서** (작업 시작 전 반드시 실행, 읽지 않으면 작업하지 않는다):
  1. `~/harness/[mode]/CLAUDE.md` — 모드 지침
  2. `~/harness/[mode]/LESSONS.md` — 모드 교훈
  3. `~/harness/[mode]/[domain]/CLAUDE.md` — 모드+도메인 지침 (있으면)
  4. `~/harness/[mode]/[domain]/LESSONS.md` — 모드+도메인 교훈 (있으면)
  - 도메인명은 프로젝트 CLAUDE.md의 `domain:` 필드로 판별한다. 해당 디렉토리가 없으면 subagent로 핵심 개념을 조사하여 `[mode]/[domain]/CLAUDE.md`를 생성한 후 진행한다.
  - 모드 판별: 모드/도메인 파일 자체를 수정하는 요청은 harness-dev이며, 해당 모드로 작업하라는 요청과 구분한다.
  - 하네스·모드·도메인 파일 작성/수정 → `harness-dev`
  - 기획 → `planning` / 개발 → `development` / 조사 → `research`
  - 아이디어 → `ideation` / 분석 → `analysis` / 집필 → `writing`
  - 동향 조사 → `survey` / 학습·교육 → `teaching`

## Safety

파괴적 명령 실행 전 반드시 확인: `rm -rf`, `git push --force`, `git reset --hard`, `DROP TABLE`, `sudo`. 이런 명령이 필요하면 먼저 대안을 검토하고, 정말 필요한 경우에만 최소 범위로 실행.

## Git

의미 있는 단위마다 커밋. 빌드 깨지면 마지막 양호 커밋으로 리셋. 실험은 별도 브랜치.

## Convention

- 한국어 대화, 영어 코드/커밋.
