#!/usr/bin/env bash

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
set -xeu pipefail

# Download and Install Miniconda
CONDA='miniconda3_483'
INSTPATH="$HOME/$CONDA"
curl -Lo "inst.sh" \
     "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
bash "inst.sh" -b -f -p "$INSTPATH" && rm -f "inst.sh"
export PATH="$INSTPATH/bin:$PATH"


# Pin the python version to avoid major updates on new package installs
echo "python 3.8.*" > "$INSTPATH/conda-meta/pinned"

# Install Anaconda packages for Python 3.x
conda env create -f $HERE/DS-networks.yml

$HOME/$CONDA/envs/DS/bin/python -m ipykernel install --prefix=$HOME/$CONDA/envs/JupyterSystemEnv --name 'conda_DS'

conda clean --verbose -ay

ln -s "$INSTPATH/bin/python" "$HOME/.local/bin/python38"

rm -rf "$HOME/.cache/pip"
