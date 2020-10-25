#!/bin/bash
fq=$1
cat > pbs_$fq << EOF
#PBS -N fq_$fq
#PBS -q batch
#PBS -l nodes=1:ppn=1
#PBS -l walltime=1:59:00
#PBS -S /bin/bash

cd /projects/lu-lab/FOXP1/data/fastq
/home/lum/tools/sratoolkit.2.9.0-ubuntu64/bin/fastq-dump $1
EOF
