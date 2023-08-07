### 数据导出mongodump

- mongodump参数

| 参数                     | 含义                                       | 默认值    | 例子                           |
| ------------------------ | ------------------------------------------ | --------- | ------------------------------ |
| -u                       | 账号                                       |           | -u root                        |
| -p                       | 密码                                       |           | -p Dl@admin123                 |
| -h                       | IP地址                                     | 127.0.0.1 | -h 10.30.0.6:27017             |
| -d                       | 数据库名称                                 |           | -d dl_cloud                    |
| --authenticationDatabase | 授权的数据库<br />与数据库名称相同可以不写 |           | --authenticationDatabase admin |
|                          |                                            |           |                                |
|                          |                                            |           |                                |



- 下载

```sh
wget https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2004-x86_64-100.7.4.tgz
tar -xf mongodb-database-tools-ubuntu2004-x86_64-100.7.4.tgz
```



- 导出

```sh
 mongodump \
 -h 127.0.0.1:27017 \
 -u cloud \
 -p Dl@admin123 \
 -d dl_cloud \
 -o /dump
```



- 备份数据至机房

```sh
#!/bin/bash
set -ex
PATH=${PATH}:/data/mongodb-database-tools-ubuntu2004-x86_64-100.7.4/bin
# 备份的环境
ENV=${ENV:-test}
#MySQL用户名
USERNAME=admin
#MySQL用户密码
PASSWORD=Dl@admin123
#MySQL数据库地址
IP=10.30.0.6
#MySQL数据库端口
PORT=27017
#需要备份的数据名称
DATABASE=dl_cloud
#备份的目录
BACK_DIR=/data/back/${ENV}/mongo/${DATABASE}
#授权的数据库
AUTH=admin

echo "==================BACK ${ENV} START=================="
mkdir -p ${BACK_DIR}
cd ${BACK_DIR}
rm -rf ${BACK_DIR}/dump

mongodump -h ${IP}:${PORT} \
        -u ${USERNAME} \
        -p ${PASSWORD} \
        -d ${DATABASE} \
        --authenticationDatabase ${AUTH} \
        -o ${BACK_DIR}/dump
tar -zcvf ${ENV}-${DATABASE}-backup-$(date +%Y-%m-%d).tar.gz ${BACK_DIR}/dump

# 删除x天前的备份
LAST_BACK_NAME=${ENV}-${SERVICE_NAME}-backup-$(date -d  '7 days ago' +%Y-%m-%d).tar.gz
rm -f ${BACK_DIR}/${LAST_BACK_NAME}
echo "==================BACK ${ENV} END=================="
```





### 数据导入mongorestore 



- mongorestore 参数

| 参数   | 含义                           | 默认值    | 例子                 |
| ------ | ------------------------------ | --------- | -------------------- |
| -u     | 账号                           |           | -u root              |
| -p     | 密码                           |           | -p Dl@admin123       |
| -h     | IP地址                         | 127.0.0.1 | -h 10.30.0.6:27017   |
| -d     | 数据库名称，可以和原先的不一样 |           | -d dl_cloud          |
| --drop | 恢复前先删除原先的数据库       |           | --drop               |
| --dir  | 恢复文件的路径                 |           | --dir /dump/dl_cloud |
|        |                                |           |                      |



- 导入

```sh
 mongorestore \
 -h 127.0.0.1:27017 \
 -u cloud \
 -p Dl@admin123 \
 -d dl_cloud \
 --dir /dump/dl_cloud \
 --drop
```



