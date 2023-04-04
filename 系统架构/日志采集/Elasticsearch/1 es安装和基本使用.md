

### ES下载

官网的下载地址：`https://www.elastic.co/cn/downloads/elasticsearch`



找到适合的版本，因为我的系统是Ubuntu，所以选择Linux X86-64的压缩包
```shell
# 下载
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.7.0-linux-x86_64.tar.gz

# 解压
tar -xvf elasticsearch-7.17.9-linux-x86_64.tar.gz
```



解压完进入安装包里面，看下目录结构

> root@ubuntu:/data# cd elasticsearch-7.17.9/
> root@ubuntu:/data/elasticsearch-7.17.9# ls
> bin  config  jdk  lib  LICENSE.txt  logs  modules  NOTICE.txt  plugins  README.asciidoc



- bin：es的启动脚本等
- config：es的配置文件
- jdk：默认自带jdk，如果系统有`JAVA_HOME`的话，会使用`JAVA_HOME`
- lib：
- logs：
- module：
- plugins：
- LICENSE.txt：
- README.asciidoc：



### ES启动

进入bin目录，先看下有哪些脚本

> root@ubuntu:/data/elasticsearch-7.17.9/bin# ls
> elasticsearch           elasticsearch-croneval       elasticsearch-keystore  elasticsearch-saml-metadata    elasticsearch-sql-cli             x-pack-env
> elasticsearch-certgen   elasticsearch-env            elasticsearch-migrate   elasticsearch-service-tokens   elasticsearch-sql-cli-7.17.9.jar  x-pack-security-env
> elasticsearch-certutil  elasticsearch-env-from-file  elasticsearch-node      elasticsearch-setup-passwords  elasticsearch-syskeygen           x-pack-watcher-env
> elasticsearch-cli       elasticsearch-geoip          elasticsearch-plugin    elasticsearch-shard            elasticsearch-users





很多脚本我也不大会用，但这个`elasticsearch`的文件，就是ES的启动脚本，直接`./elasticsearch`启动即可



会报一个root用户不能启动的错误，直接用root启动只是方便而已，但是会有安全问题

> java.lang.RuntimeException: can not run elasticsearch as root
>         at org.elasticsearch.bootstrap.Bootstrap.initializeNatives(Bootstrap.java:107)
>         at org.elasticsearch.bootstrap.Bootstrap.setup(Bootstrap.java:183)
>         at org.elasticsearch.bootstrap.Bootstrap.init(Bootstrap.java:434)
>         at org.elasticsearch.bootstrap.Elasticsearch.init(Elasticsearch.java:169)
>         at org.elasticsearch.bootstrap.Elasticsearch.execute(Elasticsearch.java:160)
>         at org.elasticsearch.cli.EnvironmentAwareCommand.execute(EnvironmentAwareCommand.java:77)
>         at org.elasticsearch.cli.Command.mainWithoutErrorHandling(Command.java:112)
>         at org.elasticsearch.cli.Command.main(Command.java:77)
>         at org.elasticsearch.bootstrap.Elasticsearch.main(Elasticsearch.java:125)
>         at org.elasticsearch.bootstrap.Elasticsearch.main(Elasticsearch.java:80)
> For complete error details, refer to the log at /data/elasticsearch-7.17.9/logs/elasticsearch.log



切换到系统自带的用户，也可以创建专门的用户，并对es的安装目录进行授权

```sh
# 切换账户，也可以自己创建新账户
su ubuntu

# 授权，sudo需要输入密码
sudo chown -R ubuntu /data

# 切换到es的bin目录
cd /data/elasticsearch-7.17.9/bin/

# 启动es
./elasticsearch
```



es启动比较耗资源，需要等个几十秒。



如果有打印日志，并且日志打印的差不多，没有明显报错。

那么新开一个窗口，用curl掉一下es的端口，出现如下的类似信息说明安装成功

> root@ubuntu:~# curl localhost:9200
> {
>   "name" : "ubuntu",
>   "cluster_name" : "elasticsearch",
>   "cluster_uuid" : "JkpJ6HiHSiKco3J1rPFSWg",
>   "version" : {
>     "number" : "7.17.9",
>     "build_flavor" : "default",
>     "build_type" : "tar",
>     "build_hash" : "ef48222227ee6b9e70e502f0f0daa52435ee634d",
>     "build_date" : "2023-01-31T05:34:43.305517834Z",
>     "build_snapshot" : false,
>     "lucene_version" : "8.11.1",
>     "minimum_wire_compatibility_version" : "6.8.0",
>     "minimum_index_compatibility_version" : "6.0.0-beta1"
>   },
>   "tagline" : "You Know, for Search"
> }



### ES配置

因为我是用虚拟机启动的ES，和我本地Windows不是同一台机器，所以在浏览器访问ES，会出现访问不通的情况。

另外，在一些内存比较小的机器，也应该适当限制一些ES的堆内存大小，以减少内存占用。



所以看下ES配置文件

> ubuntu@ubuntu:/data/elasticsearch-7.17.9/config$ ls
> elasticsearch.keystore  elasticsearch-plugins.example.yml  elasticsearch.yml  jvm.options  jvm.options.d  log4j2.properties  role_mapping.yml  roles.yml  users  users_roles



elasticsearch.yml为ES的主配置文件

jvm.options为ES的Java虚拟机配置文件