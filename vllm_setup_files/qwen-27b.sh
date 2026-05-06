#!/bin/bash
#
 
set -euo pipefail

HOST="${HOST:-0.0.0.0}"
PORT="${PORT:-11434}"
 
export CUDA_VISIBLE_DEVICES="0"
 
export PYTORCH_CUDA_ALLOC_CONF="expandable_segments:True"
export VLLM_FLOAT32_MATMUL_PRECISION=high
export VLLM_SSM_CONV_STATE_LAYOUT=DS
export NCCL_P2P_DISABLE=1
export NCCL_CUMEM_ENABLE=0
export VLLM_USE_FLASHINFER_SAMPLER=1
export VLLM_USE_FUSED_MOE_GROUPED_TOPK=1
export OMP_NUM_THREADS=1
export CUDA_DEVICE_MAX_CONNECTIONS=8
export VLLM_ALLOW_LONG_MAX_MODEL_LEN=1
export VLLM_WORKER_MULTIPROC_METHOD=spawn
export VLLM_MARLIN_USE_ATOMIC_ADD=1
 
exec vllm serve cyankiwi/Qwen3.6-27B-AWQ-BF16-INT4 \
    --gpu-memory-utilization 0.5 \
    --max-model-len 120000 \
    --max-num-seqs 20 \
    --max-num-batched-tokens 4096 \
    --kv-cache-dtype fp8 \
    --disable-custom-all-reduce \
    --trust-remote-code \
    --enable-auto-tool-choice \
    --tool-call-parser qwen3_coder \
    --reasoning-parser qwen3 \
    --served-model-name Qwen3.6-27B \
    --host "${HOST}" \
    --port "${PORT}" \
    --limit-mm-per-prompt '{"image":{"count":4},"video":{"count":0},"audio":{"count":0}}' \
    --speculative-config '{"method":"mtp","num_speculative_tokens":2}' \
    --enable-chunked-prefill \
    --scheduling-policy fcfs \
    --async-scheduling \
    --no-enforce-eager \
    --block-size 32 \
    --mamba-cache-mode all \
    --enable-prefix-caching \
    --override-generation-config '{"temperature": 0.95, "top_k": 20, "top_p": 0.95, "min_p":0.0, "repetition_penalty": 1.05, "presence_penalty": 0.0}' \
    --attention-config '{"flash_attn_max_num_splits_for_cuda_graph": 3, "use_prefill_decode_attention": true}'  \
    --compilation-config '{"mode": 3, "max_cudagraph_capture_size": 128, "cudagraph_capture_sizes": [1, 2, 4, 8, 16, 32, 48, 64, 128], "use_inductor_graph_partition": true, "inductor_compile_config": {"combo_kernels": true, "benchmark_combo_kernel": true }, "compile_sizes": [1, 2, 4, 8, 16, 32, 64, 128], "compile_ranges_endpoints": null}'