#### Component Versions

```shell
cann：8.3.RC1.alpha001
python：3.11
torch：2.6.0
torch-npu：2.6.0
```

#### Environment Setup

a. Create a new conda environment
```shell
conda create --name torchfold python=3.11
conda activate torchfold
```

b. Install hmmer
```shell
conda install -c bioconda hmmer
```

c. Install torch, torch_npu and base libraries
```shell
pip install decorator attrs jinja2 psutil absl-py cloudpickle ml-dtypes psutil scipy tornado pyyaml pybind11 loguru 
pip install torch==2.6.0
pip install torch_npu==2.6.0
```
d. Install mx_driving
After cloning the code, change ENABLE_ONNX to False in CMakePresets.json.
```shell
git clone https://gitee.com/ascend/DrivingSDK.git
cd DrivingSDK
pip install cmake  # requires >=3.19.0
pip install -r requirements.txt
bash ci/build.sh --python=3.11
pip3 install dist/mx_driving-1.0.0+git{commit_id}-cp{python_version}-linux_{arch}.whl
cd ..
```

e. Install triton-ascend
Version 3.2.0.dev2025103116 or any version released after August 2025. Choose one of the following methods:

(1) Download the whl from https://test.pypi.org/project/triton-ascend/#files and install
```shell
pip install triton_ascend-3.2.0.dev2025103116-cp311-cp311-manylinux_2_27_aarch64.manylinux_2_28_aarch64.whl
```
(2) Install directly via command line. If you encounter SSLError, download the crt certificate and add '--cert Huawei_Web_Secure_Internet_Gateway_CA.crt' at the end of the command
```shell
pip install -i https://test.pypi.org/simple/ triton-ascend==3.2.0.dev2025103116
```

f. Install jax-triton
```shell
git clone https://github.com/jax-ml/jax-triton.git
cd jax-triton
git tag -l
git checkout tags/v0.2.0
git clone --branch v0.2.0 --depth 1 https://github.com/jax-ml/jax-triton.git
# Modify pyproject.toml in the jax-triton folder, change triton>=3.1 to triton_ascend>=3.1
pip install -e .
cd ..
```

g. Install tcmalloc dynamic library based on your operating system

The environment variable LD_PRELOAD is loaded in the model startup script run.sh. It defaults to OpenEuler system. If you are using Ubuntu, you need to modify it accordingly.

- OpenEuler System

Execute the following commands in your current python environment and path to install and use the tcmalloc dynamic library.
```shell
mkdir gperftools
cd gperftools
wget https://github.com/gperftools/gperftools/releases/download/gperftools-2.16/gperftools-2.16.tar.gz --no-check-certificate
tar -zvxf gperftools-2.16.tar.gz
cd gperftools-2.16
./configure --prefix=/usr/local/lib --with-tcmalloc-pagesize=64
make
make install
echo '/usr/local/lib/lib/' >> /etc/ld.so.conf
ldconfig
export LD_PRELOAD=/usr/local/lib/libtcmalloc.so.4
```
- Ubuntu System

Execute the following commands in your current python environment and path to install and use the tcmalloc dynamic library. Before installing tcmalloc, ensure that autoconf and libtool dependencies are available in your environment.

Install libunwind dependency:
```shell
git clone https://github.com/libunwind/libunwind.git
cd libunwind
autoreconf -i
./configure --prefix=/usr/local
make -j128
make install
```

Install tcmalloc dynamic library:
```shell
wget https://github.com/gperftools/gperftools/releases/download/gperftools-2.16/gperftools-2.16.tar.gz --no-check-certificate
tar -xf gperftools-2.16.tar.gz && cd gperftools-2.16
./configure --prefix=/usr/local/lib --with-tcmalloc-pagesize=64
make -j128
make install
export LD_PRELOAD="$LD_PRELOAD:/usr/local/lib/lib/libtcmalloc.so"
```


#### Pull Model Code

a. Clone and install alphafold3

It is recommended to clone the alphafold3 source code in a directory parallel to torchfold. After installation, you need to apply for and download the model weights file af3.bin from the official website, then place it in alphafold3/src/alphafold3/model.
```shell
git clone https://github.com/google-deepmind/alphafold3.git && cd alphafold3
git checkout a14376d249099b3e64ae8010290d4e20720d2698
git apply ../torchfold/alphafold3.patch
pip install -r dev-requirements.txt
pip install . --no-deps --verbose
build_data
cd ..
```

b. Enter torchfold model directory
```shell
cd torchfold
pip install einops
pip install numpy==1.26.4
mkdir output
```

#### Dataset Preparation

Please refer to the Alphafold3 model README for downloading datasets.

#### Inference

Before running the inference script, you need to modify the paths in scripts/env.sh.
```shell
bash run.sh
```
