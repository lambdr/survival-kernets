#!/usr/bin/env zsh
set -e

source ~/.zshrc
conda activate survival-kernets

python demo_xgb.py configs/cfg_baselines_simulated_data_0pct_trunc.ini
python demo_tuna_kernet.py configs/cfg_kernet_simulated_data_0pct_trunc.ini  # with summary fine-tuning
