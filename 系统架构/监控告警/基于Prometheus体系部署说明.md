
### 组件架构

节点说明

- Prometheus：作为整个监控系统的核心，提供数据存储，数据查询等功能。
- Exporter：采集器，存在多种角色，如操作系统的采集器、Docker容器的采集器、MySQL的采集器等。Exporter主动去采集，拉取数据，然后将数据存储Prometheus中。
- PushGateway：也是采集器，但是和Exporter的区别是，PushGateway是对应的服务主动将监控数据推送到PushGateway，然后PushGateway再推送到Prometheus。而Exporter是主动去拉取的。一个攻一个受，一个拉一个推。
- Grafana：显示面板，采集完存储在Prometheus的数据，需要进行显示，Prometheus自带的面板不好用。Grafana的显示面板种类很多，而且社区丰富，很容易找到适合自己的显示面板。
- AlertManager：采集完成的数据，要是不正常，我们一般会希望最好能告下警，AlertManager就是用来做告警的。


### Exporter部署
我们先从数据的源头开始讲起。

Exporter的种类有很多，如操作系统的采集器，Docker容器的采集器，MySQL、Nginx、ElasticSearch和Java-SpringBoot的采集器等等。而采集器的实现也很简单，根据配置的间隔，主动去拉取数据，然后存到Prometheus就行了。

Exporter负责数据的采集，而被采集的对象，**本身需要提供能被采集的数据**。一般比较出名的开源仓库，都提供相应的监控功能，如Spring的actuator的组件。

我们先从操作系统的Exporter进行采集。

#### Node-Exporter

Linux系统和部署的机器，在云计算中习惯上被称之为node，表示一个个节点。

Node-Exporter就是用来采集操作系统的Exporter，以Docker部署为例

```shell
docker run -d \
    --net=host \
    --restart=always \
    --name=node-exporter \
    -v /:/rootfs \
    -v /sys:/host/sys \
    -v /proc:/host/proc \
    bitnami/node-exporter:latest --path.procfs /host/proc --path.sysfs /host/sys --collector.filesystem.ignored-mount-points "^/(sys|proc|dev|host|etc)($|/)"
```

#### Docker-Exporter

```shell
docker run -d \
    --name=cadvisor \
    -p 9101:8080 \
    --restart=always \
    --detach=true \
    --device=/dev/kmsg \
    --privileged \
    -v /:/rootfs:ro \
    -v /var/run:/var/run:rw \
    -v /sys:/sys:ro \
    -v /data/docker:/var/lib/docker:ro \
    -v /dev/disk/:/dev/disk:ro \
    google/cadvisor
```

#### Actuator-Exporter


### Prometheus部署

```shell
# net=host表示将hosts的文件写进去
docker run -d \
    -p 9090:9090 \
    --net=host \
    --restart=always \
    --name=prometheus \
    -v /data/prometheus/conf/prometheus.yml:/opt/bitnami/prometheus/conf/prometheus.yml \
    -v /data/prometheus/data:/opt/bitnami/prometheus/data \
    bitnami/prometheus:latest
```


### Grafana部署
```shell
docker run -d \
    --name=grafana \
    --restart=always \
    -p 9006:3000 \
    grafana/grafana
```
