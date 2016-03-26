#!/bin/bash
#
# filename: run_kallisto_index.sh
# summary: wrapper script to run a batch job for batch_kallisto_index.sh
#	which is a Kallisto transcriptome index  with arguments:
#	<path_to_gtf_file> <output_directory>

# inputs
TRANSCRIPTOME="/n/regal/eddy_lab/pkoo/opticlobe/assembly/stringtie/merge/"

# make a reference transcriptome directory if doesn’t exist
OUTPUT="/n/regal/eddy_lab/pkoo/opticlobe/reference_transcriptome/"
if [ ! -d "$OUTPUT" ]; then
    mkdir $OUTPUT
fi

# submit jobs for all aligned.bam files in DATA directory
for i in $TRANSCRIPTOME*.fa*; do
    NAME=${i%.fa*}
    NAME=${NAME##*/}
    sbatch batch_kallisto_index.sh $i $OUTPUT$NAME 
done

