# Machine Learning / Deep Learning

## Core Concepts
- 지도학습(supervised), 비지도학습(unsupervised), 강화학습(RL)의 구분
- 손실 함수(loss function): 모델이 최적화하는 목표
- 역전파(backpropagation): 그래디언트 기반 파라미터 업데이트
- 일반화(generalization) vs 과적합(overfitting): 학습 데이터 밖 성능
- 표현 학습(representation learning): 원시 데이터 → 유용한 특징 자동 추출
- Transformer: self-attention 기반 아키텍처, NLP → CV → 멀티모달로 확장
- 생성 모델: VAE, GAN, Diffusion, Autoregressive (각각 원리와 적용 영역이 다름)

## Key References
- 학회: NeurIPS, ICML, ICLR (ML 3대), CVPR/ICCV/ECCV (CV), ACL/EMNLP (NLP)
- 아카이브: arXiv cs.LG, cs.CV, cs.CL
- 영향력 있는 논문: Attention Is All You Need (2017), ResNet (2015), DDPM (2020), GPT 시리즈, BERT
- 주요 연구그룹: Google DeepMind, OpenAI, Meta FAIR, Anthropic

## Common Misconceptions
- "파라미터 많으면 무조건 과적합" — 이중 하강(double descent) 현상으로 반드시 그렇지 않음
- "높은 학습률 = 빠른 수렴" — 발산 위험, 스케줄링이 핵심
- "SOTA = 실용적" — 벤치마크 성능과 실제 배포 성능은 다름
- "사전학습 모델은 범용" — 도메인 시프트에 민감할 수 있음

## Domain Map
```
ML
├── 이론: 통계학습이론, 최적화, 정보이론
├── 아키텍처: CNN, RNN, Transformer, GNN, State Space Models
├── 학습 패러다임: 지도, 비지도, 자기지도, 강화, 메타
├── 생성 모델: VAE, GAN, Diffusion, Flow, Autoregressive
├── 응용: CV, NLP, Speech, Robotics, Science
└── 시스템: 분산 학습, 모델 압축, 추론 최적화
```
