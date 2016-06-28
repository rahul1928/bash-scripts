#!/bin/bash

filename=$1
linenumber=$2

if [ -f $filename ]
then
   total_lines=`wc -l < $filename`
   echo "$total_lines lines in the file"
   if [ $linenumber -gt $total_lines ]
   then
   echo "$linenumber line not found"
   exit
  
fi
else
    echo "file not exit"

fi
