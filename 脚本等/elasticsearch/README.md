

### ENV

ES_JAVA_OPTS default 1000


### single
- docker 

```shell
chown -R 1000:1000 -R /data/elasticsearch

docker run -d \
--net=host \
--restart=always \
--name=elasticsearch \
-v /data/elasticsearch/data:/opt/elasticsearch/data \
-v /data/elasticsearch/logs:/opt/elasticsearch/logs \
-v /data/elasticsearch/conf/elasticsearch.yaml:/opt/elasticsearch/config/elasticsearch.yml \
-v /data/elasticsearch/conf/jvm.options:/opt/elasticsearch/config/jvm.options \
office-mirrors.dl-aiot.com/dl/public/elasticsearch:7.17.12
```

- conf
```yaml
cluster.name: cloud-research
network.host: 192.168.10.160
discovery.seed_hosts: ["192.168.10.160:9300"]
node.name: elasticsearch-0
cluster.initial_master_nodes: ["elasticsearch-0"]
xpack.security.enabled: true
xpack.security.transport.ssl.enabled: true
```



### cluster

- docker 
```shell
chown -R 1000:1000 -R /data/elasticsearch

docker run -d \
--net=host \
--restart=always \
--name=elasticsearch \
-v /data/elasticsearch/data:/opt/elasticsearch/data \
-v /data/elasticsearch/logs:/opt/elasticsearch/logs \
-v /data/elasticsearch/conf/elasticsearch.yaml:/opt/elasticsearch/config/elasticsearch.yml \
-v /data/elasticsearch/conf/jvm.options:/opt/elasticsearch/config/jvm.options \
-v /data/elasticsearch/conf/elastic-certificates.p12:/opt/elasticsearch/config/elastic-certificates.p12 \
office-mirrors.dl-aiot.com/dl/public/elasticsearch:7.17.12
```

- conf
```yaml
cluster.name: cloud-research
node.name: elasticsearch-0
network.host: 192.168.10.160
node.master: true
node.data: true
xpack.security.enabled: false
xpack.security.transport.ssl.enabled: false
discovery.seed_hosts: ["192.168.10.160:9300","192.168.10.161:9300","192.168.10.162:9300"]
cluster.initial_master_nodes: ["elasticsearch-0","elasticsearch-1","elasticsearch-2"]
```