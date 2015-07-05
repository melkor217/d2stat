#!/bin/sh
FLAG="-USR1"
if [ -n "$1" ]
then
  FLAG="-KILL"
fi

PROCLIST=`ps aux|grep side[k]iq\ 3`
echo "$PROCLIST"

echo "$PROCLIST" | while read line
do
  PID=`echo $line | awk '{ print $2 }'`
  kill "$FLAG" $PID
  echo $PID
done
