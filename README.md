# H4 GRF-GIF RNA-seq Analysis
Analysis of RNA-seq data from F. vesca Hawaii 4 GRF-GIF transformations.

## Key
<table>
    <tr><th>Construct</th><th>Condition</th></tr>
    <tr><td>pK7WG2D</td><td>Control</td></tr> 
    <tr><td>p553</td><td>Ta GRF-GIF</td></tr> 
    <tr><td>p630</td><td>Vv GRF-GIF</td></tr> 
    <tr><td>p689</td><td>Cc GRF-GIF</td></tr> 
    <tr><td>p638</td><td>Vv miR GRF-GIF</td></tr>
</table>

## Quality Control
FastQC
```
for file in *.fq.gz; 
    do sbatch ../scripts/fastqc.sh $file
    done
```
Trimmomatic (ILLUMINACLIP, HEADCROP:10, SLIDINGWINDOW:4:20, MINLEN:140)
```
for file in ../raw/*_1.fq.gz; 
    do file2=$(ls $file | sed s/"_1.fq.gz"//g)
    sbatch ../scripts/trimmomatic_pe.sh $file "$file2"_2.fq.gz
    done
```
## Align reads and quantify
Index genome
```
sbatch hisat2_index Fragaria_vesca_v4.0.a1.fasta genome_index/
```

Align reads
```
for file in ../trimmed/*F_paired.fastq.gz; 
    do file2=$(ls $file | sed s/"F_paired.fastq.gz"//g)
    sbatch ../scripts/hisat2_pe-map.sh ../genome_index/Fragaria_vesca_v4.0.a1 $file "$file2"R_paired.fastq.gz
    done
```

Count
```
for file in ../mapping/*bam;
    do sbatch featurecounts.sh $file ../Fragaria_vesca_v4.0.a2.genes.gff3
    done
```
