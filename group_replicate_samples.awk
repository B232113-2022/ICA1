#!/usr/bin/awk -f

BEGIN {
FS="\t"; OFS="_";
}


{
if (NR != 1) {
  groups_columns[$2OFS$4OFS$5] = groups_columns[$2OFS$4OFS$5] ? groups_columns[$2OFS$4OFS$5] "," (NR + 4) : (NR + 4)
  groups_samples[$2OFS$4OFS$5] = groups_samples[$2OFS$4OFS$5] ? groups_samples[$2OFS$4OFS$5] "," $1 : $1

  }
}


END {
for (key in groups_columns) {
  print key "\t" groups_columns[key] > "groups_columns";
  print key "\t" groups_samples[key] > "groups_samples";
  print key > "groups_names" ;
  }
}
