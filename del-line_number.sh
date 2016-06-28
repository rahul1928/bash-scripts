#!/bin/bash

filename=$1
linenumber=$2

if [ -f $filename ]
then
	echo "file exist"
      
		total_lines=` wc -l < $filename`
        echo "$total_lines"
	if [ $linenumber -gt $total_lines ] 
        then 
	    echo "line not found"
	   exit
        else
	  sed -i "$linenumber d" $filename
	  echo "line delete"
	  fi

else 
	echo " file not exist "

fi
	      
