
srun -p interact --mem 4000 --pty -n 1 -N 1 -t 0-6:00 /bin/bash


1. STAR --> build --> align
2. samtools - sort --> index bam
3. StringTie assemble

cuffmerge assemblies:


Convert gtf to gff:
perl gtf_to_gff.pl corrected.gtf > corrected.gff

AltEventFinder:

wget http://watson.compbio.iupui.edu/aozhou/alt_event_finder_files/AltEventFinder_v0.1.tar.gz
Usagecd
For CufflinksFormat.gtf, run the following command:
	alt_event_finder --cufflinks CufflinksFormat.gtf CufflinksFormat
For ScriptureFormat.segments, run the following command:
	alt_event_finder --scripture ScriptureFormat.segments ScriptureFormat

MISO:

# build alternative event index:
index_gff.py --index path_to_gff path_to_index_directory

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