#!/bin/bash

#read in starting directory
read -p "Directory that contains all files to copy in Cadillac: " find_directory
read -p "Directory to copy to: " copy_directory

#find "$find_directory" -path "$copy_directory" -prune -o -name "*.genes.results" -type f -exec cp {} "$copy_directory" \;
#using -prune to avoid finding through the copy_directory

#find "$find_directory" -name "*.genes.results" -type f -exec cp {} "$parent_copy_directory" \;
#copying to a parent directory

find "$find_directory" -name '*.genes.results' -type f -print0 | xargs -0I{}  cp {} "$copy_directory"
#Using xargs to bundle up output from find





