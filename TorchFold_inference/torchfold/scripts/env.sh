#!/bin/bash

# =============================================================================
# Basic Path Settings
# =============================================================================
export JSON_PATH=/path/to/json/dir
export OUTPUT_DIR=/path/to/output/dir
export LOG_DIR=${OUTPUT_DIR}/log
mkdir -p ${OUTPUT_DIR}
mkdir -p ${LOG_DIR}



# =============================================================================
# Database Settings
# =============================================================================
# Configure the following lines according to the paths set in README:
# - DB_DIR: Set according to the database directory path in README section "Download Required Databases"
# - PATH: Set according to the HMMER installation path in README section "Install HMMER" (/path/to/hmmer/bin)
export DB_DIR=/path/to/database/dir
export PATH="/path/to/hmmer/bin:$PATH"

# Whether to run data pipeline (true/false)
export RUN_DATA_PIPELINE=true



# =============================================================================
# Inference Parameters
# =============================================================================
# Number of diffusion samples for inference
export NUM_DIFFUSION_SAMPLES=5



# =============================================================================
# Inference Weights Configuration
# =============================================================================
# IMPORTANT: Choose ONE option below (they are mutually exclusive)
# 
# Option 1: Use TorchFold checkpoint
#   - Set CHECKPOINT_PATH to the checkpoint file
#   - Comment out MODEL_DIR
export CHECKPOINT_PATH=/path/to/checkpoint/file

# Option 2: Use JAX official weights
#   - Apply for AlphaFold3 parameters and set MODEL_DIR to the parameters directory
#   - Comment out CHECKPOINT_PATH
# export MODEL_DIR=/path/to/AlphaFold3/parameters/dir
