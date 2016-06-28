#!/bin/bash 
dir=$1
if [ ! -d $dir ]       # chek the directory yes or not
then
	mkdir $dir
else
echo "already exit"
fi
