

### Docker单机部署Elasticsearch

使用docker部署的方式，可以尽量减少原生系统的影响，而且隔离性和运维成本也更优秀。

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

我自己试过很多次，必须要777权限，可读可写可执行才行。

```
chmod -R 777 /data/elasticsearch-7.17.9
```



#### 启动

elasticsearch的默认端口是9200，集群通信端口是9300。为了方便，我一般是让es使用宿主机的网络，懒得去做端口映射。

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

为了组建集群，我准备了三台服务器，三个节点之间的网络是互通的，分别是：

```
es-0：192.168.0.100
es-1：192.168.0.101
es-2：192.168.0.102
```



这里的地址应该是集群内网的地址，不应是外网地址，并且9300的端口需要打开。



#### 配置说明





```yml
node.name: es-0
network.host: 192.168.0.100
cluster.name: es-cluster
node.master: true
node.data: true
node.max_local_storage_nodes: 3
discovery.seed_hosts: ["192.168.0.100:9300","192.168.0.101:9300","192.168.0.102:9300"]
cluster.initial_master_nodes: ["es-0","es-1","es-2"]
```





#### 验证

```sh
curl http://192.168.0.100:9200/_cluster/state?pretty
```



