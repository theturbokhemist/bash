#!/bin/bash

#read in directory
read -p "Directory that contains all fastQ files: " fastQ_directory

module load compsci
module load civet_research_pipelines
list_pipelines

#menu for selecting sequencing
echo "Single or Paired-end sequencing?"
select sequencing_type in "Single" "Paired"
do
case $sequencing_type in
"Single" )
sequencing_type="Single"
echo "$sequencing_type"
break
;;

"Paired" )
sequencing_type="Paired"
echo "$sequencing_type"
break
;;

* )
echo "Please choose either 'Single' or 'Paired'"
;;
esac
done

#menu for selecting organism
echo "Mouse or Human sample(s)?"
select organism in "Mouse" "Human"
do
case $organism in
"Mouse" ) 
options="$fastQ_directory/mrpe.options"
cat $options
break
;;

"Human" )
options="$fastQ_directory/hrpe.options"
cat $options
break
;;

* )
echo "Please choose either 'Mouse' or 'Human'"
;;
esac
done


#looping through files that are found with globbing
#the files could be in any order. it just finds the first R1, changes to R2, and moves on to the next available R1
for directory in `find $fastQ_directory -mindepth 1 -type d`
do
cp $options $directory
echo "test"
for r1_file in $directory/*_R1_*.fastq.gz
do
    if [ -f "$r1_file" ]
    then
    echo "$r1_file"

        if [ "$sequencing_type" == "Paired" ]
        then

#Command substitution allows the output of a command to replace the command itself. 
#Command substitution occurs when a command is enclosed like this: $(command)
        #Using sed with command substitution
        r2_file="$( echo "$r1_file" | sed 's/R1/R2/' )"
        #do it by globing:
        #r2_file="${r1_file/R1/R2}"
        echo "$r2_file"

            if [ "$organism" == "Mouse" ]
            then
            #alignment code
            mrpe -o $options "$r1_file" "$r2_file"
            fi

            if [ "$organism" == "Human" ]
            then
            #alignment code
            hrpe -o $options "$r1_file" "$r2_file"
            fi

        fi

        if [ "$sequencing_type" == "Single" ]
        then
        
            if [ "$organism" == "Mouse" ]
            then
            #alignment code
            mrpe -o $options "$r1_file"
            fi

            if [ "$organism" == "Human" ]
            then
            #alignment code
            hrpe -o $options "$r1_file"
            fi

        fi
    else
    echo "Error: File "$r1_file" not found" >&2
    exit
    fi
done
done
