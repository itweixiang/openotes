

### ENV
ENV KAFKA_HEAP_OPTS default 1g 

```properties
broker.id=0
listeners=PLAINTEXT://:9092
advertised.listeners=PLAINTEXT://192.168.10.150:9092
num.network.threads=3
num.io.threads=8
socket.send.buffer.bytes=102400
socket.receive.buffer.bytes=102400
socket.request.max.bytes=104857600
log.dirs=/opt/kafka/data
num.partitions=3
num.recovery.threads.per.data.dir=1
offsets.topic.replication.factor=2
transaction.state.log.replication.factor=2
transaction.state.log.min.isr=2
log.retention.hours=24
log.segment.bytes=1073741824
log.retention.check.interval.ms=300000
zookeeper.connect=192.168.10.150:2181,192.168.10.151:2181,192.168.10.152:2181/kafka
zookeeper.connection.timeout.ms=18000
group.initial.rebalance.delay.ms=0
```


```shell
docker run -d \
--net=host \
--name=kafka \
--restart=always \
-e KAFKA_HEAP_OPTS="-Xmx1g -Xms1g -Dcom.sun.management.jmxremote.port=1099 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote=true" \
-v /data/kafka/data:/opt/kafka/data \
-v /data/kafka/logs:/opt/kafka/logs \
-v /data/kafka/conf/server.properties:/opt/kafka/config/server.properties \
overseas-mirrors.dl-aiot.com/dl/public/kafka:2.8.1
```


```shell
docker run -d \
--net=host \
--name=kafka \
--restart=always \
-e KAFKA_HEAP_OPTS="-Xmx1g -Xms1g" \
-v /data/kafka/data:/opt/kafka/data \
-v /data/kafka/logs:/opt/kafka/logs \
-v /data/kafka/conf/server.properties:/opt/kafka/config/server.properties \
overseas-mirrors.dl-aiot.com/dl/public/kafka:2.8.1
```