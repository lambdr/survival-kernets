#!/usr/bin/env zsh
set -e

source ~/.zshrc
conda activate survival-kernets

#python demo_xgb.py configs/testing_lt_cfg_baseline.ini
python lt_tuna_kernet.py configs/testing_lt_cfg_kernet.ini
