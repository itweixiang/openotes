#!/bin/bash

set -ex
# 防止nginx没有权限而导致403
chmod 777 -R /target
rm -rf /target/*
tar -xvf /source/dist.tar.gz --strip-components 1 -C /target
chmod 777 -R /target
ls /target
