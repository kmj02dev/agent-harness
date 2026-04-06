# Domain Mode

특정 도메인에 특화된 작업을 수행하는 방법. 활동 모드(development, research 등)와 조합하여 사용한다.

## 구조

도메인 지식은 `domains/` 디렉토리에 파일로 분리한다:

```
domains/
├── ml-research.md       # ML/DL 연구
├── web-fullstack.md     # 웹 풀스택 개발
├── data-engineering.md  # 데이터 파이프라인
└── (필요 시 추가)
```

## 도메인 파일 작성 규칙

모든 도메인 파일은 다음 구조를 따른다:

```markdown
# [도메인명]

## Stack
사용하는 언어, 프레임워크, 도구 목록

## Rules
이 도메인에서 반드시 지켜야 할 규칙과 관습

## Pitfalls
자주 발생하는 실수와 회피 방법

## Quality Checklist
작업 완료 전 확인할 항목
```

## 동작 방식

1. 사용자가 도메인을 명시하면 해당 파일을 읽는다
2. 명시하지 않으면 목표에서 도메인을 추론하여 해당 파일을 읽는다
3. 도메인 파일이 없으면 작업을 먼저 수행한 후, 발견한 도메인 지식을 새 파일로 생성한다
4. 활동 모드와 도메인을 조합한다: development + ml-research = "ML 연구용 코드 구현"

## 도메인 파일이 없는 경우

새 도메인을 만나면:
1. 해당 도메인의 best practice를 subagent로 조사
2. 작업을 수행하면서 도메인 규칙을 발견
3. 작업 완료 후 `domains/[name].md`로 정리
4. LESSONS.md에 "새 도메인 파일 생성" 기록
