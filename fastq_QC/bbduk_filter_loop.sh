#this script uses bbduk, a function of bbmap, to trim and filter reads aligning with the rRNA data base named ribokmers.fa
#this will output filtered and trimmed reads, as well as a QC report of which reads align to the ribokmers db

#all you have to do is place this script in the directory with the reads, and change the paths for out1 and out2

module load bbmap

#!/bin/bash


for i in `ls -1 *R1_001.fastq.gz | sed 's/R1_001.fastq.gz//'`
do
bbduk.sh -Xmx1g in1=${i}R1_001.fastq.gz in2=${i}R2_001.fastq.gz out1=${i}_clean_R1_001.fastq.gz out2=${i}_clean_R2_001.fastq.gz ref=/data/databases/rrna_silva/ribokmers.fa ktrim=r k=31 refstats=$i.txt;
done > cat_stats.txt
