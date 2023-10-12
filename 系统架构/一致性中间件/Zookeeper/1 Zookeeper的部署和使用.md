### Zookeeper基本概念

Zookeeper是一个能提供`较高一致性操作`的中间件。

Zookeeper以数据节点的方式提供服务，其中有四种节点类型：

- 临时无序节点，
- 临时有序节点，
- 持久化无序节点，
- 持久化无序节点，



### Zookeeper单机部署

可以从官网`https://zookeeper.apache.org/releases.html`的网页上，获取Zookeeper各个版本的下载链接，这里我选择当前最新3.9.0的版本。



Zookeeper为服务端软件，建议使用Linux系统，通过命令行安装：

```sh
# Zookeeper官网的下载链接会变，不用记住这个链接，
wget https://dlcdn.apache.org/zookeeper/zookeeper-3.9.0/apache-zookeeper-3.9.0-bin.tar.gz
```

使用wget下载Zookeeper，如果系统没有安装wget，Centos\Rehat系统需要`sudo yum install -y wget `，Debian\Ubuntu系统需要`sudo apt install -y wget`，进行安装。



下载好后，可以看到有个apache-zookeeper-3.9.0-bin.tar.gz的压缩包：

```sh
# 查看当前路径下的文件
root@ubuntu:/data# ls
apache-zookeeper-3.9.0-bin.tar.gz
```



解压压缩包：

```sh
# 解压Zookeeper压缩包
root@ubuntu:/data# tar -xf apache-zookeeper-3.9.0-bin.tar.gz
# 查看解压后的文件
root@ubuntu:/data# ls
apache-zookeeper-3.9.0-bin  apache-zookeeper-3.9.0-bin.tar.gz
```



进入到解压后的apache-zookeeper-3.9.0-bin目录中：

```sh
# 进入文件夹
root@ubuntu:/data# cd apache-zookeeper-3.9.0-bin/
# 查看Zookeeper安装包的内容
root@ubuntu:/data/apache-zookeeper-3.9.0-bin# ls
bin  conf  docs  lib  LICENSE.txt  NOTICE.txt  README.md  README_packaging.md
```



开源项目的文件目录都挺规范的，其中各个目录的作用如下：

- bin，存储Zookeeper的脚本
- conf，存储Zookeeper的配置
- docs，存储Zookeeper的使用文档，写的也挺详细的，但是是英文的，感兴趣的也可以看下
- lib，存储Zookeeper的依赖包
- LICENSE.txt，为开源许可证
- NOTICE.txt，
- README.md，
- README_packaging.md，



看到这里，朋友们可能会疑惑？怎么没有存数据的目录？

也可以反过来想，Zookeeper怎么知道我们的数据要存在哪？需要我们在conf目录下的配置文件指定数据存储的目录。



所以看看conf都有哪些配置：

```sh
root@ubuntu:/data/apache-zookeeper-3.9.0-bin# ls conf
configuration.xsl  logback.xml  zoo_sample.cfg
```



Zookeeper默认的主配置文件叫做`zoo.cfg`，但是在conf目录下却没有，`configuration.xsl`为xml的约束文件，`logback.xml`为日志配置，`zoo_sample.cfg`为主配置的模板。



所以我们可以参考主配置的模板，自己创建一个zoo.cfg文件，其中比较重要的，是创建和指定Zookeeper的存储目录

```sh
echo "tickTime=2000
initLimit=10
syncLimit=5
# 指定Zookeeper的数据存储目录
dataDir=/data/apache-zookeeper-3.9.0-bin/data
clientPort=2181 " > /data/apache-zookeeper-3.9.0-bin/conf/zoo.cfg
```




### Zookeeper命令行使用





