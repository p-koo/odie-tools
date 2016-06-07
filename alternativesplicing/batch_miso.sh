#!/bin/bash
#
# filename: batch_bamsortindex.sh
# summary: run mixture of isoforms to determine alternative splicing
# percentage spliced in 
#
#SBATCH -J MISO					# job name
#SBATCH -p serial_requeue       # partition (general,serial_requeue)
#SBATCH -n 1                    # number of cores
#SBATCH -N 1                    # number of nodes
#SBATCH --mem 4000              # memory pool for all cores
#SBATCH -t 0-4:00               # time (D-HH:MM)
#SBATCH -o log/miso_%A.out   	# STDOUT
#SBATCH -e log/miso_%A.err     	# STDERR

# load modules
module load python/2.7.6-fasrc01
source activate pyMISO

miso --run $2 $1 --output-dir $4 --read-len $3 # --use-cluster
summarize_miso --summarize-samples $4 $4


