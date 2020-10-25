#! bin/bash

#read in starting and ending directory
read -p "Directory that contains all BAM files: " BAM_directory
read -p "Directory that will contain all BED files: " BED_directory

#create ending directory
mkdir -p "$BED_directory"

find "$BAM_directory" -name "*.BAM" -exec cp -i {} "$BED_directory" \;

for BAM_File in  $BED_directory/*.BAM
do 
#creating BED file name
BED_File="${BAM_File/BAM/BED}"

    if [ -f "$BAM_File" ]
    then
      echo "$BAM_File"
#BAM to BED conversion
      bedtools bamtobed -i "$BAM_File" > "$BED_File"
    else
    echo "Error: File "$BAM_File" not found" >&2
    exit
    fi
done
