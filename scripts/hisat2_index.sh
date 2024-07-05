#!/usr/bin/env bash
#SBATCH -J hisat2
#SBATCH --partition=short
#SBATCH --mem=2G
#SBATCH --cpus-per-task=2

Genome=$1
OutDir=$2

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda
source ${MYCONDAPATH}/bin/activate rna-seq

Prefix=$(basename $Genome .fasta)

hisat2-build $Genome $OutDir/$Prefix

