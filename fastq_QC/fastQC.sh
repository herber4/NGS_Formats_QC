#here is a loop for fastqc on all fastq files

1. conda install -c bioconda fastqc


#!/bin/bash

2.

for f in *.fastq.gz; do
    fastqc -t 8 --extract $f ;
done


#multiQC

1. conda install -c bioconda multiqc

2. multiqc .

3. open multiqc.html output