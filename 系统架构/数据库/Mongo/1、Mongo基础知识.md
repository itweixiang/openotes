### 下载安装



### 常用命令

| 命令                                       | 说明                                                         |
| ------------------------------------------ | ------------------------------------------------------------ |
| show dbs \| show database                  | 查看所有数据库                                               |
| use 数据库名                               | 切换数据库，不存在则创建                                     |
| db.dropDatabase()                          | 删除数据库                                                   |
| show tables \| show collections            | 查看当前数据库的所有集合                                     |
| db.createCollection(name,opts)             | 创建集合，集合不存在时也会创建集合<br />capped=boolean，集合大小。最新的覆盖最早的。<br />size=long，集合的占用空间，capped=true时需要指定。<br />max=long，文档的最大数量 |
| db.集合名.stats                            | 查看集合详情                                                 |
| db.集合名.drop()                           | 删除集合                                                     |
| db.createUser({user:"",pwd:"",roles:[""]}) | 创建用户<br />user用户名<br />pwd密码<br />roles权限         |
| show users                                 | 查看当前数据库的用户列表                                     |
| show roles                                 | 查看当前数据库的角色列表                                     |
| show profile                               | 查看最近执行命令                                             |
| exit \| quit()                             | 退出shell                                                    |
| help                                       | 帮助                                                         |
| db.help()                                  | 查看当前数据库支持的命令                                     |
| db.集合名.help()                           | 查看当前集合支持的命令                                       |
| db.version()                               | 查看mongo版本                                                |



### 用户管理

- 创建管理员

创建管理员需要先切到admin数据库。

```
use admin
```



创建管理员，指定roles=root

```
db.createUser({user:"username",pwd:"password",roles:["root"]})
```





### 用户权限

| 权限                 | 说明                                                         |
| -------------------- | ------------------------------------------------------------ |
| read                 | 允许用户读取指定数据库                                       |
| readWrite            | 允许用户读写指定数据库                                       |
| dbAdmin              | 允许用户在指定数据库中执行管理函数<br />如索引创建、删除，查看统计或访问system.profile |
| userAdmin            | 允许用户向system.users集合写入<br />可以在指定数据库里创建、删除和管理用户 |
| clusterAdmin         | 只在admin数据库中可用<br />赋予用户所有分片和复制集相关函数的管理权限。 |
| readAnyDatabase      | 只在admin数据库中可用<br />赋予用户所有数据库的读权限        |
| readWriteAnyDatabase | 只在admin数据库中可用<br />赋予用户所有数据库的读写权限      |
| userAdminAnyDatabase | 只在admin数据库中可用<br />赋予用户所有数据库的userAdmin权限 |
| dbAdminAnyDatabase   | 只在admin数据库中可用<br />赋予用户所有数据库的dbAdmin权限   |
| root                 | 超级账号，超级权限                                           |





### 高级特性

- $projetct

将原始字段改个别名，也可以筛选出需要的指定字段

```
db.book.aggregate([
    {
        $project: {
        	name:$title,//别名:$原始字段
        	_id:0,//原始字段:0，0不显示。_id默认显示，其他字段默认不显示
        	author:1//原始字段:1，显示。
        }
    }
])
```





- $match

```
db.books.aggregate([
	{
		$match:{
			key:"value"//具体筛选的字段名和值，可以多个键值对
		}
	}
])
```



- $count

```
db.books.aggregate([
	{
		$match:{
			key:"value"
		}
	},{
		$count:doc_count //计算$match后的文档数量，并赋值给doc
	}
])
```

