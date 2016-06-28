#!/bin/bash



checkout_branch() {
	BRANCH=$1

	git checkout ${BRANCH}
	git pull origin ${BRANCH}

	if [ "$?" == "1" ]; then
		echo "Branch ${BRANCH} doesn't exist please verify...."
		exit 1
	fi
}

generate_email_list_for_conflict_files() {
        SOURCE_BRANCH=$1
        TARGET_BRANCH=$2
        GIT_CODEBASE_DIR=$3

	rm -f /tmp/conflictFilesAuthorsEmail.txt
        touch /tmp/conflictFilesAuthorsEmail.txt
	echo "EMAIL=" >> /tmp/conflictFilesAuthorsEmail.txt
	while read conflictFile;do
		echo "Finding author fo conflicting file $conflictFile"
		AUTHOR_EMAIL=`get_last_author_email_for_file ${TARGET_BRANCH} ${conflictFile} ${GIT_CODEBASE_DIR}`
		echo "Author email is ${AUTHOR_EMAIL}"
		sed -i "s/$/${AUTHOR_EMAIL},/" "/tmp/conflictFilesAuthorsEmail.txt"
		#echo ${AUTHOR_EMAIL} >> /tmp/conflictFilesAuthorsEmail.lst
	done < /tmp/conflictfiles.txt
}

get_last_author_email_for_file() {

	BRANCH_NAME=$1
	FILE_PATH=$2
	WORKING_DIR=$3

	cd ${WORKING_DIR}
	git checkout ${BRANCH_NAME}
	AUTHOR_EMAIL=`git log -n 1 --pretty=format:%ae -- ${FILE_PATH}`
	echo $AUTHOR_EMAIL
}




merge_checkedout_branches() {
	SOURCE_BRANCH=$1
        TARGET_BRANCH=$2
	GIT_CODEBASE_DIR=$3

	git merge ${SOURCE_BRANCH}

	if [ "$?" == "1" ]; then
                echo "Merge from ${SOURCE_BRANCH} to ${TARGET_BRANCH} failed, reverting merge and exiting!!!!!"
		echo "FAIL" > "/var/lib/jenkins/jobs/${TARGET_BRANCH}MultiJob/mergestatus.txt"
		echo "Merge from ${SOURCE_BRANCH} to ${TARGET_BRANCH} FAILED" >> "/var/lib/jenkins/jobs/merge_master_to_feature/branchmerges"
		git diff --name-only --diff-filter=U > /tmp/conflictfiles.txt
		git merge --abort
		generate_email_list_for_conflict_files ${SOURCE_BRANCH} ${TARGET_BRANCH} ${GIT_CODEBASE_DIR}
		exit 1
	else 
		echo "Merge from ${SOURCE_BRANCH} to ${TARGET_BRANCH} succeeded, commiting the changes"
		echo "SUCCESS" > "/var/lib/jenkins/jobs/${TARGET_BRANCH}MultiJob/mergestatus.txt"
		echo "Merge from ${SOURCE_BRANCH} to ${TARGET_BRANCH} SUCCEEDED" >> "/var/lib/jenkins/jobs/merge_master_to_feature/branchmerges"
		git push origin ${TARGET_BRANCH}
		sleep 2m
        fi
}


merge_branch() {
	SOURCE_BRANCH=$1
	TARGET_BRANCH=$2
	GIT_CODEBASE_DIR=$3

	echo "I'll be merging ${SOURCE_BRANCH} to ${TARGET_BRANCH} under ${GIT_CODEBASE_DIR}"

	cd ${GIT_CODEBASE_DIR}
	checkout_branch ${SOURCE_BRANCH}

	checkout_branch ${TARGET_BRANCH}

	merge_checkedout_branches ${SOURCE_BRANCH} ${TARGET_BRANCH} ${GIT_CODEBASE_DIR}
} 
