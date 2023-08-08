

### elasticdump安装

elasticdump由js编写，npm有提供安装包，所以需要先安装nodejs和npm

```sh
apt install -y nodejs
apt install -y npm
npm install elasticdump
```



安装后出现这个，就说明安装成功

> + elasticdump@6.103.0
> added 128 packages from 200 contributors and audited 128 packages in 18.535s



如果是root在根目录安装的，则elasticdump会安装在这个目录

```sh
/root/node_modules/elasticdump/bin
```



### elasticdump导出导入

elasticdump只能导出单索引



- 导出索引的mapping和settings

```sh
elasticdump \
  --input=http://elastic:OCbyFv3ihu0IMgelp7nK@10.30.0.6:9200/cloud_local_water_record_doc \
  --output=./cloud_local_water_record_doc.json \
  --type=index
```



- 导出索引的数据

```sh
elasticdump \
  --input=http://elastic:OCbyFv3ihu0IMgelp7nK@10.30.0.6:9200/cloud_local_water_record_doc \
  --output=./cloud_local_water_record_doc.json \
  --type=data
```



- 从文件导入ES

```sh
elasticdump \
  --input=./cloud_local_water_record_doc.json \
  --output=http://'elastic':'Dl@admin123'@10.18.0.70:9200/cloud_local_water_record_doc \
  --type=index
```



- 导出索引至另一个ES

```sh
elasticdump \
  --input=http://'elastic':'OCbyFv3ihu0IMgelp7nK'@10.30.0.6:9200/cloud_local_water_record_doc \
  --output=http://'elastic':'Dl@admin123'@10.18.0.70:9200/cloud_local_water_record_doc \
  --type=index
```



