



#sam 2 bam conversion and sam sorting by coordinate

for B in *.sam; do
    N=$(basename $B .sam) ;
    samtools view --threads 8 -bS $B | samtools sort -O BAM -o $N.bam ;
done


#index all bam files in dir

for b in *.bam; do
	samtools index $b;
done


#retrieve stats on all bam files in dir
for B in *.bam; do
    N=$(basename $B .bam) ;
    samtools stats $B > $N.txt ;
done