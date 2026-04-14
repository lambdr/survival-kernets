#!/usr/bin/env zsh
set -e

source ~/.zshrc
conda activate survival-kernets

python lt_tuna_kernet.py configs/cfg_kernet_small_simple_sim_0pct_trunc_part_4_lt.ini  
