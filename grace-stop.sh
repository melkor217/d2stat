#!/bin/sh

PROCLIST=`ps aux|grep side[k]iq\ 3`
echo "$PROCLIST"

echo "$PROCLIST" | while read line
do
  PID=`echo $line | awk '{ print $2 }'`
  kill -USR1 $PID
  echo $PID
done
