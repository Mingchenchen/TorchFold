#!/bin/bash
# This script is used to run AlphaFold on a single node.

# cd $(dirname "$0")
source scripts/env.sh || { \
    echo 'Please place your `env.sh` under `scripts` directory.'; \
    echo 'You can refer to `env.sh.example` for the content of `env.sh`.'; \
    exit 1; \
}

cur_path=$(pwd)
INPUT_NAME=${1:-37aa_2JO9.json}

export CPU_AFFINITY_CONF=1
export TASK_QUEUE_ENABLE=2
export PYTORCH_NPU_ALLOC_CONF=expandable_segments:True
export LD_PRELOAD=/usr/local/lib/libtcmalloc.so.4
export USE_DIST=0

# dot_product_attention, options: ["torch", "Fusion_Attention"]
echo "Running AlphaFold on single node for ${INPUT_NAME}, NCORES=${NCORES}, RANK=${RANK}"
python run_alphafold.py \
    --run_data_pipeline=True \
    --json_path=${JSON_PATH}/${INPUT_NAME} \
    --model_dir=${MODEL_DIR} \
    --output_dir=${OUTPUT_DIR} \
    --db_dir=${DB_DIR} \
    --dot_product_attention=Fusion_Attention \
    | tee -a ${LOG_DIR}/${INPUT_NAME}.log
