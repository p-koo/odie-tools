#!/bin/bash
#
# filename: run_miso.sh
# summary: wrapper script to run a batch job for batch_miso_index.sh

# inputs
DATA="/n/regal/eddy_lab/pkoo/opticlobe/alignment/test/" #STAR1pass/"
INDEX="/n/regal/eddy_lab/pkoo/opticlobe/reference_asevent/SE_dm/"

# perform alignment to reference genome
for i in $DATA*.bam; do 
    NAME=${i%.bam}".sorted"
	sbatch batch_miso.sh $DATA $INDEX $LENGTH $OUTPUT
    sbatch batch_bamsortindex.sh $i $NAME
done

