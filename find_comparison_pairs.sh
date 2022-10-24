#!usr/bin/bash

IFS="\t"
INPUT="groups_names"
OUTPUT="comparison_pairs"

> $OUTPUT

COUNTER1=1
while IFS='_' read -r TYPE1 HOUR1 INDUCE1
do
  COUNTER1+=1
  COUNTER2=0
  while IFS='_' read -r TYPE2 HOUR2 INDUCE2
  do
    COUNTER2+=1
    if (( $COUNTER1 != $COUNTER2 )); then
      x=1; [ "$TYPE1" == "$TYPE2" ] && x=0
      y=1; [ "$HOUR1" == "$HOUR2" ] && y=0
      z=1; [ "$INDUCE1" == "$INDUCE2" ] && z=0
      CHECK_DIFF=$(( $x + $y + $z ))

        if (( $CHECK_DIFF == 1 )); then
          PAIR1="${TYPE1}_${HOUR1}_${INDUCE1}"
          PAIR2="${TYPE2}_${HOUR2}_${INDUCE2}"
          echo -e $PAIR1"\t"$PAIR2 >> $OUTPUT
        fi
    fi
  done < $INPUT
done < $INPUT
