#!/bin/bash
#
# filename: run_gtf_to_fasta.sh
# summary: wrapper script to run a tophat to convert a gtf file into 
#	fasta format for kallisto quantification

# inputs
INDEX="/n/regal/eddy_lab/pkoo/opticlobe/reference_transcriptome/dm6_transcripts.idx"
OUTPUT="/n/regal/eddy_lab/pkoo/opticlobe/assembly/"

# make quantification directory
if [ ! -d "$OUTPUT" ]; then
    mkdir $OUTPUT
fi

# make a directory for kallisto within quantifiation directory
DIRECTORY=$OUTPUT"transcriptome/"
if [ ! -d "$DIRECTORY" ]; then
    echo "making directory "$DIRECTORY
    mkdir $DIRECTORY
fi

# submit jobs for all aligned.bam files in DATA directory
for i in $OUTPUT*.gtf; do
    NAME=${i%.gtf}
    NAME=${NAME##*/}
    sbatch batch_kallisto.sh $i $INDEX $DIRECTORY$NAME
done
