#!usr/bin/bash

GROUPS_INPUT="./groups_columns"
INDEX="./Tcongo_genome/Tcongo"
BED_INPUT="bed_reads_Tcongo"
MEAN_OUTPUT="mean_per_group"


HEADER="GENE_OF_INTEREST\tGENE_DESCRIPTION"

cat $BED_INPUT | head -5

cut -f 4,5 $BED_INPUT > $MEAN_OUTPUT

while IFS=$'\t' read -r GROUP COL
do
  HEADER+="\t"$GROUP

  cut -f $COL $BED_INPUT | \
  awk 'BEGIN{FS="\t"}{sum=0; for (i=1; i<=NF; i++) {sum+=$i;} print sum/NF;}' | \
  paste $MEAN_OUTPUT - > "temp"
  cat "temp" > $MEAN_OUTPUT
done < $GROUPS_INPUT

sed -i "1i $HEADER" $MEAN_OUTPUT
rm -rf "temp"
