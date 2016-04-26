#!/bin/bash
#
# filename: batch_bamsortindex.sh
# summary: convert bam to a sorted indexed bam file
#
#SBATCH -J BamSortIndex					# job name
#SBATCH -p serial_requeue        	# partition (general,serial_requeue)
#SBATCH -n 1                       # number of cores
#SBATCH -N 1                            # number of nodes
#SBATCH --mem 4000                	# memory pool for all cores
#SBATCH -t 0-0:50                       # time (D-HH:MM)
#SBATCH -o log/sam_%A.out   	# STDOUT
#SBATCH -e log/sam_%A.err     	# STDERR

# load modules
source new-modules.sh
module load samtools/1.2-fasrc01

# perform alignment to reference genome
samtools sort $1 $2
samtools index $2.bam
