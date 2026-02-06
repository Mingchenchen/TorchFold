#!/bin/bash


source scripts/env.sh || { \
    echo 'Please set your `env.sh` under `scripts` directory.'; \
    exit 1; \
}
INPUT_NAME=${1:-test.json}


# model_dir and checkpoint_path are mutually exclusive: exactly one must be provided (configured in env.sh)
if [ -n "${CHECKPOINT_PATH}" ] && [ -n "${MODEL_DIR}" ]; then
    echo "Error: set only one of CHECKPOINT_PATH or MODEL_DIR in env.sh (they are mutually exclusive)."
    exit 1
fi
if [ -z "${CHECKPOINT_PATH}" ] && [ -z "${MODEL_DIR}" ]; then
    echo "Error: set one of CHECKPOINT_PATH or MODEL_DIR in env.sh."
    exit 1
fi

MODEL_ARG=""
CKPT_ARG=""
if [ -n "${CHECKPOINT_PATH}" ]; then
    CKPT_ARG="--checkpoint_path=${CHECKPOINT_PATH}"
    echo "Using checkpoint: ${CHECKPOINT_PATH}"
else
    MODEL_ARG="--model_dir=${MODEL_DIR}"
    echo "Using model_dir: ${MODEL_DIR}"
fi


/path/to/python run_alphafold.py \
    --json_path=${JSON_PATH}/${INPUT_NAME} \
    --output_dir=${OUTPUT_DIR} \
    --db_dir=${DB_DIR} \
    --num_diffusion_samples=${NUM_DIFFUSION_SAMPLES} \
    --run_data_pipeline=${RUN_DATA_PIPELINE} \
    ${MODEL_ARG} ${CKPT_ARG} 2>&1 \
    | tee -a ${LOG_DIR}/${INPUT_NAME}.log
