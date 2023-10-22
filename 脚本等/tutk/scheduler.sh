#!/bin/bash
set -ex

# */1 * * * * root /bin/bash /root/scheduler.sh
# tail -f /var/log/cron
PIDS=`ps -ef |grep IOTC_Server |grep -v grep | awk '{print $2}'`
if [ "$PIDS" != "" ]; then
  echo "IOTC_Server is running"
else
  echo "IOTC_Server is not run !!!"
  cd /root/IOTC_Server_3.4.12.0
  nohup ./start_IOTCS.sh &
fi