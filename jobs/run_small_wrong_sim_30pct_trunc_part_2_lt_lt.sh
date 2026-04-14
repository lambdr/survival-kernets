#!/usr/bin/env zsh
set -e

source ~/.zshrc
conda activate survival-kernets

python lt_tuna_kernet.py configs/cfg_kernet_small_wrong_sim_30pct_trunc_part_2_lt.ini  
