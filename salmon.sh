#!/bin/bash
#SBATCH --job-name=salmon
#SBATCH --mail-user=surendra.neupane@moffitt.org
#SBATCH --mail-type=END,FAIL
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=64gb
#SBATCH --time=24:00:00
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

date;hostname;pwd

# Load required module
ml load Salmon/1.4.0-GCC-11.2.0

# define variables
index=/share/lab_padron/Surendra/OG7634-677487034/rawfastq/gencodev44_indexk15

# get our data files
FQ_DIR=/share/lab_padron/Surendra/OG7634-677487034/rawfastq/rawfastq/cutadapt

# Adjust this loop to process files in the format you've shown
for i in {1..24}
do
    # Construct base name
    base="AACNV7VM5-7634-${i}-66-1_S${i}_L001"

    # Define R1 and R2 fastq filenames
    fq1=$FQ_DIR/${base}_R1_trimmed.fastq.gz
    fq2=$FQ_DIR/${base}_R2_trimmed.fastq.gz

    # run salmon
    salmon quant --index $index --libType IU --mates1 $fq1 --mates2 $fq2 -g /share/lab_padron/Surendra/OG7634-677487034/rawfastq/gencode.v44.annotation.gtf --output $base.salmon --seqBias --useVBOpt --numBootstraps 30 --validateMappings --minScoreFraction 0.1
done

