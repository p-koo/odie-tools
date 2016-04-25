#!/bin/bash
#
# filename: batch_cuffmerge.sh
# summary: run the cuffmerge to merge gtf files together with arguments: 
#	<path_to_gtf_list> <path_to_annotation_genome> 
#	<output_name>
# example: sbatch run_cuffmerge.sh $GTFLIST $ANNOTATION $OUTPUT
#
#SBATCH -J Cuffmerge 				# job name
#SBATCH -p serial_requeue        	# partition (general,serial_requeue)
#SBATCH -n 12                            # number of cores
#SBATCH -N 1                            # number of nodes
#SBATCH --mem 8000                	# memory pool for all cores
#SBATCH -t 0-8:00                       # time (D-HH:MM)
#SBATCH -o log/cuffmerge_%A.out   	# STDOUT
#SBATCH -e log/cuffmerge_%A.err     	# STDERR
#SBATCH --mail-type=FAIL 		# notifications (END,FAIL,ALL)
#SBATCH --mail-user=peter_koo@harvard.edu     # send-to address

# load modules 
source new-modules.sh
module load cufflinks/2.2.1-fasrc01

# perform transcript assembly 
cuffmerge \
-g $2 \
-s $3 \
-p 12 \
$1
