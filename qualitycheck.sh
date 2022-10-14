#!/bin/bash

RAWDATA_PATH="./rawdata/"
FASTQC_PATH="./fastqc_outputs/"

pigz -d $RAWDATA_PATH*.gz

for FILE in $RAWDATA_PATH*.fq
do 
  FASTQ=${FILE/$RAWDATA_PATH/}
  FASTQC=${FASTQ/.fq/_fastqc.zip}
    
  if ! [ -f "$FASTQC_PATH$FASTQC" ] ; then
    fastqc -o $FASTQC_PATH ${FILE} &
  fi
done

unzip "$FASTQC_PATH*.zip" -d $FASTQC_PATH
rm -rf $FASTQC_PATH*.zip
