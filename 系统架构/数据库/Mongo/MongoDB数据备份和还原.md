### 数据导出mongodump

- mongodump参数

| 参数                     | 含义         | 默认值    | 例子               |
| ------------------------ | ------------ | --------- | ------------------ |
| -u                       | 账号         |           | -u root            |
| -p                       | 密码         |           | -p Dl@admin123     |
| -h                       | IP地址       | 127.0.0.1 | -h 10.30.0.6:27017 |
| -d                       | 数据库名称   |           | -d dl_cloud        |
| --authenticationDatabase | 授权的数据库 |           | --all-databases    |
|                          |              |           |                    |
|                          |              |           |                    |



- 导出

```sh
 mongodump \
 -h 127.0.0.1:27017 \
 -u cloud \
 -p Dl@admin123 \
 -d dl_cloud \
 -o /dump
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



