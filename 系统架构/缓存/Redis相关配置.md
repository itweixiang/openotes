### 基础配置

```properties
# redis的端口
port 6379

# 访问redis的密码
requirepass Dl@admin123

# 绑定的IP
# 如果本机，则127.0.0.0
# 如果公开，则0.0.0.0
# 如果内网，则192.168.0.x,10.30.0.x等等
bind 127.0.0.0

# 保护模式，需要使用密码访问Redis，或者是bind的ip访问
protected-mode yes

# 是否后台进程启动
daemonize no

# 数据库数量
databases 16

# 客户端的数量
maxclients 1000

# redis可用的内存
maxmemory 1gb

# 内存满了的驱逐策略
# volatile-lru：使用近似 LRU 算法移除，仅适用于设置了过期时间的 key。
# allkeys-lru：使用近似 LRU 算法移除，可适用于所有类型的 key。
# volatile-lfu：使用近似 LFU 算法移除，仅适用于设置了过期时间的 key。
# allkeys-lfu：使用近似 LFU 算法移除，可适用于所有类型的 key。
# volatile-random：随机移除一个 key，仅适用于设置了过期时间的 key。
# allkeys-random：随机移除一个 key，可适用于所有类型的 key。
# volatile-ttl：移除距离过期时间最近的 key。
# noeviction：不移除任何内容，只是在写操作时返回一个错误，默认值。
maxmamory-policy noeviction
```



### RDB和AOF

```properties
# RDB和AOF的文件存储路径
dir ./

# RDB的文件名称
dbfilename dump.rdb

# 900秒内有1个更改
# 300秒内有10个更改
# 60秒内有10000个更改
# 则将内存中的数据快照写入磁盘
save 900 1
save 300 10
save 60 10000

# 是否压缩RDB文件
rdbcompression yes

# 是否开启AOF
appendonly yes

# AOF的文件名称
appendfilename "appendonly.aof"

# AOF的落盘策略
# no：表示等操作系统进行数据缓存同步到磁盘（快）
# always：表示每次更新操作后手动调用 fsync() 将数据写到磁盘（慢，安全）
# everysec：表示每秒同步一次（折中，默认值）
appendfsync everysec

# RDB的save或者AOF重写时，会占用大量性能，appendfsync设置为no
no-appendfsync-on-rewrite no

# RDB和AOF混合持久化，也称为AOF重写
# 将RDB文件写入到AOF文件中
# AOF文件的前面是RDB文件，后面才是AOF的内容
# 数据恢复时，先读取前面的RDB文件进行恢复，然后再读取AOF文件恢复
aof-use-rdb-preamble yes

# 当前AOF文件比上次重写后的AOF文件大小的增长比例超过100，则触发AOF重写
auto-aof-rewrite-percentage 100

# 当前AOF文件的文件大小大于64MB，则触发AOF重写
auto-aof-rewrite-min-size 64mb

# 设置为0则禁用AOF重写
# auto-aof-rewrite-percentage no
```



### 集群配置

```properties
# master的密码。如果和requirepass相同，可以不用配置。
masterauth Dl@admin123

# 开启集群模式
cluster-enabled yes
```

