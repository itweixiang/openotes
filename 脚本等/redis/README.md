

```sh
docker run -d \
--net=host \
--name=redis \
--restart=always \
-v /data/redis/conf:/opt/redis/conf \
-v /data/redis/data:/opt/redis/data \
-v /data/redis/logs:/opt/redis/logs \
redis:6 redis-server /opt/redis/conf/redis.conf
```


redis-cli --cluster create \
-a Dl@admin123 \
--cluster-replicas 1 \
192.168.10.170:6379 \
192.168.10.171:6379 \
192.168.10.172:6379 \
192.168.10.173:6379 \
192.168.10.174:6379 \
192.168.10.175:6379 \