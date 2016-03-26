#!/bin/bash
#
# filename: run_stringtie_assemble.sh
# summary: wrapper script to run a batch job for batch_stringtie_assemble.sh
# 	which is a StringTie transcript assembler with arguments 
#	<path_to_aligned_sorted_bam> <path_to_annotation_genome> 
#	<output_name>

# inputs
ALIGNER="STAR1pass/"
DATA="/n/regal/eddy_lab/pkoo/opticlobe/alignment/"$ALIGNER
ANNOTATION="/n/regal/eddy_lab/pkoo/opticlobe/reference_annotation/dm6_Ensembl.gtf"
OUTPUT="/n/regal/eddy_lab/pkoo/opticlobe/assembly/"

# make assembly directory
if [ ! -d "$OUTPUT" ]; then
    mkdir $OUTPUT
fi

# make a directory for stringtie
DIRECTORY=$OUTPUT"stringtie/"
if [ ! -d "$DIRECTORY" ]; then
    echo "making directory "$DIRECTORY
    mkdir $DIRECTORY
fi

# make a directory for stringtie/alignment
DIRECTORY=$DIRECTORY$ALIGNER
if [ ! -d "$DIRECTORY" ]; then
    echo "making directory "$DIRECTORY
    mkdir $DIRECTORY
fi

# submit jobs for all aligned.bam files in DATA directory
for i in $DATA*Aligned.sortedByCoord.out.bam; do 
    NAME=${i%Aligned.sortedByCoord.out.bam}
    NAME=${NAME##*/}
        
    #if [ ! -d "$DIRECTORY$NAME" ]; then
	# echo "making directory "$DIRECTORY$NAME
	# mkdir $DIRECTORY$NAME
    #fi
    
    sbatch batch_stringtie_assemble.sh $i $ANNOTATION $DIRECTORY$NAME
done

