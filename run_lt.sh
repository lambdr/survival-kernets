#!/usr/bin/env zsh
set -e

# run demo.sh equivalent but with left-truncated data
python demo_xgb.py cfg_baselines_lt.ini
python demo_tuna_kernet.py cfg_kernet_nosplit_sft_lt.ini  # with summary fine-tuning

