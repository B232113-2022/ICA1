#!/usr/bin/awk -f

BEGIN {
FS="\t"; OFS="\t";
}


{
count=0;

for (i=6; i<=NF; i++) {
  if ($i != 0) {
   ++count;
    }
  } 
print $4, count
}


END {
}


