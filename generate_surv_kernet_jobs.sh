#!/usr/bin/env zsh
set -e

# Usage: ./generate_run_script.sh <dataset> <output_dir_baselines> <output_dir_kernet>
# Example: ./generate_run_script.sh simulated_lt out_baselines_sim out_kernet_sim

DATASET=$1

DIR_BASELINES="results/260308_${DATASET:r}_baseline"
DIR_KERNET="results/260308_${DATASET:r}_results"

CFG_BASELINES="cfg_baselines_${DATASET:r}.ini"
CFG_KERNET="cfg_kernet_${DATASET:r}.ini"
OUT_SCRIPT="run_${DATASET:r}.sh"

mkdir -p configs

# Create cfg_baselines_<dataset>.ini
cat > configs/${CFG_BASELINES} << EOF
[DEFAULT]
n_experiment_repeats = 5
simple_data_splitting_val_ratio = 0.2
fix_test_shuffle_train = 1
datasets = ['${DATASET}']
init_output_dir = ${DIR_BASELINES}
output_dir = ${DIR_BASELINES}
compute_bootstrap_CI = 0
bootstrap_n_samples = 200
bootstrap_CI_coverage = 0.95
bootstrap_random_seed = 4049105963
max_n_cores = -1
mds_random_seed = 2306758833
mds_n_init = 4
verbose = 0
early_stopping_patience = 10

[method: xgb]
n_parallel_trees = [1, 10]
max_features = ['0.5sqrt', 'sqrt', '2sqrt', None]
subsample = [0.6, 0.8]
eta = [.1, .3, 1.]
max_depth = [3, 6, 9, 12]
max_n_rounds = 100
max_n_rounds_kkbox = 20
pretrain_frac = 1.
random_seed = 1738522352
EOF

# Create cfg_kernet_<dataset>.ini
cat > configs/${CFG_KERNET} << EOF
[DEFAULT]
n_experiment_repeats = 5
simple_data_splitting_val_ratio = 0.2
fix_test_shuffle_train = 1
datasets = ['${DATASET}']
ANN_max_n_neighbors = [128]
init_output_dir = ${DIR_BASELINES}
output_dir = ${DIR_KERNET}
compute_bootstrap_CI = 0
bootstrap_n_samples = 200
bootstrap_CI_coverage = 0.95
bootstrap_random_seed = 4049105963
max_n_cores = -1
tuna_random_seed = 2306758833
verbose = 0
early_stopping_patience = 10

[method: xgb]
n_parallel_trees = [1, 10]
max_features = ['0.5sqrt', 'sqrt', '2sqrt', None]
subsample = [0.6, 0.8]
eta = [.1, .3, 1.]
max_depth = [3, 6, 9, 12]
max_n_rounds = 100
max_n_rounds_kkbox = 20
pretrain_frac = 1.
random_seed = 1738522352

[method: kernet]
max_n_epochs = 100
max_n_epochs_kkbox = 10
pretrain_frac = 1.
alpha = [0, 0.001, 0.01]
sigma = [0.1, 1]
gamma = [0]
n_durations = [0, 64, 128]
beta = [0.25, 0.5]
squared_radius = [0.1]
min_kernel_weight = [1e-2]
batch_size = [1024]
n_layers = [2, 4, 6]
n_nodes = [32, 64, 128]
learning_rate = [0.01, 0.001]
sumtune_learning_rate = [0.05, 0.01]
random_seed = 4063380196
finetune_summaries = 1
EOF

# Create the run script
cat > jobs/${OUT_SCRIPT} << EOF
#!/usr/bin/env zsh
set -e

source ~/.zshrc
conda activate survival-kernets

python demo_xgb.py configs/${CFG_BASELINES}
python demo_tuna_kernet.py configs/${CFG_KERNET}  # with summary fine-tuning
EOF

chmod +x jobs/${OUT_SCRIPT}

echo "Created:"
echo "  configs/${CFG_BASELINES}"
echo "  configs/${CFG_KERNET}"
echo "  ${OUT_SCRIPT}"