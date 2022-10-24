#!usr/bin/bash

RAWDATA_PATH="./rawdata/"
THREAD=128
INDEX="./Tcongo_genome/Tcongo"
OUTPUT_PATH="./bam_outputs/"

mkdir -p $OUTPUT_PATH

for READ1 in $RAWDATA_PATH*_1.fq
do
  READ1_FILE=$(basename $READ1)
  ALIGNMENT=${READ1_FILE/1.fq/aligned} 
  FAIL_COUNT=$(grep -w ${READ1_FILE/.fq/_fastqc} ./assessment.txt | cut -f 4,4)
  
  # Only proceed with sequences that have less than 3 FAILs in FASTQC
  if (($FAIL_COUNT < 3)); then
    bowtie2 --no-unal -p $THREAD -x $INDEX -1 $READ1 -2 ${READ1/_1/_2} | \
    samtools view -Sb - | \
    samtools sort - -o $OUTPUT_PATH$ALIGNMENT.bam
    samtools index $OUTPUT_PATH$ALIGNMENT.bam  
  fi
done
