#!/bin/sh

#PBS -N star
#PBS -q batch
#PBS -l nodes=1:ppn=9
#PBS -l walltime=10:59:00
#PBS -S /bin/bash

PROJ_DIR=/projects/lu-lab/FOXP1
DATA_DIR=$PROJ_DIR/data/fastq
OUT_DIR=$PROJ_DIR/data/out
TOOL_DIR=/projects/lum/tools

cd $PROJ_DIR/data

# make sub-directories for output 
if [ ! -d $OUT_DIR/INDEX ]; then
	 mkdir -p $OUT_DIR/INDEX
fi

module load STAR/2.5.3
module load samtools/1.3.1

# For each fastq.gz file
#filenames="$(ls $DATA_DIR | grep fastq.gz)"
filenames="$(ls $DATA_DIR | grep fastq)"
echo $filenames

for f in $filenames
do 
    name=$(echo $f | cut -d "." -f 1)
    mkdir -p $OUT_DIR/MAPPING/$name
    # Read alignment to refrence genome (or transcriptome)
    STAR --genomeDir $TOOL_DIR/STAR_index/GRCh38.p12 \
         --readFilesIn $DATA_DIR/$f \
         --runThreadN 16 \
	 --outSAMtype BAM SortedByCoordinate \
	 --quantMode GeneCounts \
	 --twopassMode Basic \
	 --outFileNamePrefix $OUT_DIR/MAPPING/$name/
    # create bam index file
    samtools index $OUT_DIR/MAPPING/$name/Aligned.sortedByCoord.out.bam
done

