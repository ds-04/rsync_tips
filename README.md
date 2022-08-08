# rsync_tips
A reference of rsync commands.

<b>NOTE: commands here are in dry-run to avoid changes.</b>
<br>
<br>
#transfer and ensure receiver matches source, with use of <i>--delete-after</i><br>
``rsync -avn --delete-after ${SOURCE}/ ${DEST}/ > /tmp/rsync_transfer_${DATE_OF_RUN} 2>&1;``<br>
<br>
<br>
#check if anything is left to do using --stats to log<br>
``rsync -avn --stats ${SOURCE}/ ${DEST}/ > /tmp/rsync_check_stats_${DATE_OF_RUN} 2>&1;``<br>
