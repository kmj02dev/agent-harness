# Domain Mode

특정 도메인에 특화된 지식. 활동 모드(development, research, teaching 등)와 조합하여 사용한다.

## 구조

도메인 지식은 `domains/[name]/` 디렉토리에 계층적으로 분리한다:

```
domains/
├── ml/
│   ├── base.md          # 범작업적: 핵심 개념, 용어, 주요 논문/저자, 흔한 오해
│   ├── development.md   # 작업 종속적: Stack, Rules, Pitfalls, Checklist
│   └── teaching.md      # 작업 종속적: 좋은 비유, 선수 지식, 자주 헷갈리는 점
├── web/
│   ├── base.md
│   └── development.md
└── (새 도메인은 base.md만으로 시작)
```

## base.md 작성 규칙

모든 도메인의 base.md는 다음 구조를 따른다:

```markdown
# [도메인명]

## Core Concepts
이 도메인의 핵심 개념과 용어 정의

## Key References
주요 논문, 저자, 학회, 표준 문서

## Common Misconceptions
자주 혼동되는 개념 쌍, 흔한 오해

## Domain Map
하위 분야 구조와 관계
```

## 작업 종속 파일 작성 규칙

`[mode].md` 파일은 해당 모드에서 이 도메인을 다룰 때 필요한 규칙:

```markdown
## Stack / Rules / Pitfalls / Quality Checklist
```

## 동작 방식

1. 도메인 판별 후 `domains/[name]/base.md`를 먼저 읽는다 (범작업적 지식)
2. 현재 모드에 해당하는 `domains/[name]/[mode].md`가 있으면 추가 로드
3. 없으면 base.md만으로 작업. 작업 완료 후 유용한 모드별 지식이 축적되면 파일 생성
4. 도메인 자체가 없으면 base.md부터 생성 (subagent로 핵심 개념 조사)

## 도메인 파일이 없는 경우

새 도메인을 만나면:
1. 해당 도메인의 핵심 개념을 subagent로 조사
2. `domains/[name]/base.md`로 정리
3. 작업 수행 중 모드별 지식이 축적되면 `[mode].md` 추가
4. LESSONS.md에 "새 도메인 파일 생성" 기록
