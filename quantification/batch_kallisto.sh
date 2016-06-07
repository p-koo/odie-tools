#!/bin/bash
#
# filename: batch_kallisto.sh
# summary: runs the Kallisto transcript quanitification with arguments:
#	<path_to_aligned_bam> <path_to_index_transcripts> <output_directory>
# example: sbatch run_kallisto.sh $DATA $INDEX $OUTPUT
#
#SBATCH -J Kallisto                     # job name
#SBATCH -p serial_requeue               # partition (general,serial_requeue)
#SBATCH -n 4							# number of cores
#SBATCH -N 1                            # number of nodes
#SBATCH --mem 8000                     # memory pool for all cores
#SBATCH -t 0-2:00                       # time (D-HH:MM)
#SBATCH -o log/kallisto_%A.out          # STDOUT
#SBATCH -e log/kallisto_%A.err          # STDERR

#load modules 
source new-modules.sh
module load gcc openmpi kallisto

# run kallisto for transcript quantificaiton 
kallisto quant \
-i $2 \
-o $3.kallisto_out \
--single \
-l 50 \
-s 1 \
--bias \
-b 100 \
-t 4 \
$1

 
