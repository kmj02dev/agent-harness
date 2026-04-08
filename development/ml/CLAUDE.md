# Machine Learning / Deep Learning — Development

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

## Common Misconceptions
- "파라미터 많으면 무조건 과적합" — 이중 하강(double descent) 현상으로 반드시 그렇지 않음
- "높은 학습률 = 빠른 수렴" — 발산 위험, 스케줄링이 핵심
- "SOTA = 실용적" — 벤치마크 성능과 실제 배포 성능은 다름

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

## Stack
- PyTorch (기본), JAX (필요 시)
- wandb/tensorboard (실험 추적)
- hydra/OmegaConf (설정 관리)
- GPU 서버 환경 (CUDA)

## Rules
- 실험은 반드시 시드 고정 (`torch.manual_seed`, `random.seed`, `np.random.seed`)
- 모든 하이퍼파라미터는 config 파일로 관리 — 코드에 하드코딩 금지
- 실험 결과는 wandb 또는 CSV로 기록 — 나중에 비교할 수 있어야 함
- 모델 체크포인트 저장 주기 설정 — 학습 중단 시 복구 가능해야 함
- 베이스라인을 먼저 구현하고 돌린다 — 자기 방법과 비교할 기준점 확보
- GPU 기본 사용, 불가능 시 CPU.

## Pitfalls
- GPU 메모리 부족: `torch.cuda.empty_cache()` 대신 배치 크기 조정 또는 gradient accumulation
- 재현 불가: DataLoader의 `num_workers > 0`이면 `worker_init_fn`도 시드 설정 필요
- 학습률 너무 높으면 loss NaN — lr=1e-4부터 시작하고 조정
- eval 모드 빠뜨림: 평가 시 `model.eval()` + `torch.no_grad()` 필수

## Quality Checklist
- [ ] 시드 고정되어 있는가?
- [ ] config로 하이퍼파라미터 분리되어 있는가?
- [ ] 베이스라인 결과가 있는가?
- [ ] 실험 로그가 기록되고 있는가?
- [ ] 체크포인트 저장이 설정되어 있는가?
- [ ] eval 모드에서 올바르게 평가하는가?
