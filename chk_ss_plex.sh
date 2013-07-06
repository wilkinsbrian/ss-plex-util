#!/bin/sh

SS_PLEX_URL=http://127.0.0.1:32400/video/ssp/downloads
WGET_OUT=/tmp/downloads

DOWNLOAD_SUCCESS=`wget -q -O - $SS_PLEX_URL > $WGET_OUT ; grep "100%" $WGET_OUT | wc -l`

PROCESSING_TITLE=`grep "/video/ssp/downloads/options-for-current" $WGET_OUT | sed -n '/Directory/s/.*\+title="\([^"]\+\).*/\1/p' | head -1`
PROCESSING_TITLE_PROGRESS=`grep "/video/ssp/downloads/options-for-current" $WGET_OUT | sed -n '/Directory/s/.*\+title="\([^"]\+\).*/\1/p' | sed -n '2p' | grep -o '[^ ]*%'`

WGET_RUNNING=`ps -ef | grep wget | grep -v grep | wc -l`

FIRST_FAILED_TITLE=`grep "/video/ssp/downloads/options-for-failed" $WGET_OUT | sed -n '/Directory/s/.*\+title="\([^"]\+\).*/\1/p' | head -1`

NOW="$(date)"

if [ -n "$FIRST_FAILED_TITLE" ]
then
   echo "[$NOW] First failed title.. consider retrying: $FAILED_TITLE"
fi

if [ $WGET_RUNNING -eq 1 ]
then
   echo "[$NOW] wget is running.. bailing out"
   echo "[$NOW] Title : $PROCESSING_TITLE ($PROCESSING_TITLE_PROGRESS)"
   exit 1
fi

if [ -n "$PROCESSING_TITLE" ]
then
   echo "[$NOW] Currently Processing : $PROCESSING_TITLE"

   if [ $DOWNLOAD_SUCCESS -eq 1 ]
   then
      FORCE=`wget -q http://127.0.0.1:32400/video/ssp/downloads/force-success`
      echo "[$NOW] Download stalled. Forced accept!"
   fi
else
   echo "[$NOW] Nothing to process.. bailing out"
fi

