### 数据备份mysqlpump

- mysqlpump参数

| 参数                     | 含义                             | 默认值    | 例子                         |
| ------------------------ | -------------------------------- | --------- | ---------------------------- |
| -u                       | 账号                             |           | -uroot                       |
| -p                       | 密码                             |           | -pDl@admin123                |
| -h                       | IP地址                           | 127.0.0.1 | -h10.30.0.6                  |
| -P                       | 端口                             | 3306      | -P3306                       |
| --databases，-B          | 数据库名称，多个库之间用逗号分隔 |           | --databases dl_cloud,dl_mall |
| --all-databases，-A      | 导出所有数据库                   |           | --all-databases              |
| **--single-transaction** | **非事务，避免锁表**             |           | --single-transaction         |
| --default-parallelism    | 并行线程数                       | 2         | --default-parallelism 4      |



- linux

```sh
# apt install -y mysql-client-core-8.0 
# 需要先安装mysql的客户端
mysqlpump -uroot -pDl@admin123 --databases dl_cloud --single-transaction > /data/dl_cloud.sql
```



- docker

```sh
docker exec -it mysql mysqldump -uroot -pDl@admin123 --databases dl_cloud > /data/dl_cloud.sql
```



- 备份至机房脚本

```sh
#!/bin/bash
set -ex
# 备份的环境
ENV=${ENV:-test}
#本分的天数
BACK_DAY=7
#MySQL用户名
USERNAME=username
#MySQL用户密码
PASSWORD=password
#MySQL数据库地址
IP=x.x.x.x
#MySQL数据库端口
PORT=3306
#需要备份的数据名称
DATABASE=dbname
#备份的目录
BACK_DIR=/data/back/${ENV}/${DATABASE}

echo "==================BACK ${ENV} START=================="
mkdir -p ${BACK_DIR}
cd ${BACK_DIR}

mysqlpump -h${IP} -u${USERNAME} -p${PASSWORD} --databases ${DATABASE} -P${PORT} --single-transaction > ${DATABASE}.sql
tar -zcvf ${ENV}-${DATABASE}-backup-$(date +%Y-%m-%d).tar.gz ${DATABASE}.sql

# 删除x天前的备份
LAST_BACK_NAME=${ENV}-${SERVICE_NAME}-backup-$(date -d '${BACK_DAY} days ago' +%Y-%m-%d).tar.gz
rm -f ${BACK_DIR}/${LAST_BACK_NAME}
echo "==================BACK ${ENV} END=================="
```



### 数据还原mysql

| 参数 | 含义   | 默认值    | 例子             |
| ---- | ------ | --------- | ---------------- |
| -u   | 账号   |           | -uroot           |
| -p   | 密码   |           | -pDl@admin123    |
| -h   | IP地址 | 127.0.0.1 | -h18.234.174.121 |
| -P   | 端口   | 3306      | -P3306           |
|      |        |           |                  |
|      |        |           |                  |
|      |        |           |                  |



将数据拷贝到mysql的数据目录，进入mysql容器执行

```sh
mysql -uroot -pDl@admin123 < /var/lib/mysql/dl_cloud.sql
```



```sh
docker exec -it mysql mysql -uroot -pDl@admin123 dl_cloud < dl_cloud.sql
```

