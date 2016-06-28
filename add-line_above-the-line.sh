#!/bin/bash
filename=$1
addline=$2
addword=$3


if [ -f $filename ]
then 
	if [ ! -s $filename ]                  #[ -s chek file is empty or not]
	then
	    echo $addword >> $filename
            echo "data enter in empty file"

        else
	sed -i "$addline i $addword" $filename
	echo "data enter in not empty file"
	fi

else
     echo "file does not exist"

fi


