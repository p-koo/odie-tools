#!/bin/bash
#
# filename: batch_stringtie_merge.sh
# summary: run the StringTie merge gtf files with arguments: 
#	<path_to_gtf_list> <path_to_annotation_genome> 
#	<output_name>
# example: sbatch run_stringtie_merge.sh $GTFLIST $ANNOTATION $OUTPUT
#
#SBATCH -J Stringtie_merge			# job name
#SBATCH -p serial_requeue        	# partition (general,serial_requeue)
#SBATCH -n 8                           # number of cores
#SBATCH -N 1                            # number of nodes
#SBATCH --mem 8000                	# memory pool for all cores
#SBATCH -t 0-1:00                       # time (D-HH:MM)
#SBATCH -o log/stringtie_merge_%A.out   	# STDOUT
#SBATCH -e log/stringtie_merge_%A.err     	# STDERR
#SBATCH --mail-type=FAIL 		# notifications (END,FAIL,ALL)
#SBATCH --mail-user=peter_koo@harvard.edu     # send-to address

# load modules 
source new-modules.sh

# perform transcript assembly 
stringtie \
--merge \
-l "merged" \
-G $2 \
-o $3.gtf \
-m 50 \
-c 0 \
-F 0 \
-T 0 \
$1

