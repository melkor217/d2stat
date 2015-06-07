#!/bin/sh

PROCLIST=`ps aux|grep side[k]iq\ 3`
echo $PROCLIST
PID=`echo $PROCLIST | awk '{ print $2 }'`
kill -USR1 $PID
