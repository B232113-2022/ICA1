#!/bin/bash/


FASTQC_PATH="./fastqc_outputs/"
RESULT="$FASTQC_PATH*_fastqc/summary.txt"

echo -e "fastqc_file_name\tPASS\tWARN\tFAIL" > assessment.txt

paste <(ls -d1 $FASTQC_PATH*_fastqc | xargs -n 1 basename) <(grep -c 'PASS' $RESULT | cut -d ':' -f 2) <(grep -c 'WARN' $RESULT | cut -d ':' -f 2) <(grep -c 'FAIL' $RESULT | cut -d ':' -f 2) >> assessment.txt

