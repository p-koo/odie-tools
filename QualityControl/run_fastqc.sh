#!/bin/bash
#
# filename: run_fastqc.sh
# summary: wrapper script for batch_fastqc.sh which performs quality control 
# 	on all fastq files in DATA and save files in a fastqc directory
#	within the OUTPUT directory

# inputs
DATA="/n/regal/eddy_lab/pkoo/opticlobe/data/"
OUTPUT="/n/regal/eddy_lab/pkoo/opticlobe/qualitycontrol/"

# make a directory for quality control
if [ ! -d "$OUTPUT" ]; then
    mkdir $OUTPUT
fi

# make a directory for fastqc in quality control directory  
DIRECTORY=$OUTPUT"fastqc"
if [ ! -d "$DIRECTORY" ]; then
    mkdir $DIRECTORY
fi

sbatch batch_fastqc.sh $DATA $DIRECTORY
