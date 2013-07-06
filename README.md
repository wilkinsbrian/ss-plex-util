ss-plex-util
============

Free scripts and utilities for ss-plex and plex media server

Limitations to chk_ss_plex.sh script: Does not support curl (I am not running it). Script could be modified to check 
for curl though easily.

To setup chk_ss_plex.sh as a crontab, you can use this cronjob:

*/10 * * * * /path/to/script/chk_ss_plex.sh >> /path/to/script_log/plex-cron.out 2>&1

Make sure you chmod +x the chk_ss_plex.sh script. Path to script log has to be writeable by user executing cron (plex?).


