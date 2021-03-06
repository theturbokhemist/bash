#!/bin/bash

#read in starting directory
read -p "Directory that contains all files to copy in Cadillac: " find_directory

copy_directory="$find_directory/genes_results"
#parent_copy_directory="$( dirname "$find_directory" )/genes_results"
mkdir -p "$copy_directory"
#mkdir -p "$parent_copy_directory"
echo "$copy_directory"
#echo "$parent_copy_directory"

#find "$find_directory" -path "$copy_directory" -prune -o -name "*.genes.results" -type f -exec cp {} "$copy_directory" \;
#using -prune to avoid finding through the copy_directory

#find "$find_directory" -name "*.genes.results" -type f -exec cp {} "$parent_copy_directory" \;
#copying to a parent directory

find "$find_directory" -name '*.genes.results' -type f -print0 | xargs -0I{}  cp {} "$copy_directory"
#Using xargs to bundle up output from find

