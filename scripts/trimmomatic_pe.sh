#!/usr/bin/env bash
#SBATCH -J trimmomatic
#SBATCH --partition=medium
#SBATCH --mem=1G
#SBATCH --cpus-per-task=4

F_reads=$1 
R_reads=$2

ln -s $F_reads
ln -s $R_reads

F_symlink=$(basename $F_reads)
R_symlink=$(basename $R_reads)
Prefix=$(basename $F_reads _1.fq.gz)

trimmomatic PE -threads 8 -phred33 $F_symlink $R_symlink \
    "$Prefix"_F_paired.fastq.gz \
    "$Prefix"_F_unpaired.fastq.gz \
    "$Prefix"_R_paired.fastq.gz \
    "$Prefix"_R_unpaired.fastq.gz \
    ILLUMINACLIP:TruSeq3-PE.fa:2:30:10:2:keepBothReads LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 HEADCROP:10 MINLEN:100
