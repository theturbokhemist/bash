#!/bin/bash

#read in starting and ending directory
read -p "Directory that contains all files to move from Cadillac: " find_directory
read -p "Directory that will contain all files from Cadillac: " copy_directory

#scp gordid@cadillac:"$find_directory/*.genes.results" $copy_directory

ssh gordid@cadillac find "$find_directory" -name "*.genes.results" | 
while read path_name
do
    echo "$path_name"
    scp gordid@cadillac:$path_name "$copy_directory"
done


#scp gordid@cadillac:"$( ssh gordid@cadillac find "$find_directory" -name "*.genes.results" )" $copy_directory 









#ssh gordid@cadillac find "$find_directory" -name "*.genes.results" -exec scp -i gordid@cadillac:{} "$copy_directory" \;

#scp $( ssh gordid@cadillac find "$find_directory" -name "*.genes.results" ) $copy_directory 

#scp $( gordid@cadillac:$( ssh gordid@cadillac find "$find_directory" -name "*.genes.results" | xargs )) $copy_directory 


#scp gordid@cadillac:"$(ssh find "$find_directory" -name "*.genes.results")" $copy_directory 


##find gordid@cadillac:"$find_directory" -name "*.genes.results" -exec scp -i {} "$copy_directory" \;
                                                                                                   
