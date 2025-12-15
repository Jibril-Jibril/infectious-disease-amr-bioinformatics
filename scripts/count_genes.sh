#!/bin/bash

for f in data/*.fasta
do
  echo -n "$f: "
  grep ">" $f | wc -l
done
