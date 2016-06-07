#!/bin/bash
#
# filename: batch_miso_index.sh
# summary: index an alternative splicing gff for MISO
#
#SBATCH -J MisoIndex				# job name
#SBATCH -p serial_requeue        	# partition (general,serial_requeue)
#SBATCH -n 1                       	# number of cores
#SBATCH -N 1                        # number of nodes
#SBATCH --mem 4000                	# memory pool for all cores
#SBATCH -t 0-1:00                   # time (D-HH:MM)
#SBATCH -o log/misoindex_%A.out   	# STDOUT
#SBATCH -e log/misoindex_%A.err   	# STDERR

# load modules
module load python/2.7.6-fasrc01
source activate pyMISO

index_gff --index $1 $2

