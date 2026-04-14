#!/usr/bin/env zsh
set -e

source ~/.zshrc
conda activate survival-kernets

python demo_xgb.py configs/cfg_baselines_small_simple_sim_60pct_trunc_part_5_lt.ini
python demo_tuna_kernet.py configs/cfg_kernet_small_simple_sim_60pct_trunc_part_5_lt.ini  
