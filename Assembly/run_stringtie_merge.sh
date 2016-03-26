#!/bin/bash
#
# filename: run_stringtie_merge.sh
# summary: wrapper script to run a batch job for batch_stringtie_merge.sh
#       which is a StringTie transcript merge to combine gtf files
#       <path_to_aligned_sorted_bam> <path_to_annotation_genome> 
#       <output_name>

# inputs
DATA="/n/regal/eddy_lab/pkoo/opticlobe/assembly/stringtie/"
ANNOTATION="/n/regal/eddy_lab/pkoo/opticlobe/reference_annotation/dm6_Ensembl.gtf"

# make a directory for stringtie/alignment
DIRECTORY=$DATA"merge/"
if [ ! -d "$DIRECTORY" ]; then
    echo "making directory "$DIRECTORY
    mkdir $DIRECTORY
fi

ls $DATA*.gtf > $DIRECTORY"gtf_list.txt"

# submit batch file to merge all gtf files
sbatch batch_stringtie_merge.sh $DATA"gtf_list.txt" $ANNOTATION $DIRECTORY
