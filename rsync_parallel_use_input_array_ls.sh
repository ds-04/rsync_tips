#!/bin/bash

# Rsync multiple directories on a per directory basis using an input array 
# with logging per directory

parallel="/usr/bin/parallel"
DATE_NOW=$(date +%F_%H_%M)

# Amend
LOG_DIR="/root/rsync/log"

# Amend, but note trailing slash in example
DESTINATION_DIR="/MY/DEST/"
SOURCE_DIRS="/MY/SOURCE/"

# Array using input list
declare -a INPUT_DIRS=$(ls -1 ${SOURCE_DIRS})

# Amend rsync options and jobs number
${parallel} -N1 -j4 "rsync -nav --stats ${SOURCE_DIRS}{} ${DESTINATION_DIR} > ${LOG_DIR}/{}_${DATE_NOW} 2>&1;" ::: $(echo ${INPUT_DIRS})
