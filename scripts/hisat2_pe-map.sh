#!/usr/bin/env bash
#SBATCH -J hisat2
#SBATCH --partition=medium
#SBATCH --mem=14G
#SBATCH --cpus-per-task=8

IndexDir=$1
F_reads=$2
R_reads=$3

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda
source ${MYCONDAPATH}/bin/activate rna-seq

Prefix=$(basename $F_reads _F_paired.fastq.gz)

hisat2 -p 16 -x $IndexDir -1 $F_reads -2 $R_reads -S "$Prefix".sam --summary-file "$Prefix".summary

samtools sort -@ 16 -o "$Prefix".sorted.bam "$Prefix".sam

rm "$Prefix".sam
