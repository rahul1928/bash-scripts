#!/bin/bash -v                                                                            

function database_backup_restore() {
env=$1
project_name=$2
task=$3
db_file=$4
user="root"
password="rahul123"
db_path="/opt/databaseBackup"
current_time=$(date "+%Y.%m.%d-%H.%M.%S")
#db_file=$(ls -t ${db_path} | head -1)	

if [ $env == dev ]
   then

	if [ $project_name == SI ]
          then 
             db_name="db_suggest_insurance"
	     server="vagrant@192.168.33.10"
		
         elif [ $project_name == CP ] 
	   then
             db_name="db_compare_policy"
	     server="vagrant@192.168.33.10"

          else
	  echo "Database name is not correct"	
	 fi

	 if [ $task == backup ] 
	   then 
	     backup $env $user $password $db_name $db_path 
	
	  elif [ $task == restore ]
	    then
	     restore $env $user $password $db_name $db_path $db_file 
	
	  else
	  echo "Something is wrong"
			
          fi


		elif [ $env == stage ]
			then
				
				if [ $project_name == SI ]
			    then 
			        db_name="db_suggest_insurance"
					server="stage ip si"
					
			   	elif [ $project_name == CP ] 
				then
			        db_name="db_compare_policy"
					server="stage ip cp"

				else
					echo "Database name is not correct"	
				fi

				if [ $task == backup ] 
				then 
					backup $user $password $db_name $db_path $env
			
				elif [ $task == restore ]
				then
					restore $user $password $db_name $db_path $db_file $env
			
				else
					echo "Something is wrong"
				fi

		else 
			echo "Select Correct Environment"

	fi
}

function backup(){
	env=$1
	user=$2
	password=$3
	db_name=$4
	# backup path
	db_path=$5

	# Dump database into SQL file
	ssh -tt ${server} "mysqldump --user=${user} --password=${password} ${db_name} > ${db_path}/${env}/${project_name}/${db_name}.${current_time}.sql"
	scp  ${server}:${db_path}/${env}/${project_name}/*.sql  ${db_path}/${env}/${project_name}/${db_name}.${current_time}.sql
	ssh -tt ${server} "rm ${db_path}/${env}/${project_name}/*.sql"
}


function restore(){
	env=$1
	user=$2
    password=$3
    db_name=$4
    # backup path
    db_path=$5
    db_file=$6

	# Dump database into SQL file
	scp  ${db_path}/${env}/${project_name}/${db_file} ${server}:${db_path}/${env}/${project_name}/${db_file}
	ssh -tt ${server} "mysql --user=${user} --password=${password} ${db_name} < ${db_path}/${env}/${project_name}/${db_file};sleep 3; rm ${db_path}/${env}/${project_name}/*.sql"
}

