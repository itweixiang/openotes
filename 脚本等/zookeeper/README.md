

### ENV

ZK_SERVER_HEAP default 1000


### single
- docker 

```shell
docker run -d \
--net=host \
-v /data/zookeeper/data:/opt/zookeeper/data \
-v /data/zookeeper/logs:/opt/zookeeper/datalog \
-v /data/zookeeper/conf:/opt/zookeeper/conf \
--name=zookeeper \
--restart=always \
office-mirrors.dl-aiot.com/dl/public/zookeeper:3.5.10
```

- conf
```yaml
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/opt/zookeeper/data
dataLogDir=/opt/zookeeper/datalog
clientPort=2181
```



### cluster

- docker 
```shell

echo 1 > /data/zookeeper/data/myid

docker run -d \
--net=host \
-e SERVER_JVMFLAGS="-Dcom.sun.management.jmxremote.port=1088 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote=true" \
-v /data/zookeeper/data:/opt/zookeeper/data \
-v /data/zookeeper/logs:/opt/zookeeper/datalog \
-v /data/zookeeper/conf:/opt/zookeeper/conf \
--name=zookeeper \
--restart=always \
office-mirrors.dl-aiot.com/dl/public/zookeeper:3.5.10
```

- conf
```yaml
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/opt/zookeeper/data
dataLogDir=/opt/zookeeper/datalog
clientPort=2181
server.0=192.168.10.150:2888:3888
server.1=192.168.10.151:2888:3888
server.2=192.168.10.152:2888:3888
```