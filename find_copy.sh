#!/bin/bash

read -p "Directory to find FastQ files: " find_directory
read -p "Directory to copy found files to: " copy_directory

mkdir -p "$copy_directory"

#find "$find_directory" -name "Ranked-DEGenes*" -exec cp -i {} "$copy_directory" \; #-i makes it interactive, prompts before overwrite
find "$find_directory" -name "Ranked-DEGenes*" -type f -print0 | xargs -0 -I {} cp {} "$copy_directory"
echo "$find_directory"
#Using xargs to bundle up output from find

#find "$find_directory" -path "$copy_directory" -prune -o -name "*.genes.results" -type f -exec cp {} "$copy_directory" \;
#using -prune to avoid finding through the copy_directory

#find "$find_directory" -name "*.genes.results" -type f -exec cp {} "$parent_copy_directory" \;
#copying to a parent directory
