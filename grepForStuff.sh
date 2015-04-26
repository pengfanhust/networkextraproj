#!/bin/bash

# the first argument is the tcpdump file name, the second argument is the output file name,
# the rest part is the phone specified string need to be searched.

filename="$1"
outputfile="$2"

tcpdump -Ar $filename| grep -v 'TCP' | grep -v 'HTTP' | grep -v 'seq' > $outputfile
echo $filename

echo "-Looking for lat=, latitude="
egrep -io "[^a-zA-Z]?lat([^a-zA-Z]|itude).*[0-9]+(\.?)[0-9]+" $outputfile | sort | uniq -c

echo "Looking for phone specific things"
#bypass the first two arguments, which is not the phone specified string
shift
shift
for var in "$@"
do
    echo "Looking for phone specific things $var"
    grep -i $var $outputfile | sort| uniq -c
done

echo " Looking for phone number, also phone=, number=  "
egrep -io "[^a-zA-Z]?number[^a-zA-Z]?([:=])+(\"?).........." $outputfile | sort | uniq -c
egrep -io "[^a-zA-Z]?phone[^a-zA-Z]?([:=])+(\"?)........." $outputfile | sort | uniq -c

echo " Looking for credit card numbers "
egrep -io '4[0-9]{12}(?:[0-9]{3})?' $outputfile | sort  | uniq -c #Visa
egrep -io '5[1-5][0-9]{14}' $outputfile | sort | uniq -c #MasterCard
egrep -io '[47][0-9]{13}' $outputfile | sort | uniq -c #AmEx
egrep -io '3(?:0[0-5]|[68][0-9])[0-9]{11}' $outputfile | sort | uniq -c #DinersClub
egrep -io '6(?:011|5[0-9]{2})[0-9]{12}' $outputfile | sort | uniq -c #Discover
egrep -io '(?:2131|1800|35\d{3})\d{11}' $outputfile | sort | uniq -c #JCB

echo "\nLooking for email addresses"
egrep -io "[^ ]+@([a-z]+\.)+(((com)|(org))|((edu)|(net)))" $outputfile
