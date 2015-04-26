#!/bin/bash
# the first argument is the directory name, the rest part is the phone specified string need to be searched.

dirname=$1
files=`ls $dirname`
#bypass the first argument
shift
for file in $files
do
    f=${dirname}/${file}
    echo "process $f"
    ./grepForStuff.sh $f ${file}_out $@
done


