#!/bin/bash
#SBATCH --job-name=cutadapt
#SBATCH --mail-user=surendra.neupane@moffitt.org
#SBATCH --mail-type=END,FAIL
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=100gb
#SBATCH --time=24:00:00
date;hostname;pwd


#Edit the following lines
module load cutadapt/2.10-GCCcore-9.3.0-Python-3.8.2

SAMPLES=(8 2 6 4 7 9 1 5 3)

for i in "${SAMPLES[@]}"; do
    INPUT_R1="/share/lab_padron/Surendra/OG7634-677487034/rawfastq/rawfastq/AACNV7VM5-7634-${i}-66-1_S${i}_L001_R1.fastq.gz"
    INPUT_R2="/share/lab_padron/Surendra/OG7634-677487034/rawfastq/rawfastq/AACNV7VM5-7634-${i}-66-1_S${i}_L001_R2.fastq.gz"
    OUTPUT_R1="/share/lab_padron/Surendra/OG7634-677487034/rawfastq/rawfastq/AACNV7VM5-7634-${i}-66-1_S${i}_L001_R1_trimmed.fastq.gz"
    OUTPUT_R2="/share/lab_padron/Surendra/OG7634-677487034/rawfastq/rawfastq/AACNV7VM5-7634-${i}-66-1_S${i}_L001_R2_trimmed.fastq.gz"
    
    if [[ -e $INPUT_R1 && -e $INPUT_R2 ]]; then
        cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o $OUTPUT_R1 -p $OUTPUT_R2 -m 20 $INPUT_R1 $INPUT_R2
    else
        echo "Files for S${i} are missing!"
    fi
done
