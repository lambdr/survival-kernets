#!/usr/bin/env zsh
set -e

source ~/.zshrc
conda activate survival-kernets

python lt_tuna_kernet.py configs/cfg_kernet_small_sim_60pct_trunc_part_3_lt.ini  
