#!/bin/bash
#SBATCH --job-name=hisat2
#SBATCH --mail-user=surendra.neupane@moffitt.org
#SBATCH --mail-type=END,FAIL
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=64gb
#SBATCH --time=24:00:00
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

date;hostname;pwd

# Load modules
ml load HISAT2/2.2.1-foss-2020a
ml load SAMtools/1.15.1-GCC-11.3.0

# Array of sample names
declare -a samples=("WT2" "WT4" "MOE2" "MOE3" "MOE4" "MOE5" "TK159" "TK166" "TK167" "TK168" "TKM163" "TKM176" "TKM185" "WT6" "WT7" "WT8" "WT9" "TK175" "TK178")

# Loop over each sample
for sample in "${samples[@]}"; do
    # Build file names
    r1="S${sample}_11072022_S${sample}_ME_L001_R1.fastq.gz"
    r2="S${sample}_11072022_S${sample}_ME_L001_R2.fastq.gz"
    bam="${sample}.bam"

    # Run hisat2 and pipe to samtools
    hisat2 -x Mus_musculus_hisat2.idx -1 "$r1" -2 "$r2" | samtools view -bSh > "$bam"
done
