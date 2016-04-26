#!/bin/bash
#
# filename: batch_bamsortindex.sh
# summary: convert bam to a sorted indexed bam file
#
#SBATCH -J MISO					# job name
#SBATCH -p serial_requeue        	# partition (general,serial_requeue)
#SBATCH -n 16                       # number of cores
#SBATCH -N 1                            # number of nodes
#SBATCH --mem 8000              # memory pool for all cores
#SBATCH -t 0-1:00               # time (D-HH:MM)
#SBATCH -o log/miso_%A.out   	# STDOUT
#SBATCH -e log/miso_%A.err     	# STDERR
#SBATCH --mail-type=FAIL 		# notifications (END,FAIL,ALL)
#SBATCH --mail-user=peter_koo@harvard.edu     # send-to address

# load modules
module load python/2.7.6-fasrc01
source activate pyMISO

miso --run $2 $1 --output-dir $4 --read-len $3 --use-cluster

