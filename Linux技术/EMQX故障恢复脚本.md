





```sh
#!/bin/bash

set -ex

EMQX_MONIROTR_URL=10.50.96.8:9104/metrics

# 获取本机IP
SERVER_IP=$(ip addr | awk '/^[0-9]+: / {}; /inet.*global/ {print gensub(/(.*)\/(.*)/, "\\1", "g", $2)}'  | grep 10.50)

COUNT=$(curl ${EMQX_MONIROTR_URL} | grep emqx_delivery_dropped_queue_ful | grep ${SERVER_IP} | awk {'print $2'})

if [ ${COUNT} -gt 10 ]; then
  docker restart emqx
  echo "${SERVER_IP}: emqx_delivery_dropped_queue_ful > 10 , restart emqx"
  DATE=`date +"%Y-%m-%d %T"`
  echo "${DATE} restart emqx" >> /root/emqx.record
else
  echo "${SERVER_IP}: emqx_delivery_dropped_queue_ful=${COUNT}"
fi
```

