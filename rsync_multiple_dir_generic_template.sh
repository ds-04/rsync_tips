#!/bin/bash

# Rsync multiple directories on a per directory basis using an input array 
# with logging per directory to the same destination directory on the remote

DATE_NOW=$(date +%F_%H_%M)

# Amend
LOG_DIR="/tmp/log"

# Amend, but note trailing slash in example
DESTINATION_DIR="/tmp/"

# Amend, specify the directories to rsync
declare -a INPUT_DIRS=(/tmp/test1/test1a /tmp/test2/test2a)

# Loop through the array
for InputD in "${INPUT_DIRS[@]}"
do
   # Get the line for logging
   LOG_LINE=$(echo "${InputD}" | grep -o '[^/]*$')

   # Show the log line
   echo $LOG_LINE

   # Perform the rsync
   # Amend options and -n dry mode - add ssh or remote mount
   rsync -nav --stats "${InputD}" ${DESTINATION_DIR} > "${LOG_DIR}/${LOG_LINE}_${DATE_NOW}" 2>&1;
done
