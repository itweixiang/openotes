

### 安装redis-dump

redis-dump由ruby编写，所以需要先安装ruby。

redis-dump对ruby的版本有要求，os源中的ruby版本不支持。

所以需要先使用rvm安装高版本的ruby。



- 安装rvm

```sh
# 安装
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
source /etc/profile.d/rvm.sh
# 查看版本
rvm -v
```



-  安装ruby

```sh
# 查看可用的版本
rvm list known

# 安装ruby3
rvm install 3
```



- 安装redis-dump

```
gem install redis-dump
```



### 导出redis数据

- redis-dump相关参数

> root@dev:~# redis-dump -h
>   Try: /usr/local/rvm/gems/ruby-3.0.0/bin/redis-dump show-commands
> Usage: /usr/local/rvm/gems/ruby-3.0.0/bin/redis-dump [global options] COMMAND [command options] 
>     -u, --uri=S                      Redis URI (e.g. redis://hostname[:port])
>     -d, --database=S                 Redis database (e.g. -d 15)
>     -a, --password=S                 Redis password (e.g. -a 'my@pass/word')
>     -s, --sleep=S                    Sleep for S seconds after dumping (for debugging)
>     -c, --count=S                    Chunk size (default: 10000)
>     -f, --filter=S                   Filter selected keys (passed directly to redis' KEYS command)
>     -b, --base64                     Encode key values as base64 (useful for binary values)
>     -O, --without_optimizations      Disable run time optimizations
>     -V, --version                    Display version
>     -D, --debug
>         --nosafe



- 导出

```sh
redis-dump -u 127.0.0.1:6379 -a Dl@admin123 > redis.json
```



### 导入redis数据

- redis-load相关参数

> root@dev:~# redis-load -h
>   Try: /usr/local/rvm/gems/ruby-3.0.0/bin/redis-load show-commands
> Usage: /usr/local/rvm/gems/ruby-3.0.0/bin/redis-load [global options] COMMAND [command options] 
>     -u, --uri=S                      Redis URI (e.g. redis://hostname[:port])
>     -d, --database=S                 Redis database (e.g. -d 15)
>     -a, --password=S                 Redis password (e.g. -a 'my@pass/word')
>     -s, --sleep=S                    Sleep for S seconds after dumping (for debugging)
>     -b, --base64                     Decode key values from base64 (used with redis-dump -b)
>     -n, --no_check_utf8
>     -V, --version                    Display version
>     -D, --debug
>         --nosafe



- 导入

```sh
redis-load -u 127.0.0.1:6379 -a Dl@admin123 < redis.json
```

