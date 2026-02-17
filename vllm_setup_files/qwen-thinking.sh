VLLM_ATTENTION_BACKEND=FLASHINFER \
vllm serve Qwen/Qwen3-30B-A3B-Thinking-2507-FP8 \
--max-model-len 100000 \
--max-num-seqs 50 \
--served-model-name Qwen3-30B-A3B-Thinking \
--enable-auto-tool-choice \
--tool-call-parser hermes \
--enable-sleep-mode \
--reasoning-parser deepseek_r1 \
--gpu-memory-utilization .8 \
--port 11434 \
--host 0.0.0.0
