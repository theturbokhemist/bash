#!/bin/bash

read -p "Directory to find FastQ files: " find_directory
read -p "Directory to copy found files to: " copy_directory

if [ ! -d "$copy_directory" ]
then
mkdir -p "$copy_directory"
fi

find "$find_directory" -name "*.fastq.gz" -exec cp -i {} "$copy_directory" \;

echo "$find_directory"
