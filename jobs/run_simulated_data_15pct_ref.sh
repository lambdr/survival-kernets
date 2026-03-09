#!/usr/bin/env zsh
set -e

source ~/.zshrc
conda activate survival-kernets

python demo_xgb.py configs/cfg_baselines_simulated_data_15pct_ref.ini
python demo_tuna_kernet.py configs/cfg_kernet_simulated_data_15pct_ref.ini  # with summary fine-tuning
