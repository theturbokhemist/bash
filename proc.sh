#!/bin/bash
for i in `cat list`; do
   echo $i
   ./input_pbs.sh $i 
    qsub pbs_$i
done 
