#!/bin/bash
#SBATCH --job-name=Trimmomatic
#SBATCH --mail-user=surendra.neupane@moffitt.org
#SBATCH --mail-type=END,FAIL
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=100gb
#SBATCH --time=24:00:00
date;hostname;pwd


#Edit the following lines
module load Trimmomatic/0.39-Java-1.8

for i in *_R1.fastq.gz
do
sample=`echo $i | awk -F "_R1"  '{print $1}'`
sample_name=`echo $i | awk -F "_R1"  '{print $1}'`
extension=`echo $i | awk -F "_R1"  '{print $2}'`
R1=${sample_name}_R1${extension}
R2=${sample_name}_R2${extension}
R1_pair=${sample}_R1_pair${extension}
R1_unpair=${sample}_R1_unpair${extension}
R2_pair=${sample}_R2_pair${extension}
R2_unpair=${sample}_R2_unpair${extension}
echo -e "\n${yellow}[Running trimmomatic for sample] ${sample_name}\n"
date && time
trimmomatic \
PE \
-threads 40 \
-phred33 $R1 $R2 $R1_pair $R1_unpair $R2_pair $R2_unpair \
HEADCROP:10 \
ILLUMINACLIP:/share/lab_padron/CICPT_4094_RNASeq/FASTQ_Files/adapters.fasta:2:40:15:8:true \
LEADING:5 \
TRAILING:5 \
 SLIDINGWINDOW:4:5 \
 MINLEN:25
done
