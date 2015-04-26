#!/bin/bash
dirname=$1
files=`ls $dirname`
for file in $files
do
    f=${dirname}/${file}
    echo "process $f"
    ./grepForStuff.sh $f ${f}_out
done


