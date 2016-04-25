#!/bin/bash
#
# filename: batch_stringtie_assemble.sh
# summary: run the StringTie transcript assembly with arguments: 
#	<path_to_reference_genome> <path_to_annotation_genome> 
#	<output_name>
# example: sbatch run_stringtie_assemble.sh $ALIGN $ANNOTATION $OUTPUT
#
#SBATCH -J StringTie			# job name
#SBATCH -p serial_requeue        	# partition (general,serial_requeue)
#SBATCH -n 4                            # number of cores
#SBATCH -N 1                            # number of nodes
#SBATCH --mem 8000                	# memory pool for all cores
#SBATCH -t 0-1:30                       # time (D-HH:MM)
#SBATCH -o log/stringtie_%A.out   	# STDOUT
#SBATCH -e log/stringtie_%A.err     	# STDERR
#SBATCH --mail-type=FAIL 		# notifications (END,FAIL,ALL)
#SBATCH --mail-user=peter_koo@harvard.edu     # send-to address

# load modules 
source new-modules.sh

# perform transcript assembly 
stringtie \
$1 \
-G $2 \
-o $3.gtf \
-f 0.1 \
-p 8 \
-B
