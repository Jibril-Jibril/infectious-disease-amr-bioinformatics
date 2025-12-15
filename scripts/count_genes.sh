#!/bin/bash

DATA=data
OUT=results/gene_counts.tsv

echo -e "sample\tgene_count" > "$OUT"

for f in $DATA/*.fasta
do
  SAMPLE=$(basename "$f" .fasta)
  GENES=$(grep ">" "$f" | wc -l)
  echo -e "$SAMPLE\t$GENES" >> "$OUT"
done
