

```shell
docker run -d \
-p 8048:8048 \
-v /data/kafka-eagle/conf/system-config.properties:/opt/kafka-eagle/conf/system-config.properties \
--name=kafka-eagle \
--restart=always \
overseas-mirrors.dl-aiot.com/dl/public/kafka-eagle:3.0.1
```