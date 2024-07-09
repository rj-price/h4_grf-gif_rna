#!/usr/bin/env bash
#SBATCH -J InterProScan
#SBATCH --partition=medium
#SBATCH --mem=20G
#SBATCH --cpus-per-task=8

# Assign all available (default) InterProScan terms and GO terms to genes in a proteome file

Proteome=$1

# Change '*' STOP to 'X' STOP:
sed -i -r 's/\*/X/g' $Proteome

/mnt/shared/scratch/jnprice/apps/interproscan/interproscan-5.65-97.0/interproscan.sh \
    -i $Proteome \
    -goterms \
    -cpu 16 -dp -f tsv