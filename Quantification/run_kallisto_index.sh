#!/bin/bash
#
# filename: run_kallisto_index.sh
# summary: runs Kallisto to build an index of the transcriptome 
#
#SBATCH -J Kallisto-index              	# job name
#SBATCH -p serial_requeue               # partition (general,serial_requeue)
#SBATCH -n 4                            # number of cores
#SBATCH -N 1                            # number of nodes
#SBATCH --mem 12000                     # memory pool for all cores
#SBATCH -t 0-1:00                       # time (D-HH:MM)
#SBATCH -o log/kallisto_index_%A.out    # STDOUT
#SBATCH -e log/kallisto_index_%A.err    # STDERR
#SBATCH --mail-type=FAIL                # notifications (END,FAIL,ALL)
#SBATCH --mail-user=peter_koo@harvard.edu     # send-to address

# load modules
source new-modules.sh
module load gcc openmpi kallisto

# make a reference transcriptome directory if doesn’t exist
DIRECTORY="/n/regal/eddy_lab/pkoo/opticlobe/reference_transcriptome/"
if [ ! -d "$DIRECTORY" ]; then
    mkdir $DIRECTORY
fi

# inputs
TRANSCRIPTOME="/n/regal/eddy_lab/pkoo/opticlobe/reference_transcriptome/Drosophila_melanogaster.BDGP6.rel79.cdna.all.fa.gz"
INDEX=$DIRECTORY"dm6_transcripts.idx"

# build transcriptome index
kallisto index -i $INDEX $TRANSCRIPTOME


