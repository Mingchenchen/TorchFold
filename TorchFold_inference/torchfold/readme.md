# TorchFold Inference

A structure inference project based on TorchFold.

---

## Requirements

- Python 3.11
- Conda

---

## Installation

### 1. Create Environment

```bash
conda create -n TorchFold_inference_env python=3.11
conda activate TorchFold_inference_env
```

### 2. Install Dependencies

```bash
conda install gxx_linux-64 gxx_impl_linux-64 gcc_linux-64 gcc_impl_linux-64=13.2.0
```

### 3. Install HMMER

```bash
mkdir /path/to/hmmer_build /path/to/hmmer
wget http://eddylab.org/software/hmmer/hmmer-3.4.tar.gz -P /path/to/hmmer_build
cd /path/to/hmmer_build
tar -zxf hmmer-3.4.tar.gz
cd hmmer-3.4
./configure --prefix=/path/to/hmmer
make -j8
make install
```

### 4. Install AlphaFold 3.0.1

```bash
git clone https://github.com/google-deepmind/alphafold3.git
cd alphafold3
git checkout v3.0.1
pip install -r dev-requirements.txt
pip install --no-deps .
build_data
```

**Download Required Databases**:

Download the required AlphaFold databases to your directory :

```bash
bash fetch_databases.sh /path/to/database/dir
cd ..
```

### 5. Install TorchFold

```bash
git clone https://github.com/Mingchenchen/TorchFold.git
cd TorchFold/TorchFold_inference/torchfold
pip install .
```

---

## Running Inference

1. **Configure Paths**: Edit `scripts/env.sh` `run.sh` and modify the path configurations according to your environment.

2. **Run Inference**:

```bash
bash run.sh
```

---
