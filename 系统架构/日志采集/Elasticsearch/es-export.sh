#!/bin/bash

set -ex

YESTODAY=$(date -d "1 day ago" +"%Y_%m_%d")
HOST=10.40.10.108:9200
WAREHOUSE=cloud_prod_elasticsearch
AUTH=ZWxhc3RpYzpiM1hCejdHUDNHdmpxdjFneW54QQ==

# 删除仓库
curl --location --request DELETE 'http://'${HOST}'/_snapshot/'${WAREHOUSE} \
--header 'Authorization: Basic '${AUTH}

# 重建仓库
curl --location --request PUT 'http://'${HOST}'/_snapshot/'${WAREHOUSE} \
--header 'Content-Type: application/json' \
--header 'Authorization: Basic '${AUTH} \
--data '{
    "type": "s3",
    "settings": {
        "bucket": "petlibro-s3-data-backup",
        "endpoint": "s3.us-east-1.amazonaws.com",
        "compress": true,
        "disable_chunked_encoding": true,
        "base_path": "cloud-prod/elasticsearch",
        "max_snapshot_bytes_per_sec": "80mb",
        "max_restore_bytes_per_sec": "80mb"
    }
}'


# 恢复索引
curl --location --request POST 'http://'${HOST}'/_snapshot/'${WAREHOUSE}'/'${YESTODAY}'/_restore' \
--header 'Content-Type: application/json' \
--header 'Authorization: Basic '${AUTH} \
--data '{
    "indices": [
        "cloud_prod_device_event_info_'${YESTODAY}'_doc",
        "cloud_prod_http_trace_'${YESTODAY}'_doc"
    ],
    "index_settings": {
        "index.number_of_replicas": 1
    }
}'