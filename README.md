# rsync_tips
A reference of rsync commands.

<h1>Rsync Commands and hints</h1>

<b>NOTE:</b>
- commands here are in dry-run to avoid changes. 
- note trailing slash after ``SOURCE`` and ``DEST`` vars
- example date var ``DATE_OF_RUN=date +%F_%H_%M``
- you may require ``-e "ssh -i /path/to/key"`` and ``user@${BACKUP_SERVER}:/${DEST}/``...
- you may require ``--acls``
- ...it is assumed below that storage is mounted.
<br>
<br>
<h2>Commands using stdout and stderr, verbose for logging - without logging options</h2>

<b>#transfer and ensure receiver matches source, with use of <i>--delete-after</i>, combined stdout and stderr log file.</b><br>
``rsync -avn --delete-after ${SOURCE}/ ${DEST}/ > /tmp/rsync_transfer_${DATE_OF_RUN} 2>&1;``<br>
<br>
<br>
<h2>Commands using info options for logging using stdout and stderr</h2>

<b>#Set up variable with logging options, see man page.</b><br>
``INFO_OPTS="--info=BACKUP2,COPY2,DEL2,NAME2,REMOVE2,SKIP2,SYMSAFE2"``
<br>
<br>
<b>#Perform rsync with logging options with redirect to distinct stdout and stderr log files.</b><br>
``rsync ${INFO_OPTS} -na --acls ${SOURCE} ${DEST} > /tmp/rsync_transfer_${DATE_OF_RUN} 2> /tmp/rsync_transfer_${DATE_OF_RUN}_err;``
<br>
<br>
<h1>Checking methods</h1>

<b>#check if anything is left to do using <i>--stats</i> to log</b><br>
``rsync -avn --stats ${SOURCE}/ ${DEST}/ > /tmp/rsync_check_stats_${DATE_OF_RUN} 2>&1;``<br>
<br>
<b>#alternative checking methods, <i>-i, itemize-changes; -r, recursive</i>... skip creating files on receiver or skip updating files on receiver</b><br>
``rsync -rin (--existing|--ignore-existing) ${SOURCE}/ ${DEST}/ > /tmp/rsync_check_itemize_${DATE_OF_RUN} 2>&1;``<br>
<br>
<br>
<h2>Count files using dry mode</h2>

<b>#By using --stats and dry mode the files at a location can be counted.</b><br>
``rsync -na --stats <PATH>``
<br>
<br>
<h1>Parallel rsync templates</h1>

Templates are found within this repository, adapt as needed.

The templates are relevant to a scenario where a number of directories in a top level directory need transferred to a remote host/folder. As such the input listing should ideally be directories not files, to avoid an rsync process per file.
<br>
<br>
<h1>Generating input lists</h1>

You may find the ``tree`` or ``ls -1`` command helpful to generate the input list(s).
<br>
<br>
tree examples:<br>
<br>
``tree --noreport -fixL 3``
<br>
<br>``-f full path``
<br>``-i no indentation lines``
<br>``-x stay on filesystem``
<br>``-L max levels``
<br>
<br>
``tree -dfi --noreport > /tmp/file_list``
<br>
<br>``-d directories only``
<br>``-f full path``
<br>``-i no indentation lines``
<br>

<h1>Sync directory structure</h1>

Copy directories from an input list, ensure permissions, not recursive, just items from the input list.

``rsync -v -lptgo --acls -f"+ */" -f"- *" --files-from=/root/prsync/input_list_with_basename_dirs_listed /source_dir_no_trailing_slash /destination_dir/``

The above command uses -lptgo which is similar to --archive (-a) , but omits recursion (-r) and devices (-D).

The source (above "/source_dir_no_trailing_slash") is essentially the directory prefix to the input list (above "input_list_with_basename_dirs_listed").


