#!/bin/bash

# Directory with FASTQ files
FASTQ_DIR=data/fastq

for f in $FASTQ_DIR/*.fastq
do
  echo "Processing $f"

  # Simulate QC rules
  awk '
  NR%4==2 {seq=$0; len=length($0)}
  NR%4==0 {
    qual=$0
    if (len >= 10 && qual !~ /!/) print "KEEP"
    else print "DROP"
  }' "$f"
done
