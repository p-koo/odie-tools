#!/bin/bash
#
# filename: batch_bamsortindex.sh
# summary: convert bam to a sorted indexed bam file
#
#SBATCH -J sratoolkit					# job name
#SBATCH -p serial_requeue        	# partition (general,serial_requeue)
#SBATCH -n 1                       # number of cores
#SBATCH -N 1                            # number of nodes
#SBATCH --mem 4000              # memory pool for all cores
#SBATCH -t 0-2:00               # time (D-HH:MM)
#SBATCH -o log/sra_%A.out   	# STDOUT
#SBATCH -e log/sra_%A.err     	# STDERR

# load modules
module load bib/2014.05.19-fasrc02

fastq-dump --gzip $1*.sra



 

