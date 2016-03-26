#!/bin/bash
#
# filename: batch_tophat.sh
# summary: runs the TopHat aligner with arguments:
#	 <path_to_fastq> <path_to_reference_genome> 
#	<path_to_annotation_genome> <output_directory>
# example: sbatch run_tophat.sh $DATA $GENOME $ANNOTATION $OUTPUT
#
#SBATCH -J TopHat2			# job name
#SBATCH -p serial_requeue        	# partition (general,serial_requeue)
#SBATCH -n 24                           # number of cores
#SBATCH -N 1                            # number of nodes
#SBATCH --mem 12000                	# memory pool for all cores
#SBATCH -t 0-11:00                       # time (D-HH:MM)
#SBATCH -o log/tophat_%A.out   		# STDOUT
#SBATCH -e log/tophat_%A.err     	# STDERR
#SBATCH --mail-type=FAIL		# notifications (END,FAIL,ALL)
#SBATCH --mail-user=peter_koo@harvard.edu     # send-to address

# load modules
source new-modules.sh
module load tophat/2.0.13-fasrc02

#perform alignment to reference genome
tophat2 \
-p 24 \
-G $3 \
-o $4 \
$2 \
$1
