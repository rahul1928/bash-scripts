#!/bin/bash
file=$1
if [ -f $file ]
then 
	rm -r $file

echo "remove done"

else
	echo "file not exist"
fi
