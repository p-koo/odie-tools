#!/bin/bash
#
# filename: run_bamsortindex.sh
# summary: wrapper script to run a batch job for batch_bamsortindex.sh

# inputs
DATA="/n/regal/eddy_lab/pkoo/opticlobe/alignment/STAR1pass/"

# perform alignment to reference genome
for i in $DATA*.bam; do 
    NAME=${i%.bam}".sorted"
    sbatch batch_bamsortindex.sh $i $NAME
done

