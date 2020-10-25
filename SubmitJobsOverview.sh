####On helix, load module gcc by writing it into the .bashrc script#### This was default on Cadillac
nano .bashrc
#in the script, outside the if statement
module load gcc
#save

####Load R on the server####
module load R/3.5.1
R #open workspace

####Run an R script####
Rscript Rscript.R

####Write a shell script to run an Rscript (use nano or Vim). This one will be saved as Rscript.sh####
nano #opens up text editor

#!/bin/bash
#PBS  -l walltime=0:01:00:00
#PBS -m abe
#PBS -l nodes=1:ppn=1
#PBS -l mem=32gb
cd $PBS_O_WORKDIR
Rscript Rscript.R

####Submit a job####
qsub Rscript.sh

####Status of Job####
qstat -u username


####Open interactive node####
qsub -I -q interactive -l nodes=1:ppn=1,walltime=1:00:00,mem=64gb