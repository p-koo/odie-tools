#!/bin/bash
#
# filename: run_cufflinks.sh
# summary: wrapper script to run a batch job for batch_cufflinks.sh 
#	which is a transcript assembly with arguments:
# 	<path_to_aligned_hits.bam> <path_to_annotation_genome> 
#	<output_directory>

# inputs
DATA="/n/regal/eddy_lab/pkoo/opticlobe/alignment/star1pass/"
ANNOTATION="/n/regal/eddy_lab/pkoo/opticlobe/reference_annotation/dm6_Ensembl.gtf"
OUTPUT="/n/regal/eddy_lab/pkoo/opticlobe/assembly/"

# make assembly directory
if [ ! -d "$OUTPUT" ]; then
    mkdir $OUTPUT
fi

# make a directory for cufflinks within assembly directory
DIRECTORY=$OUTPUT"cufflinks"
if [ ! -d "$DIRECTORY" ]; then
    mkdir $DIRECTORY
fi

# submit jobs for all fastq files in DATA directory
for i in $DATA*Aligned.sortedByCoord.out.bam; do
    NAME=${i%Aligned.sortedByCoord.out.bam}
    NAME=${NAME##*/}
    if [ ! -d "$DIRECTORY$NAME" ]
	mkdir $DIRECTORY$NAME
    fi
    sbatch batch_cufflinks.sh $i $ANNOTATION $DIRECTORY$NAME
done

