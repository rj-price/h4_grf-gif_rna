#!/usr/bin/env bash
#SBATCH -J hisat2
#SBATCH --partition=short
#SBATCH --mem=2G
#SBATCH --cpus-per-task=2

# genome = $1
# out dir = $2

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda
source ${MYCONDAPATH}/bin/activate rna-seq

fileshort=$(basename $1 .fasta)

hisat2-build $1 $2/$fileshort

