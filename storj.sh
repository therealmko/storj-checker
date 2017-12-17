#!/bin/bash
#Simple shell script to check the status, monitor and restart storjshare daemon running in Docker
#Created: 10-12-2017
#Version: 1.0
#Creator: therealmko

# define script variables
STORJ_HOST="mkoning.homelinux.com"
STORJ_PORT="4000"
STORJ_CONFIG="/storj/config/config.json"

############################################
#No need to change anything after this line#
############################################

# Functions

# usage function
usage(){
	echo "Usage: $0 <option>"
	echo "Valid options are:"
	echo "- check"
	echo "- status"
	echo "- startup"
	echo "- version"
	exit 1
}

# check Storj versions
storj_version(){
	docker exec storj storjshare -Version
}

# start Storj daemon and share
storj_startup(){
	sudo docker exec storj storjshare daemon && sudo docker exec storj storjshare start --config ${STORJ_CONFIG}
}

# display Storj status table
storj_status(){
	sudo docker exec storj storjshare status
}

# enable quick port check to see if storj daemon is running
storj_check(){
    echo "Testing connection to $1 on port $2...."
    timeout 2 bash -c "</dev/tcp/$1/$2"
	RESULT=$?

    # if result negative call function to restart Storj daemon and share
    if [ "${RESULT}" -ne 0 ]
    then
		storj_startup
	else
		echo "Connection to $1 on port $2 looks ok!"
    fi
}


# Do Work

# check if any parameter is given
[[ $# -eq 0 ]] && usage

case $1 in
	check)
		storj_check ${STORJ_HOST} ${STORJ_PORT}
		;;
	startup)
		storj_startup
		;;
	status)
		storj_status
		;;
    version)
        storj_version
        ;;
	*)
		usage
		;;
esac
