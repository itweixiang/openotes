#!/bin/bash
set -ex

ENTERPRISE_NAME=''
PROJECT_GROUP=''
PROJECT_NAME=''
REMOTE_WAREHOUSE=('')

# 打jar包
mvn clean install  -Dmaven.test.skip=true

cp target/*.jar ./

# 删除旧的镜像
LAST_IMAGE=$(docker images | grep ${REMOTE_WAREHOUSE}/${ENTERPRISE_NAME}/${PROJECT_GROUP}/${PROJECT_NAME}/${GIT_BRANCH} | awk {'print $3'})
if [ -z "$LAST_IMAGE" ]; then
  echo "not exit images"
else
  docker rmi ${REMOTE_WAREHOUSE}/${ENTERPRISE_NAME}/${PROJECT_GROUP}/${PROJECT_NAME}/${GIT_BRANCH}:latest
fi
# 打包新的镜像
docker build -t ${REMOTE_WAREHOUSE}/${ENTERPRISE_NAME}/${PROJECT_GROUP}/${PROJECT_NAME}/${GIT_BRANCH}:latest .
docker push ${REMOTE_WAREHOUSE}/${ENTERPRISE_NAME}/${PROJECT_GROUP}/${PROJECT_NAME}/${GIT_BRANCH}:latest
