#!/bin/bash
#SBATCH --job-name=htseq
#SBATCH --mail-user=surendra.neupane@moffitt.org
#SBATCH --mail-type=END,FAIL
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=64gb
#SBATCH --time=24:00:00
#SBATCH -o %x-%j.out
#SBATCH -e  %x-%j.err

date;hostname;pwd


#Edit the following line

ml load HTSeq/0.11.2-foss-2019b-Python-3.7.4

ml load SAMtools/1.15.1-GCC-11.3.0


for sample in `ls /share/lab_padron/Surendra/OG7634-677487034/rawfastq/rawfastq/cutadapt/*.bam`
do
       base=$(basename $sample ".bam")

htseq-count -f bam -s reverse -m union /share/lab_padron/Surendra/OG7634-677487034/rawfastq/rawfastq/cutadapt/${base}.bam /share/lab_padron/Surendra/OG7634-677487034/rawfastq/gencode.v44.annotation.gtf > ${base}_counts.tsv
done
