# Linux Bioinformatics Command Log

This file records all Linux and Git commands used so far in the learning journey (Days 1–3). You can keep this as a reference or extend it daily.

---

## Day 1 – Linux Basics & Setup

### Navigation & Files

```bash
pwd
ls
ls -lh
cd data
cd ..
cd ~/bioinformatics
touch test_file.txt
cat test_file.txt
echo "Hello bioinformatics" > test_file.txt
echo "Learning Linux is essential" >> test_file.txt
ls -lh test_file.txt
```

### Notes

```bash
nano docs/learning_log.md
```

### Git & GitHub

```bash
git init
git add .
git commit -m "Day 1: Linux basics completed"
git push
```

---

## Day 2 – Viewing & Searching Biological Files

### File Inspection

```bash
less README.md
head README.md
tail README.md
head -n 5 README.md
tail -n 5 README.md
```

### FASTA File Creation

```bash
nano data/example.fasta
less data/example.fasta
```

### Searching with grep

```bash
grep ">" data/example.fasta
grep "gene_1" data/example.fasta
grep -i "GENE" data/example.fasta
```

### Pipes & Counting

```bash
grep ">" data/example.fasta | wc -l
grep -v ">" data/example.fasta | wc -c
```

### Git

```bash
git add .
git commit -m "Day 2: Viewing and searching FASTA files"
git push
```

---

## Day 3 – Summarising AMR Annotation Data

### Create Annotation Table

```bash
nano data/genes.tsv
column -t data/genes.tsv
```

### Extracting & Filtering

```bash
cut -f1,3 data/genes.tsv
grep "AMR" data/genes.tsv
grep "AMR" data/genes.tsv | wc -l
```

### Summaries

```bash
cut -f3 data/genes.tsv | sort | uniq -c
grep "AMR" data/genes.tsv | cut -f2
```

### Save Results

```bash
grep "AMR" data/genes.tsv > results/amr_genes.tsv
cat results/amr_genes.tsv
```

### Git

```bash
git add .
git commit -m "Day 3: Summarising AMR genes from annotation tables"
git push
```

---
### 3️⃣ Personal Linux Cheat Sheet for Bioinformatics

Below is your growing **high‑value command cheat sheet**.

#### File & Directory Navigation

```bash
pwd
ls
ls -lh
cd ..
cd ~
cd ~/bioinformatics
```

#### File Creation & Inspection

```bash
touch file.txt
cat file.txt
less file.txt
head -n 5 file.txt
tail -n 5 file.txt
```

#### Searching & Counting (Core Bioinformatics)

```bash
grep "PATTERN" file
grep -i "pattern" file
grep -v ">" sequences.fasta | wc -c
grep ">" sequences.fasta | wc -l
```

#### Working with Tables & Annotations

```bash
cut -f1,2 file.tsv
sort file | uniq -c
column -t file.tsv
```

#### Pipes & Redirection

```bash
command1 | command2
command > output.txt
command >> output.txt
```

#### Git (Daily Use)

```bash
git status
git add .
git commit -m "message"
git push
git log --oneline
```

---

## How to Use This System (Simple Rule)

* **history** → recall everything
* **command_log.md** → keep what matters
* **GitHub** → permanent professional record

## 15/12/2025 – Variables, loops and automation, and TSV outputs

```bash
GENOME=data/example.fasta
for f in data/sample*.fasta
do
  echo "File: $f"
  grep ">" $f | wc -l
done

for f in data/sample*.fasta
do
  echo -n "$f: " # -n drops the additional line created as part of the echo command forcing the output of the next command to appear on the same line 
  grep ">" $f | wc -l
done > results/gene_counts.txt

chmod +x scripts/count_genes.sh
./scripts/count_genes.sh

--------------------------------
DATA=data
OUT=results/gene_counts.tsv

echo -e "sample\tgene_count" > "$OUT"

for f in $DATA/*.fasta
do
  SAMPLE=$(basename "$f" .fasta)
  GENES=$(grep ">" "$f" | wc -l)
  echo -e "$SAMPLE\t$GENES" >> "$OUT"
done


## Day 5 – FASTQ structure QC simulaton and logic

# calculate number of reads
wc -l data/fastq/sample_R1.fastq | awk '{print $1/4}'

# extract sequences only (2nd line of every read)
sed -n '2p;6p;10p' data/fastq/sample_R1.fastq

# Simulate a QC check: read lengths
awk 'NR%4==2 {print length($0)}' data/fastq/sample_R1.fastq

#Simulate a QC check: see low-quality reads (!)
awk 'NR%4==0 {print}' data/fastq/sample_R1.fastq
#prints line numbers of bad quality lines
awk 'NR%4==0 && /!/ {print NR}' data/fastq/sample_R1.fastq

# Count low-quality reads
awk 'NR%4==0 && $0 ~ /!/ {count++} END {print count}' data/fastq/sample_R1.fastq

# Sanity check FASTQ integrity - print ok if FASTQ file is valid, print BROKEN if it is not
# It is valid if total number of lines is divisible by 4
wc -l data/fastq/sample_R1.fastq | awk '{if ($1 % 4 == 0) print "OK"; else print "BROKEN"}'

# filtering reads (conceptual pipeline)
awk 'NR%4==2 {seq=$0; len=length($0)}
NR%4==0 {qual=$0; if (len>=10 && qual !~ /!/) print "KEEP"; else print "DROP"}' data/fastq/sample_R1.fastq

## Day 6 Part B — FastQC & fastp

# FastQC — Diagnose your reads
mkdir -p results/fastqc
fastqc -o results/fastqc data/fastq/sample_R1.fastq

# Open html file to view report
xdg-open results/fastqc/sample_R1_fastqc.html

# fastp — Automate trimming & filtering
mkdir -p results/fastp
fastp -i data/fastq/sample_R1.fastq \
      -o results/fastp/sample_R1_trimmed.fastq \
      -h results/fastp/sample_R1_fastp_report.html \
      -j results/fastp/sample_R1_fastp_report.json

# Inspect the fastp report
xdg-open results/fastp/sample_R1_fastp_report.html

# Verify QC - run fastqc
fastqc -o results/fastqc results/fastp/sample_R1_trimmed.fastq

# Quality control loop
Raw FASTQ → FastQC → fastp → FastQC
- Ran FastQC to diagnose read quality and adapter content
- Ran fastp to trim low-quality bases and remove adapters
- Verified trimming by running FastQC again
- Observed that reads identified manually on Day 5 as low quality or too short were removed
