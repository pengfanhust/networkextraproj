#!/bin/bash
dirname=$1
files=`ls $dirname`
shift
for file in $files
do
    f=${dirname}/${file}
    echo "process $f"
    ./grepForStuff.sh $f ${file}_out $@
done


