#!/usr/bin/env zsh
set -e

source ~/.zshrc
conda activate survival-kernets

python lt_tuna_kernet.py configs/cfg_kernet_small_simple_sim_15pct_trunc_part_1_lt.ini  
