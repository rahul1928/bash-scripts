#!/bin/bash
filename=$1
lineadd=$2

if [ -f $filename ]
 then 
	echo "file exist"
	grep -q "$lineadd" "$filename"
	status=$?
       if [ $status == 0 ]                          
       then
	echo "already present"
	exit

       else 
        	echo "$lineadd" >> "$filename"
	        echo "line added"
		fi
else
	echo "file not exist"

fi

