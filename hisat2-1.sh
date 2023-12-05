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

# Loop over R1 fastq files
for r1_file in *_R1.fastq.gz; do
    # Extract sample name based on the R1 filename
    sample_name=$(echo "$r1_file" | sed 's/_R1.fastq.gz//')

    # Corresponding R2 file
    r2_file="${sample_name}_R2.fastq.gz"

    # Output BAM file
    bam_file="${sample_name}.bam"

    # Run hisat2 and pipe to samtools
    hisat2 -x Mus_musculus_hisat2.idx -1 "$r1_file" -2 "$r2_file" | samtools view -bSh > "$bam_file"
done
