#!/usr/bin/env zsh
set -e

source ~/.zshrc
conda activate survival-kernets

python demo_xgb.py configs/cfg_baselines_small_sim_no_cens_dep_trunc_15pct_trunc_part_6_lt.ini
python demo_tuna_kernet.py configs/cfg_kernet_small_sim_no_cens_dep_trunc_15pct_trunc_part_6_lt.ini  
