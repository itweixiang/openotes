#!/bin/bash
set -ex

ENTERPRISE_NAME=''
PROJECT_GROUP=''
PROJECT_NAME=''
REMOTE_WAREHOUSE=''

npm install --unsafe-perm=true --allow-root --force
npm run build
tar -zcvf dist.tar.gz dist

LAST_IMAGE=$(docker images | grep ${REMOTE_WAREHOUSE}/${ENTERPRISE_NAME}/${PROJECT_GROUP}/${PROJECT_NAME}/${GIT_BRANCH} | awk {'print $3'})
if [ -z "$LAST_IMAGE" ]; then
  echo "not exit images"
else
  docker rmi ${REMOTE_WAREHOUSE}/${ENTERPRISE_NAME}/${PROJECT_GROUP}/${PROJECT_NAME}/${GIT_BRANCH}:latest
fi
docker build -t ${REMOTE_WAREHOUSE}/${ENTERPRISE_NAME}/${PROJECT_GROUP}/${PROJECT_NAME}/${GIT_BRANCH}:latest .
docker push ${REMOTE_WAREHOUSE}/${ENTERPRISE_NAME}/${PROJECT_GROUP}/${PROJECT_NAME}/${GIT_BRANCH}:latest
