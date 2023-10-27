#!/bin/bash

#------Change this------ 
#export the path to a dir containing file list if necessary, here it is needed to see parallel_rsync_script.sh
#which for this example has been located inside /root/rsync along with the INPUT_FILE file list
export PATH=/root/rsync:${PATH}

#list contents should be dirs not files, meaning rsync launched per dir entry NOT file
#------Change this------ 
INPUT_FILE=/root/rsync/list_of_dirs_to_copy 

#OPTIONAL
#------Change this------ activate if you want to check the host you are running from
#check where this script is running from
#HOST_SELF=`hostname`
#if [[ ${HOST_SELF} =~ ^(MYHOST1|MYHOST2)$ ]]; then
#:
#else
# /usr/bin/echo "ERROR: stopping script - hostname not found"
# exit 1
#fi

#IP is supplied to this script
#if the rsync is between two local mount points you won't need this and should remove within the final line also
BACKUP_SERVER_IP="${1}"

#------Check this------ path to parallel binary
parallel="/usr/bin/parallel"

#Get the date
DATE_OF_RUN=`date +%F_%H_%M`

#Call another script to run in parallel...
#N=1 arguement
#j=2 jobs (2 rsyncs)
${parallel} -N1 -j2 --joblog /var/log/rsync/rsync_transfer_${DATE_OF_RUN}_logfile.parallel parallel_rsync_script.sh {} ${BACKUP_SERVER_IP} ::: `cat ${INPUT_FILE}`
