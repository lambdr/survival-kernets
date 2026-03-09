#!/usr/bin/env zsh
set -e

source ~/.zshrc
conda activate survival-kernets

python demo_xgb.py configs/cfg_baselines_support_trunc_60pct_ref.ini
python demo_tuna_kernet.py configs/cfg_kernet_support_trunc_60pct_ref.ini  # with summary fine-tuning
