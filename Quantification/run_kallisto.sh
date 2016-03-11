#!/bin/bash
#
# filename: run_kallisto.sh
# summary: wrapper script to run a batch job for batch_kallisto.sh
#	which is a Kallisto transcript quantification with arguments:
#	<path_to_aligned_hits.bam> <path_to_annotation_genome> 
#	<output_directory>

# inputs
DATA="/n/regal/eddy_lab/pkoo/opticlobe/alignment/star1pass/"
INDEX="/n/regal/eddy_lab/pkoo/opticlobe/reference_transcriptome/dm6_transcripts.idx"
OUTPUT="/n/regal/eddy_lab/pkoo/opticlobe/quantification/"

# make quantification directory
if [ ! -d "$OUTPUT" ]; then
    mkdir $OUTPUT
fi

# make a directory for kallisto within quantifiation directory
DIRECTORY=$OUTPUT"kallisto-star1pass/"
if [ ! -d "$DIRECTORY" ]; then
    echo "making directory "$DIRECTORY
    mkdir $DIRECTORY
fi

# submit jobs for all aligned.bam files in DATA directory
for i in $DATA*Aligned.sortedByCoord.out.bam; do
    NAME=${i%Aligned.sortedByCoord.out.bam}
    NAME=${NAME##*/}
    sbatch batch_kallisto.sh $i $INDEX $DIRECTORY$NAME
done

