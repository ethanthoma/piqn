#!/usr/bin/env bash

#SBATCH --account=def-gerope
#SBATCH --time=1-00:00:00
#SBATCH --tasks=1
#SBATCH --output=output/%j.out
#SBATCH --error=error/%j.out
#SBATCH --cpus-per-task=20
#SBATCH --mem=64G
#SBATCH --gres=gpu:v100:4
#SBATCH --constraint=cascade,v100

lscpu
nvidia-smi

# Load modules for environment
module load StdEnv/2020
module load python/3.8.10
module load scipy-stack/2023a

# Create environment
virtualenv --no-download ENV
source ENV/bin/activate

# update pip
pip install --no-index --upgrade pip

# install reqs
pip install --no-index -r requirements.txt

# run eval
python piqn.py train --config ./configs/flat.conf

deactivate
