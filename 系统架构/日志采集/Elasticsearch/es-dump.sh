#!/bin/bash

set -ex

YESTODAY=$(date -d "1 day ago" +"%Y_%m_%d")
HOST=10.40.141.212:9200
WAREHOUSE=cloud_prod_elasticsearch
AUTH=ZWxhc3RpYzpJZTVjbVdTbzJPenZGVjRleGV4aQ==


curl --location --request PUT 'http://'${HOST}'/_snapshot/'${WAREHOUSE}'/'${YESTODAY} \
--header 'Content-Type: application/json' \
--header 'Authorization: Basic '${AUTH} \
--data '{
    "indices": [
        "cloud_prod_water_record_'${YESTODAY}'_doc",
        "cloud_prod_mqtt_message_'${YESTODAY}'_doc",
        "cloud_prod_device_event_info_'${YESTODAY}'_doc",
        "cloud_prod_work_record_'${YESTODAY}'_doc",
        "cloud_prod_http_trace_'${YESTODAY}'_doc",
        "cloud_prod_drink_water_record_'${YESTODAY}'_doc",
        "cloud_prod_member_action_'${YESTODAY}'_doc",
        "cloud_prod_pet_round_record_'${YESTODAY}'_doc",
        "cloud_prod_mqtt_message_retry_doc",
        "cloud_prod_collect_message_doc",
        "cloud_prod_device_record_doc",
        "cloud_prod_audit_record_doc",
        "cloud_prod_feeding_record_doc",
        "cloud_prod_drink_water_record_week_doc",
        "cloud_prod_drink_water_record_month_doc",
        "cloud_prod_drink_water_record_year_doc",
        "cloud_prod_pet_round_day_record_doc",
        "cloud_prod_pet_round_year_record_doc",
        "cloud_prod_pet_round_month_record_doc",
        "cloud_prod_pet_round_week_record_doc",
        "cloud_prod_pet_identify_event_doc"
    ],
    "ignore_unavailable": true,
    "include_global_state": false
}'