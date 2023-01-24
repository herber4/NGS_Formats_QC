#extract exons, and splice sites from GTF

hisat2_extract_splice_sites.py gencode.v38.annotation.gtf > splicesites.tsv

hisat2_extract_exons.py gencode.v38.annotation.gtf > exons.tsv

#index genome - it is recommended to run this on 24 threads, it will still take several hours  if not, expect to wait over a day or so on less threads
hisat2-build -p 24 --ss /data/lackey_lab/austin/hisat_index/splicesites.tsv --ex
on /data/lackey_lab/austin/hisat_index/exons.tsv GRCh38.primary_assembly.genome.
fa hisat_index

#now you can do alignments feeding in raw fq or trimmed fq

for i in `ls -1 *_R1_001.fastq.gz | sed 's/_R1_001.fastq.gz//'`
do
hisat2 -p 16 --qc-filter -x /data/lackey_lab/austin/dbs/hisat_index/hisat_index
-1 ${i}_R1_001.fastq.gz -2 ${i}_R2_001.fastq.gz -S ${i}.sam
done

#now you will have .sam formats and you need to convert to bam, sort by coordinate and index the bam file

#convert to bam, pipe into sorting
for B in *.sam; do
    N=$(basename $B .sam) ;
    samtools view --threads 8 -bS $B | samtools sort -O BAM -o $N.bam ;
done

#index bam file
for b in *.bam; do
    samtools index $b;
done

#generate stat file on statistics
for B in *.bam; do
    N=$(basename $B .bam) ;
    samtools stats $B > $N.txt ;
done

#cat loop for combining alignment statists for each sample
#this will generate a txt file combining per sample stats that can be exported into excel for analysis
for t in *.txt; do
    grep ^SN $t | cut -f 2-;
done > combined_samstats.txt


