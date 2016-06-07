#!/bin/bash
#
# filename: batch_fastqc.sh
# summary: this script runs fastqc batch job on all fastq files in 
# 	<data_directory> and save files to <output_directory>
# example: sbatch run_fastqc.sh <data_directory> <output_directory> 
#
#SBATCH -J FastQC					# job name
#SBATCH -p serial_requeue         	# partition (general,serial_requeue)
#SBATCH -n 1						# number of cores
#SBATCH -N 1                        # number of nodes
#SBATCH --mem 4000                	# memory pool for all cores
#SBATCH -t 0-20:00                  # time (D-HH:MM)
#SBATCH -o log/fastqc_%A.out   		# STDOUT
#SBATCH -e log/fastqc_%A.err     	# STDERR

# load modules
source new-modules.sh
module load fastqc/0.11.3-fasrc01

for i in $1*.fastq*; do 
    fastqc $i --extract --outdir=$2
done

