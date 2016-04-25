#!/bin/bash
#
# filename: run_stringtie_assemble.sh
# summary: wrapper script to run a batch job for batch_stringtie_assemble.sh
# 	which is a StringTie transcript assembler with arguments 
#	<path_to_aligned_sorted_bam> <path_to_annotation_genome> 
#	<output_name>

# inputs
ALIGNER="STAR1pass/"
DATA="/n/regal/eddy_lab/pkoo/opticlobe/alignment/"$ALIGNER

# sort index bam files in DATA directory
sbatch batch_bamsortindex.sh $DATA


