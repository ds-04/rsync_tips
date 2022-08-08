# rsync_tips
A reference of rsync commands.

<b>NOTE: commands here are in dry-run to avoid changes.</b>
<br>
<br>
#transfer and ensure receiver matches source, with use of <i>--delete-after</i><br>
``rsync -avn --delete-after ${SOURCE}/ ${DEST}/ > /tmp/rsync_transfer_${DATE_OF_RUN} 2>&1;``<br>
<br>
<br>
#check if anything is left to do using <i>--stats</i> to log<br>
``rsync -avn --stats ${SOURCE}/ ${DEST}/ > /tmp/rsync_check_stats_${DATE_OF_RUN} 2>&1;``<br>
<br>
#alternative checking methods, <i>-i, itemize-changes; -r, recursive</i>... skip creating files on receiver or skip updating files on receiver<br>
``rsync -rin (--existing|--ignore-existing) ${SOURCE}/ ${DEST}/ > /tmp/rsync_check_itemize_${DATE_OF_RUN} 2>&1;``<br>
