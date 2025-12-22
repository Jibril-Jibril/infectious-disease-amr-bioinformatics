# Day 13: AMR Mini-Project — Vibrio species from aquaculture

## Research Question
What resistance determinants are present in aquaculture-associated Vibrio species?

## Pipeline Overview
1. QC: fastp
2. Assembly: SPAdes
3. Gene AMR: CARD + ResFinder
4. SNP AMR (optional): PointFinder / mapping
5. Interpretation: coverage ≥90%, identity ≥95%, depth ≥10×
6. Documentation: this file

## Interpretation Rules
- Full-length genes meeting thresholds → High confidence
- Partial or truncated genes → Low confidence / putative
- SNP-based variants → Only considered if mapping supports ≥10× coverage
