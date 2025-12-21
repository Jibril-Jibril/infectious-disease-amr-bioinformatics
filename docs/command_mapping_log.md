## Day 7 — Read mapping with bwa and SAM interpretation

#- Create toy reference FASTA (geneA, geneB)
mkdir -p data/reference
nano data/reference/ref.fasta

#- Index reference using bwa index
bwa index data/reference/ref.fasta

#- Create toy FASTQ reads
mkdir -p data/fastq
nano data/fastq/sample_R1.fastq

#- Ran bwa mem for read mapping
mkdir -p results/mapping
bwa mem data/reference/ref.fasta data/fastq/sample_R1.fastq > results/mapping/sample.sam

#- Interprete SAM output
head results/mapping/sample.sam

#- Convert SAM → BAM (compressed)
samtools view -bS results/mapping/sample.sam > results/mapping/sample.bam

#- Sort the BAM file
samtools sort results/mapping/sample.bam -o results/mapping/sample.sorted.bam

#- Index the BAM file
samtools index results/mapping/sample.sorted.bam

##- Inspect alignments (practical checks)
#- How many reads mapped?
samtools view -c results/mapping/sample.sorted.bam

#- View alignments with reference names
samtools view results/mapping/sample.sorted.bam


#- Identified unmapped reads (FLAG 4) due to short read length

## Day 8 — Coverage, depth, and AMR evidence thresholds
#- Defined read depth and gene coverage
grep -v "^@" results/mapping/sample.sam | awk '$2 != 4' | wc -l

#- Interpreted mapping evidence from SAM files

- Reasoned about coverage thresholds in AMR detection

#- Estimated coverage manually and using awk
grep -v "^@" results/mapping/sample.sam \
| awk '$2 != 4 {gsub(/M/, "", $6); sum += $6} END {print sum}'

- Understood limitations of naive CIGAR-based coverage

## Assembly vs mapping for AMR detection and variant reasoning
- Why assembly improves gene-based AMR detection
- Why mapping is essential for SNP and low-frequency variants
- How real AMR pipelines combine both approaches
