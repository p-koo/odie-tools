#!/bin/bash
#
# filename: run_miso.sh
# summary: wrapper script to run a batch job for batch_fastq_dump.sh

# inputs
DATA="/n/regal/eddy_lab/pkoo/mRNAlocalization/data/rawreads/"

for i in $DATA*.sra; do 
	sbatch batch_fastq_dump.sh $i
done
