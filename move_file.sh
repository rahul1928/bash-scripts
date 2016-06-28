#!/bin/bash

source_file=$1
distination=$2

if [ -f "$source_file" -a -f  "$distination" ]                # chek the source file and distination file  are exist or not (-a means and ) 

then 

 echo "both files exist"

	mv $source_file $distination

else

 echo "does not exit"

fi

