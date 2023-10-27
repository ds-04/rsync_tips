#!/bin/bash

#Script to launch an rsync instance, called from parallel_rsync_launcher_template.sh

if [ "$#" -ne 2 ]; then
echo "You must enter exactly 2 command line arguments - Full path to a directory and the BACKUP server IP and in that order"
exit 1
fi

#Get the date for this run
DATE_OF_RUN=`date +%F_%H_%M`

# base path for destination/backup
#------Change this------ 
BACKUP_PATH="/backup/destination/on/remote/"    #note includes trailing slash here

#INPUT TO SCRIPT - supplied by the other launcher script
#local full path to a dir
DLINE=$1
BACKUP_SERVER_IP=$2

#Get the dir line basename so it can be logged
DIR_LOG_LINE=`/usr/bin/basename ${DLINE}`

# REMOVE -n dry mode to activate copying
/usr/bin/rsync -e "ssh -i /path/to/key" -nav --acls --exclude=".exclude_something_example" --delete-after ${DLINE} user@${BACKUP_SERVER_IP}:/${BACKUP_PATH} > /dev/null 2>"/var/log/rsync/rsync_log_${DIR_LOG_LINE}_${DATE_OF_RUN}.txt"
