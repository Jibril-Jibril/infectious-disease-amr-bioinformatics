# Bioinformatics Learning Log

## Session 1 2025-12-13
- Set up WSL and GitHub
- Created first bioinformatics repository
- Learned basic Linux navigation

## Session 2 2025-12-13
- Learned to view large files with less, head and tail
- Used grep to search FASTA files
	-i for case insensitive search
	-v for invert match → select lines that do not contain specified character>
- Used pipes to combine commands

## Session 3 2025-12-14
- Used cut to extract columns from tabular files
- Used sort and uniq to summarise annotations
- Counted AMR-associated genes from annotation data

## 2025-12-15
- Learned to use variables and loops in Bash
- Automated gene counting across multiple FASTA files
- Wrote my first reusable bioinformatics script

## Day 5 Part B – QC and trimming logic
- Defined QC rules (length & quality)
- Used awk to simulate read filtering
- Understood why QC tools are necessary

## Day 7 Part B — Read mapping and SAM/BAM
- Created toy reference FASTA
- Indexed reference with bwa
- Created toy FASTQ reads
- Mapped reads using bwa mem
- Converted SAM to sorted/indexed BAM
- Inspected alignments and mapping quality
- Identified unmapped reads (FLAG 4) due to short read length

## Day 9 Assembly vs mapping for AMR detection and variant reasoning
Why assembly improves gene-based AMR detection
Why mapping is essential for SNP and low-frequency variants
How real AMR pipelines combine both approaches

## Day 10 AMR tools, evidence thresholds, and interpretation
Understand why thresholds exist
Can justify tool choice
Can defend discrepancies between tools
Think like a reviewer, not just a user
