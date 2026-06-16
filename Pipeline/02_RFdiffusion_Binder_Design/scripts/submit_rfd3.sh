#!/bin/bash
#BSUB -J rfd3_tem1_1zg4
#BSUB -q gpuv100
#BSUB -gpu "num=1"
#BSUB -n 4
#BSUB -W 02:00
#BSUB -R "rusage[mem=16GB]"
#BSUB -o rfd3_%J.out
#BSUB -e rfd3_%J.err

source /dtu/blackhole/00/c27666/miniforge3/etc/profile.d/conda.sh
conda activate protein-design

cd /dtu/blackhole/12/220114/TEM1_1ZG4/exp_01

rfd3 design \
  out_dir=/dtu/blackhole/12/220114/TEM1_1ZG4/exp_01/diffusion_out \
  inputs=/dtu/blackhole/12/220114/TEM1_1ZG4/exp_01/configs/TEM1_1ZG4_rfd3.json \
  ckpt_path=/zhome/c7/d/220114/.foundry/checkpoints/rfd3_latest.ckpt \
  diffusion_batch_size=1 \
  n_batches=1 \
  inference_sampler.step_scale=3 \
  inference_sampler.gamma_0=0.2