#!/bin/bash
#
# filename: run_miso_index.sh
# summary: wrapper script to run a batch job for batch_miso_index.sh

# inputs
ASEVENT="/n/regal/eddy_lab/pkoo/opticlobe/reference_asevent/SE.dm.gff3"
OUTPUT="/n/regal/eddy_lab/pkoo/opticlobe/reference_asevent/SE_dm/"
sbatch batch_miso_index.sh $ASEVENT $OUTPUT
