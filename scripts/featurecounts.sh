#!/usr/bin/env bash
#SBATCH -J featurecounts
#SBATCH --partition=medium
#SBATCH --mem=500M
#SBATCH --cpus-per-task=4

SortedBAM=$1
Transcriptome=$2

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda
source ${MYCONDAPATH}/bin/activate rna-seq

Prefix=$(basename $SortedBAM .sorted.bam)

featureCounts -T 4 -g Parent -a $Transcriptome -o "$Prefix".txt $SortedBAM

