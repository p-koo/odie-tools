#!/bin/bash
#
# filename: run_kallisto_index.sh
# summary: runs Kallisto to build an index of the transcriptome 
#
#SBATCH -J Kallisto-index              	# job name
#SBATCH -p serial_requeue               # partition (general,serial_requeue)
#SBATCH -n 4                            # number of cores
#SBATCH -N 1                            # number of nodes
#SBATCH --mem 8000                     # memory pool for all cores
#SBATCH -t 0-1:00                       # time (D-HH:MM)
#SBATCH -o log/kallisto_index_%A.out    # STDOUT
#SBATCH -e log/kallisto_index_%A.err    # STDERR

# load modules
source new-modules.sh
module load gcc openmpi kallisto

# build transcriptome index
kallisto index -i $2".idx" $1


