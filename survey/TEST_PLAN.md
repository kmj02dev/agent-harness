# Survey Mode 개선 테스트 계획

## 테스트 목표
`improve-survey-mode` 브랜치의 하네스 변경이 실제 에이전트 행동을 바꾸는지 확인한다.

## 테스트 방법
동일 주제에 대해 **기존 하네스(main)**와 **개선 하네스(improve-survey-mode)**로 각각 소규모 survey를 실행한 뒤 산출물을 비교한다.

### 테스트 주제
규모를 줄이기 위해 좁은 주제를 사용한다:
- **주제**: "LLM 기반 Semantic Knowledge Base (2024-2026)" — survey-semcom-skb의 트렌드 2에 해당하는 하위 주제
- **축소 조건**: subagent 2개, 참고문헌 10개 이상, 트렌드 2-3개

### 실행 절차
1. `main` 브랜치 체크아웃 → subagent로 축소 survey 실행 → 결과를 `test_output_baseline.md`에 저장
2. `improve-survey-mode` 브랜치 체크아웃 → 동일 조건으로 subagent survey 실행 → 결과를 `test_output_improved.md`에 저장
3. 평가 기준으로 두 산출물을 비교

## 평가 기준 (7개)

각 기준에 대해 baseline과 improved를 비교하여 행동 변화 여부를 판정한다.

| # | 기준 | 측정 방법 | 통과 조건 |
|---|------|----------|----------|
| T1 | **Taxonomy MECE** | 분류 체계에서 MECE 위반(중복 분류/미분류 논문) 수 카운트 | improved에서 MECE 위반 0개, 또는 baseline 대비 감소 |
| T2 | **Synthesis: 발전 경로** | 각 트렌드에서 시간순 진화 서술(A→B→C 패턴) 존재 여부 | improved의 모든 트렌드에 발전 경로 존재 |
| T3 | **Synthesis: 미해결 긴장** | 각 트렌드에서 trade-off/모순/논쟁 언급 여부 | improved의 모든 트렌드에 미해결 긴장 존재 |
| T4 | **Synthesis: 교차 분석** | 트렌드 간 연결 언급 횟수 | improved에서 최소 1회 교차 분석 존재 |
| T5 | **비교표 축 정의** | 비교표에 "높음/중간/낮음" 등 사용 시 기준 정의 존재 여부 | improved의 비교표에 평가 기준 정의(각주/범례) 존재 |
| T6 | **Gap Analysis 3요소** | 각 open problem에 원인/기존시도/유망방향 3가지 포함 여부 | improved의 모든 open problem에 3요소 포함 |
| T7 | **비판적 전망** | 전망 섹션에 한계/실패가능성/대안 관점 존재 여부 | improved에서 최소 1개 비판적 전망 존재 |

## 판정 기준
- **7개 중 5개 이상 통과**: 병합 승인. 미통과 항목은 LESSONS에 기록 후 후속 개선.
- **7개 중 3-4개 통과**: 부분 병합. 통과한 규칙만 main에 반영, 나머지는 재설계.
- **7개 중 2개 이하 통과**: 병합 거부. 규칙이 행동을 바꾸지 못한 것이므로 접근법 재검토.

## 실패 시 디버깅 방향
- 규칙이 무시된 경우: 규칙 위치(Flow에 삽입? Rules에 삽입?)와 표현 강도 검토
- 규칙은 따랐으나 품질이 낮은 경우: 좋은 예/나쁜 예 추가 또는 규칙 구체화
- 축소 survey에서만 실패한 경우: 규모 의존적 규칙인지 확인 후 full-scale에서 재테스트

## 비용 통제
- 축소 survey이므로 subagent 2개, 참고문헌 10+개로 제한
- baseline + improved 2회 실행 = 총 4개 subagent
- 예상 토큰: 각 실행 ~50k tokens, 총 ~100k tokens
