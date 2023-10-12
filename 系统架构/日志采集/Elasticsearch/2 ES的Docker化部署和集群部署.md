

### Docker单机部署Elasticsearch

使用docker部署的方式，可以尽量减少原生系统的影响，而且隔离性和运维成本也更好。

不过要是对elasticsearch的镜像不熟悉，那也可能会踩一些坑。



#### 目录规划和配置

我个人在习惯上，比较倾向于把容器中的数据、配置和日志挂载出来。

而elasticsearch的官方镜像，对应的目录如下

数据：/usr/share/elasticsearch/data

配置：/usr/share/elasticsearch/config

日志：/usr/share/elasticsearch/logs



这些目录，elasticsearch在docker hub上没有说明，需要进入到容器里面，自己找一下对应的目录，哎~



数据目录和日志目录，没有的话，集群启动时会创建。

但是配置目录是空目录的话，那么es在启动时获取不到配置，启动就会失败。

所以需要挂载配置的话，可以先启动一个临时容器，把配置拷贝到宿主机上。也可以直接下载安装包，用里面的配置进行挂载。



这里我使用上篇文章下载的安装包中的配置，进行挂载。



#### 授权

因为我们将数据挂载了出来，所以会有一个权限问题。

这是因为elasticsearch为了安全，禁止使用root用户启动。容器部署亦然，所以容器内运行的用户，他的权限比较低。

很容易出现没有权限的问题，所以把整个目录设置为所有人可读可写可执行。

我自己试过很多次，**必须要777权限，可读可写可执行才行**。

```
chmod -R 777 /data/elasticsearch-7.17.9
```



#### 启动

elasticsearch的默认端口是9200，集群通信端口是9300。

为了方便，我一般是让es使用宿主机的网络，要改端口的话直接根据配置文件修改，懒得去做端口映射。

```sh
docker run -d \
  --name=elasticsearch \
  --net=host \
  --restart=always \
  -v /data/elasticsearch-7.17.9/config:/usr/share/elasticsearch/config \
  -v /data/elasticsearch-7.17.9/data:/usr/share/elasticsearch/data \
  -v /data/elasticsearch-7.17.9/logs:/usr/share/elasticsearch/logs \
  elasticsearch:7.17.9
```





### Docker集群部署Elasticsearch

#### 节点说明

为了组建集群，我准备了三台服务器，三台服务器之间的网络是互通的，分别是：

```
es-0：192.168.0.100
es-1：192.168.0.101
es-2：192.168.0.102
```



这里的地址应该是集群内网的地址，不应是外网地址，并且9300的端口需要映射或者和我一样使用host网络。



#### 配置说明

```yml
node.name: es-0
network.host: 192.168.0.100
cluster.name: es-cluster
node.master: true
node.data: true
discovery.seed_hosts: ["192.168.0.100:9300","192.168.0.101:9300","192.168.0.102:9300"]
cluster.initial_master_nodes: ["es-0","es-1","es-2"]

xpack.security.enabled: true
xpack.security.transport.ssl.enabled: true
xpack.security.transport.ssl.verification_mode: certificate
xpack.security.transport.ssl.keystore.path: /opt/elasticsearch/cert/elastic-certificates.p12
xpack.security.transport.ssl.truststore.path: /opt/elasticsearch/cert/elastic-certificates.p12
```



- node.name：elasticsearch节点的名称，随意，但每个节点不能重复。
- network.host：提供服务的IP地址，一般配置为节点所在服务器的内网地址。此配置会导致节点由开发模式转为生产模式，从而触发引导检查。
- http.port：服务端口号，默认9200，通常范围为9200~9299
- transport.port：集群通信端口，默认9300，通常范围为9300~9399
- cluster.name：集群的名称，自己取。但每个节点的集群名称必须一致。
- node.master：是否为master节点
- node.data：是否存储数据
- discovery.seed_hosts：此设置提供集群中其他候选节点的列表，并且可能处于活动状态且可联系以播种发现过程。可以是IP地址，也可以是可以解析为IP地址的域名。
- cluster.initial_master_nodes：指定集群初次选举中用到的候选节点，称为集群引导，只在第一次形成集群时需要。如配置network.host，则此配置为必须配置。重新启动节点或者将新节点添加到现有集群时，不要使用此配置。



#### 启动

ES的集群，各个节点的启动方式其实与单机是一样的，只是配置文件不同，需要增加一些集群的配置而已。



#### 验证

请求集群任意节点，查询集群的状态

```sh
curl http://192.168.0.100:9200/_cluster/state?pretty
```





