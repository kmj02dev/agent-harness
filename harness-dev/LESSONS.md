# harness-dev — LESSONS

- 하네스에 "무엇을(what) 포함하라"만 적으면 나열식 결과가 나온다. "어떻게(how) 작성하라" (좋은 예/나쁜 예 포함)를 명시해야 품질이 올라간다.
  **검증**: survey 외 다른 모드(writing 등)에서도 동일 패턴 관찰 시 전역 LESSONS로 승격.
- 실제 산출물을 외부 기준(학술 방법론 등)으로 평가하면, 단순 내부 리뷰보다 구조적 결함을 잘 발견한다. Generator-Evaluator 패턴의 Evaluator에 외부 기준을 주입하는 것이 효과적.
  **검증**: 다른 모드에서도 외부 기준 기반 평가 적용 후 효과 비교.
- **[검증됨]** 하네스 효과는 모델 역량에 반비례한다. Opus(5/7→7/7), Sonnet(0.5/7→7/7), Haiku(0/7→7/7). 하네스 A/B 테스트는 반드시 Sonnet 이하 모델에서 실행해야 행동 변화를 측정할 수 있다.
  → harness-dev/CLAUDE.md 테스트 가이드라인으로 승격 대상.
- **[검증됨]** 좋은 하네스는 모델 간 품질 격차를 줄이는 equalizer다. Baseline에서 Opus>>Sonnet≈Haiku였으나, Improved에서 Opus=Sonnet=Haiku(모두 7/7). 약한 모델을 타겟으로 하네스를 설계하면 강한 모델에서도 해가 되지 않는다.
  → harness-dev/CLAUDE.md 설계 원칙으로 승격 대상.
