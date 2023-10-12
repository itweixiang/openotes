

### 一、elasticdump

#### 1、elasticdump安装

elasticdump由js编写，npm有提供安装包，所以需要先安装nodejs和npm

以下是ubuntu\debian的安装方式

```sh
apt install -y nodejs npm
npm install elasticdump
```



安装后出现这个，就说明安装成功

> + elasticdump@6.103.0
> added 128 packages from 200 contributors and audited 128 packages in 18.535s



安装完成后，会在当前路径生成node_modules目录。如果是root用户的根目录的话，则elasticdump会安装在这个目录

```sh
/root/node_modules/elasticdump/bin
```



#### 2、elasticdump导出导入

elasticdump一次只能导出单个索引。可以导出索引的配置，也可以导出索引的数据。



--input：为数据的来源，可以是导出后的文件，也可以是ES节点

--output：为数据导出的位置，可以是文件，也可以是ES节点

--limit：ES单次操作的数据量，例如有10W条数据，设置10000，则操作10次可以导完

username：为对应的用户名

password：为对应的密码，如果密码有特殊符号，需要用`''`包起来。例如`'abc@123'`

index_name：为对应的索引名称



- 导出索引的mapping和settings

```sh
elasticdump \
  --input=http://username:password@192.168.x.x:9200/index_name \
  --output=./filename.json \
  --limit=10000 \
  --type=index
```



没有设置密码则

```sh
elasticdump \
  --input=http://192.168.x.x:9200/index_name \
  --output=./filename.json \
  --limit=10000 \
  --type=index
```



- 导出索引的数据

```sh
elasticdump \
  --input=http://username:password@192.168.x.x:9200/index_name \
  --output=./filename.json \
  --limit=10000 \
  --type=data
```



- 从文件导入ES

```sh
elasticdump \
  --input=./filename.json \
  --output=http://username:password@192.168.x.x:9200/index_name \
  --limit=10000 \
  --type=index
```



- 导出索引至另一个ES

```sh
elasticdump \
  --input=http://username:password@192.168.x.x:9200/index_name \
  --output=http://username:password@192.168.x.x:9200/index_name \
  --limit=10000 \
  --type=index
```



### 二、OSS方式

ES官方支持S3的OSS备份，阿里云看一些案例也能支持

但是腾讯云的COS则实测不支持，需要自己安装插件



我们以S3为例。



#### 1、OSS备份

- 安装插件

如果是集群，其他相关节点也需要安装。安装完成后需要重启ES

```sh
elasticsearch-plugin install repository-s3
```



- 配置秘钥

```sh
elasticsearch-keystore add s3.client.default.access_key
elasticsearch-keystore add s3.client.default.secret_key
```



- 加载秘钥

如果是集群，需要将秘钥`elasticsearch.keystore`，拷贝到其他机器上

```sh
POST /_nodes/reload_secure_settings
```



- 创建快照仓库

your_repository_name：你自己定义的快照仓库名称

bucket：s3桶的名称

endpoint：亚马逊S3的地址

compress：是否压缩，建议开启，不然文件会很大

base_path：s3桶内的备份路径

disable_chunked_encoding：使用http协议

max_snapshot_bytes_per_sec：快照的上传速度

max_restore_bytes_per_sec：快照恢复时的下载速度

```sh
PUT /_snapshot/your_repository_name
{
    "type": "s3",
    "settings": {
        "bucket": "your-bucket-name",
        "endpoint": "s3.us-east-1.amazonaws.com",
        "compress": true,
        "disable_chunked_encoding": true,
        "base_path": "elasticsearch",
        "max_snapshot_bytes_per_sec": "500mb",
        "max_restore_bytes_per_sec": "500mb"
    }
}
```



- 创建索引快照

your_snapshot_name：你自己定义的快照名称

your_index_name ：你自己的索引名称，可以多个

wait_for_completion：等待完成后响应

```sh
PUT /_snapshot/your_repository_name/your_snapshot_name?wait_for_completion=true
{
    "indices": ["your_index_name"],
    "ignore_unavailable": true,
    "include_global_state": false
}
```





#### 2、OSS恢复

- 快照恢复

如果是跨集群，快照仓库需要一致

如果集群中已经有索引，此时会报错。

 可以指定replica数，但不能指定shard数

```sh
POST /_snapshot/your_repository_name/your_snapshot_name/_restore?wait_for_completion=true
{
    "indices": "your_index_name",
    "index_settings": {
        "index.number_of_replicas": 2
    }
}
```



#### 3、slm自动备份

- 每日备份

每日全量备份cloud_*的索引

```sh
PUT /_slm/policy/daily-snapshots
{
  "schedule": "0 30 1 * * ?", 
  "name": "<daily-snap-{now/d}>", 
  "repository": "backup", 
  "config": { 
    "indices": ["cloud_*"], 
    "ignore_unavailable": false,
    "include_global_state": false
  },
  "retention": { 
    "expire_after": "365d", 
    "min_count": 999, 
    "max_count": 999999 
  }
}
```



- 快照列表

```sh
GET /_snapshot/backup/*?verbose=false
```

