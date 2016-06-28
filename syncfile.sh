#!/bin/bash

source_file=$1
distination=$2

if [ -d $source_file -a $distination ]

then

	rsync -rtv $source_file/ $distination/ 

 echo "sync done"

else
 
echo "rsync not done"

fi
