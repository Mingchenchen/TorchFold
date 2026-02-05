# NOTE: This script is the template for the environment variables used in the training script.
#       You may copy this file to `env.sh` and modify the variables as needed.

# cd $(dirname "$0")

# Activate the conda environment
# conda activate torchfold

# Basic path settings
export JSON_PATH=/home/code/processed
export DB_DIR=/home/data/datasets/AF3
export MODEL_DIR=/home/code/alphafold3/src/alphafold3/model
export OUTPUT_DIR=$(pwd)/output
export LOG_DIR=${OUTPUT_DIR}/log
mkdir -p ${OUTPUT_DIR}
mkdir -p ${LOG_DIR}
export CPU_PER_NUMA=32 # $(lscpu | grep socket | cut -d ' ' -f 22)

# Distributed settings
export MASTER_PORT=9539
export MASTER_ADDR=localhost
export NNODES=1
export NODE_RANK=2

# Single node settings
export NCORES=${CPU_PER_NUMA}
export RANK=0
