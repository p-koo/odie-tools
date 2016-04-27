#!/bin/bash
#
# filename: run_miso.sh
# summary: wrapper script to run a batch job for batch_miso_index.sh

# inputs
DATA="/n/regal/eddy_lab/pkoo/opticlobe/alignment/STAR1pass/"
INDEX="/n/regal/eddy_lab/pkoo/opticlobe/reference_asevent/SE_dm/"
LENGTHPATH="/n/regal/eddy_lab/pkoo/opticlobe/alignment/test/length.csv"
OUTPUT="/n/regal/eddy_lab/pkoo/opticlobe/alternativesplicing/"


# make alignment directory
if [ ! -d "$OUTPUT" ]; then
    mkdir $OUTPUT
fi

for i in $DATA*.sorted.bam; do 
    NAMEPATH=${i%.sorted.bam}
    NAME=${NAMEPATH##*/}
    NAME=${NAME%Aligned*}
    LENGTH="$(grep $NAME $LENGTHPATH | grep -oE "[^,]+$")"
	sbatch batch_miso.sh $i $INDEX $LENGTH $OUTPUT$NAME
done

