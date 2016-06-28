#!/bin/bash
user_name=$1
ip_address=$2
homeDirectory=$3

echo "enter user_name"
read user_name
echo "ip_address"
read ip_address
echo "Enter Your home directory"
read homeDirectory

echo $home
       if [ -f "${homeDirectory}/.ssh/id_rsa.pub" ]
       then 
	  echo "file exist"
          ssh-copy-id $user_name@$ip_address
          ssh $user_name@$ip_address

         else
	   echo "file not exist"
           ssh-keygen -q -t rsa -N "" -f ~/.ssh/id_rsa
   	   ssh-copy-id $user_name@$ip_address 
	   ssh $user_name@$ip_address	

          fi





#	ssh-copy-id $user_name@$ip_address 
#	ssh $user_name@$ip_address
#       echo -e  'y\n'|ssh-keygen -q -t rsa -N "" -f ~/.ssh/id_rsa
