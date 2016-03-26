#!/bin/bash
#
# filename: run_gtf_to_fasta.sh
# summary: wrapper script to run a tophat to convert a gtf file into 
#	fasta format for kallisto quantification

# inputs
GENOME="/n/regal/eddy_lab/pkoo/opticlobe/reference_genome/dm6.fa"
OUTPUT="/n/regal/eddy_lab/pkoo/opticlobe/assembly/stringtie/merge/"

# submit jobs for all aligned.bam files in DATA directory
for i in $OUTPUT; do
    NAME=${i%.gtf}
    NAME=${NAME##*/}
    sbatch batch_kallisto.sh $i $GENOME $OUTPUT$NAME".fa"
done
