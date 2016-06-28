#!/bin/bash
fileName=$1
lineCount=$2
wordCount=$3

if [ -f "$fileName" ]
then
	echo "file exist"
	
	total_lines=`cat $fileName | wc -l`
#echo $total_lines
	
	if  [ ${lineCount} -gt ${total_lines} ] 
	then
		echo "line not found"
		exit
	else 

		total_words=`sed -n "$lineCount"p $fileName | wc -w`
#echo $total_words
	
	if [ ${wordCount} -gt ${total_words} ]
	then
		echo "word not found"
		else
	
	sed -n "$lineCount"p $fileName | cut -d' ' -f $wordCount
	
	echo "serching done"
	
	fi

	fi
else
echo "file not found"

fi
