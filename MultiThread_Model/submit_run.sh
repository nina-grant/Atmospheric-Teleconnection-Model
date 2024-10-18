#!/bin/bash

#SBATCH --clusters=Amarel
#SBATCH --partition=p_sebs_1
#SBATCH --requeue                    # Return job to the queue if preempted
#SBATCH --job-name=2cpu_10G_3dys     # Assign an short name to your job
#SBATCH --nodes=1                    # Number of nodes you require
#SBATCH --ntasks=1                   # Total # of tasks across all nodes
#SBATCH --cpus-per-task=2            # Cores per task (>1 if multithread tasks)
#SBATCH --mem=10G                    # Real memory (RAM) required per node
#SBATCH --time=03-00:00:00           # Total run time limit (DD-HH:MM:SS)
#SBATCH --error=error.err            # STDERR file for SLURM errors
#SBATCH --output=/scratch/nlg59/Output/control_feb.log  # STDOUT file for SLURM output

# Load the Anaconda module to ensure conda is available
source /projects/community/anaconda/2020.07/gc563/etc/profile.d/conda.sh

# Activate the Conda environment
conda activate PyGCM

## Run the job
cd /scratch/$USER/Model/Control_Feb 
srun python -u RunModel.beta.py
