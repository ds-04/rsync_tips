#!/bin/bash

#------Change this------ 
#export the path to a dir containing file list if necessary
#export PATH=/rsync:${PATH}

#------Change this------ 
INPUT_FILE=/rsync/list_of_dirs_to_copy

#------Change this------ activate if you want to check the host you are running from
#check where this script is running from
#HOST_SELF=`hostname`
#if [[ ${HOST_SELF} =~ ^(MYHOST1|MYHOST2)$ ]]; then
#:
#else
# /usr/bin/echo "ERROR: stopping script - hostname not found"
# exit 1
#fi

#IP/dest from supplied to script
BACKUP_SERVER_IP="${1}"

#------Change this------ path to parallel binary
parallel="/parallel/bin/path/parallel"

#Get the date
DATE_OF_RUN=`date +%F_%H_%M`

#Call another script to run in parallel...
#N=1 arguement
#j=2 jobs (2 rsyncs)
${parallel} -N1 -j2 --joblog /var/log/rsync/rsync_home_${DATE_OF_RUN}_logfile.parallel parallel_rsync_script.sh {} ${BACKUP_SERVER_IP} ::: `cat ${INPUTE_FILE}`
