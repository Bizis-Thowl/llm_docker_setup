VLLM_ATTENTION_BACKEND=FLASHINFER \
vllm serve Qwen/Qwen3-30B-A3B-Instruct-2507-FP8 \
--max-model-len 100000 \
--max-num-seqs 50 \
--served-model-name Qwen3-30B-A3B-Instruct \
--enable-auto-tool-choice \
--tool-call-parser hermes \
--enable-sleep-mode \
--gpu-memory-utilization .8 \
--port 11434 \
--host 0.0.0.0