

### Docker单机部署Elasticsearch



```
chmod -R 777 /data/elasticsearch
```



```sh
docker run -d \
  --name=elasticsearch \
  --net=host \
  --restart=always \
  -v /data/elasticsearch/conf/jvm.options:/usr/share/elasticsearch/config/jvm.options \
  -v /data/elasticsearch/conf/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
  -v /data/elasticsearch/data:/usr/share/elasticsearch/data \
  -v /data/elasticsearch/logs:/usr/share/elasticsearch/logs \
  elasticsearch:7.17.9
```



