read -p "Directory that contains files to rename: " file_directory
pushd "$file_directory"
for file in $file_directory/*.fastq.gz
do
file2="$( echo "$file" | sed 's/.fastq.gz/_RUN2.fastq.gz/' )"
echo $file2
done
popd
pwd