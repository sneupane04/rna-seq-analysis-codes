#!/bin/bash
#SBATCH --job-name=STAR
#SBATCH --mail-user=surendra.neupane@moffitt.org
#SBATCH --mail-type=END,FAIL
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=64gb
#SBATCH --time=24:00:00
#SBATCH -o %x-%j.out
#SBATCH -e  %x-%j.err


date;hostname;pwd


#Edit the following lines
module load STAR/2.7.7a-GCC-10.2.0

# define variables
index=/share/lab_padron/Surendra/OG7634-677487034/rawfastq/STAR_gencode
# get our data files
FQ_DIR=/share/lab_padron/Surendra/OG7634-677487034/rawfastq/rawfastq/remaining_STAR_align

for sample in $FQ_DIR/*_R1_trimmed.fastq.gz
do
        base=$(basename $sample "_R1_trimmed.fastq.gz")

  # define R1 fastq filename
  fq1=$FQ_DIR/${base}_R1_trimmed.fastq.gz

 # define R2 fastq filename
  fq2=$FQ_DIR/${base}_R2_trimmed.fastq.gz

 # align with STAR
 STAR --runThreadN 4 --genomeDir $index -sjdbGTFfile /share/lab_padron/Surendra/OG7634-677487034/rawfastq/gencode.v44.annotation.gtf --readFilesIn $fq1 $fq2 --outSAMtype BAM SortedByCoordinate --twopassMode Basic --outSAMattrIHstart 0 --quantMode GeneCounts --outReadsUnmapped Fastx --readFilesCommand gunzip -c --outFileNamePrefix $base"_"
done

echo "done!"
