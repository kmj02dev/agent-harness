# ML/DL Research

## Stack
- PyTorch (기본), JAX (필요 시)
- wandb/tensorboard (실험 추적)
- hydra/OmegaConf (설정 관리)
- GPU 서버 환경 (CUDA)

## Rules
- 실험은 반드시 시드 고정 (`torch.manual_seed`, `random.seed`, `np.random.seed`)
- 모든 하이퍼��라미터는 config 파일로 관리 — 코드에 하드코딩 금지
- 실험 결과는 wandb 또는 CSV로 기록 — 나중에 비교할 수 있어야 함
- 모델 체크포인트 저장 주기 설정 — 학습 중단 시 복구 가능해야 함
- 베이스라인을 먼저 구현하고 돌린다 — 자기 방법과 비교할 기준점 확보

## Pitfalls
- GPU 메모리 부족: `torch.cuda.empty_cache()` 대신 배치 크기 조정 또는 gradient accumulation
- 재현 불가: DataLoader의 `num_workers > 0`이면 `worker_init_fn`도 시드 설정 필요
- 학습률 너무 높으면 loss NaN — lr=1e-4부터 시작하고 조정
- eval 모드 빠뜨림: 평가 시 `model.eval()` + `torch.no_grad()` 필수

## Quality Checklist
- [ ] 시드 고정되어 있는가?
- [ ] config로 하이���파라미터 분리되어 있는가?
- [ ] 베이스라인 결과가 있는가?
- [ ] 실험 로그가 기록되고 있는가?
- [ ] 체크포인트 저장이 설정되어 있는가?
- [ ] eval 모드에서 올바르게 평가하는가?
