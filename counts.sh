#!usr/bin/bash

BED="./Tcongo_genome/TriTrypDB-46_TcongolenseIL3000_2019.bed"
BAM_PATH="./bam_outputs/"
OUTPUT_PATH="./"
INDEX="./Tcongo_genome/Tcongo"

mkdir -p $OUTPUT_PATH

BAM_LIST=$(ls $BAM_PATH*.bam)
bedtools multicov -bams $BAM_LIST -bed $BED > bed_reads_$(basename $INDEX)

awk -f count_reads.awk count_$(basename $INDEX).txt > read_counts_per_gene.txt
