

### Java客户端





### Web工具





#### Kibana

```sh
docker run -d \
--name=kibana \
--restart=always \
--privileged=true \
-p 5601:5601 \
-v /data/kibana/conf:/usr/share/kibana/config \
kibana:7.17.9
```



```yml
i18n.locale: "zh-CN"
server.host: "0.0.0.0"
server.shutdownTimeout: "5s"
elasticsearch.hosts: [ "http://192.168.0.100:9200" ]
elasticsearch.username: "elastic"
elasticsearch.password: "abcd1234"
monitoring.ui.container.elasticsearch.enabled: true
```

