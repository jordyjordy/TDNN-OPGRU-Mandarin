#!/bin/sh
#you can control the resources and scheduling with '#SBATCH' settings
# (see 'man sbatch' for more information on setting these parameters)
# The default partition is the 'general' partition
#SBATCH --partition=general
# The default Quality of Service is the 'short' QoS (maximum run time: 4 hours)
#SBATCH --qos=short
# The default run (wall-clock) time is 1 minute
#SBATCH --time=01:00:00
# parallel tasks per job is 1
#SBATCH --ntasks=1
# Request 1 CPU per active thread of your program (assume 1 unless you specifically set this)
# The default number of CPUs per task is 1 (note: CPUs are always allocated per 2)
#SBATCH --cpus-per-task=4
# The default memory per node is 1024 megabytes (1GB) (for multiple tasks, specify --mem-per-cpu instead)
#SBATCH --mem=8G
# Set mail type to 'END' to receive a mail when the job finishes
# Do not enable mails when submitting large numbers (>20) of jobs at once
#SBATCH --gres=gpu
#SBATCH --mail-type=NONE
#srun bash local/nnet3/run_ivector_common.sh --stage 0 --stop-stage 8 --nj 4 
#srun bash local/chain/run_chain_common.sh --stage 11 --stop-stage  14
srun bash local/chain/tuning/run_tdnn_opgru_1b4.sh --stage 12 --stop-stage 16 --nj-initial 1 --nj-final 1 --num-epochs 6 --train-stage -10 --decode-nj 4
#srun bash run.sh --stage 2 --stop-stage 3 --train-nj 10 --decode-nj 4
