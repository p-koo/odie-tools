
srun -p interact --mem 4000 --pty -n 1 -N 1 -t 0-2:00 /bin/bash

sacct --format user,jobid,ncpus,elapsed,totalcpu,reqmem,maxrss --name BamSortIndex

1. align RNA-seq reads (STAR)
	- run_star_build.sh
	- run_star1pass.sh
	
2. sort+index bam (samtools)
	- run_bamsortindex.sh

3. assemble transcripts (stringtie)
	- run_stringtie_assemble.sh

4. merge assemblies (stringtie)
	- run_stringtie_merge.sh
	- delete first lines of gtf file (i.e. commands)

5. identify skipped exon events 
	wget https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&ved=0ahUKEwi-w_3F5azMAhVEbz4KHaU9DagQFggcMAA&url=http%3A%2F%2Fhgdownload.cse.ucsc.edu%2Fadmin%2Fexe%2Flinux.x86_64%2FgtfToGenePred&usg=AFQjCNEXOvw2e7R-Fq2M7xf0DcJLsVjxpg&bvm=bv.120551593,d.cWw&cad=rja
	chmod +x gtfToGenePred
	pip install gffutils
	easy_install rnaseqlib
	fix bug in rnaseqlib/tables.py --> comment #bin

	./gtfToGenePred -genePredExt dm.gtf ensGene.txt
	gff_make_annotation path_to_pred_table output_directory --flanking-rule commonshortest --genome-label dm 


6. build alternative event index
	- run_miso_index.sh
		index_gff.py --index path_to_gff path_to_index_directory

7. calculate psi value for skipped exons
	- run_miso.sh

# calculate psi value (percent spliced-in),
run_events_analysis.py \
--compute-genes-psi \
path_to_index_directory \
path_to_sort_index_bam \
--output-dir path_to_output_directory \
--read-len 100 
#--paired-end 250 99 \
#--event-type=SE

# summarize the results
run_miso.py \
--summarize-samples /mnt/miso-data/4_SE/vg1_005/ 

# compare samples
run_miso.py \
--compare-samples \
path_to_summarized_results_1 \
path_to_summarized_results_2 \
path_to_output_directory

# filter results
filter_events.py \
--filter /mnt/miso-data/4_SE/comparisons/w_006_vs_vg1_005/bayes-factors/w_006_vs_vg1_005.miso_bf \
--num-inc 1 \
--num-exc 1 \
--num-sum-inc-exc 10 \
--delta-psi 0.20 \
--bayes-factor 10 \
--output-dir /mnt/miso-data/4_SE/comparisons/filtered/


# plot the graph from two alternative events
# both graphs will be in sashimi_plot directory
plot.py --plot-event "chr4:848485:848533:-@chr4:844127:844244:-@chr4:823024:823953:-" \
altevents/4_SE/ sashimi_plot_settings.txt  --output-dir sashimi_plot

plot.py --plot-event "chr4:497918:498709:-@chr4:495586:495730:-@chr4:495079:495394:-" \
altevents/4_SE/ sashimi_plot_settings.txt  --output-dir sashimi_plot


or
5. convert merged gtf to gff
	- perl gtf_to_gff.pl dm.gtf > dm.gff

