#!/bin/bash
echo "Enter your input"
read input
if [ $input -eq $input 2>/dev/null ]  
then
echo "$input is an integer"
else
   echo "$input is string"
fi


         
