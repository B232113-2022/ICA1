#!usr/bin/bash

# Preparing the initial files in a specified directory
cp -r /localdisk/data/BPSM/ICA1/fastq/ ./rawdata/
cp -r /localdisk/data/BPSM/ICA1/Tcongo_genome/ ./Tcongo_genome/
cp -r /localdisk/data/BPSM/ICA1/TriTrypDB-46_TcongolenseIL3000_2019.bed ./Tcongo_genome/

# STEP 1: Performing a quality check on the gzip compressed fastq file
bash qualitycheck.sh

# STEP 2: Assessing the quality of the raw sequence data
bash assess.sh

# STEP 3-1: Preparing the genome sequence for bowtie2 usage as an index
gunzip Tcongo_genome/TriTrypDB-46_TcongolenseIL3000_2019_Genome.fasta.gz
bowtie2-build ./Tcongo_genome/TriTrypDB-46_TcongolenseIL3000_2019_Genome.fasta ./Tcongo_genome/Tcongo

# STEP 3-2: Aligning the read pairs to the Trypanosoma congolense genome using bowtie2
bash align.sh

# STEP 4: Generating counts of reads that align to a gene of interest
chmod 755 count_reads.awk
bash counts.sh    # makes use of the "count_reads.awk" file

# STEP 5: Generating expression levels for each group along with corresponding gene descriptions
chmod 755 group_replicate_samples.awk
awk -f group_replicate_samples.awk < ./rawdata/Tco.fqfiles
bash generate_means.sh

# STEP 5: Generating fold change data for all possible pair-wise comparisons of this experiment
bash find_comparison_pairs.sh   # generates all possible pair combinations, as the denomitator is different for the same pair of a reversed order, I also included them.
bash calc_fold_change.sh        # generates all pair-wise comparisons in the "fold_changes_per_pair" directory
