

#Call another script to run in parallel...
#N=1 arguement
#j=2 jobs (2 rsyncs)
${parallel} -N1 -j2 --joblog /var/log/rsync/rsync_home_${DATE_OF_RUN}_logfile.parallel parallel_rsync_script.sh {} ${BACKUP_SERVER_IP} ::: `cat ${INPUTE_FILE}`
