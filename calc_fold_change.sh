#!usr/bin/bash

IFS=$'\t'
PAIR_INPUT="comparison_pairs"
MEAN_INPUT="mean_per_group"
BED_INPUT="bed_reads_Tcongo"
OUTPUT_DIR="./fold_changes_per_pair/"

mkdir -p $OUTPUT_DIR

while IFS=$'\t' read -r PAIR1 PAIR2
do
  FOLD_OUTPUT="fold_changes_"$PAIR1"_and_"$PAIR2
  cut -f 4,5 $BED_INPUT > $OUTPUT_DIR$FOLD_OUTPUT

  awk -v p1=$PAIR1 -v p2=$PAIR2 'BEGIN{FS="\t"} FNR==1{for (i=1; i<=NF; i++) {col[$i]=i;} ; next}{{ $(col[p1]) = ($(col[p1]) == 0 ? 1 : $(col[p1])) } { $(col[p2]) = ($(col[p2]) == 0 ? 1 : $(col[p2])) } fold=$(col[p1])/$(col[p2])-1; print fold < 0 ? -fold : fold;}' $MEAN_INPUT | \
  paste $OUTPUT_DIR$FOLD_OUTPUT - > "temp"
  cat "temp" > $OUTPUT_DIR$FOLD_OUTPUT

  sort -t $'\t' -k 3,3 -nro $OUTPUT_DIR$FOLD_OUTPUT $OUTPUT_DIR$FOLD_OUTPUT
done < $PAIR_INPUT

rm -rf "temp"
