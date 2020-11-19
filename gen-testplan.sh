#!/bin/sh

# 获取本机IP地址
HOST_IP=$(ifconfig en0 | awk '/inet / { print $2 }')

echo '获得本机IP地址：'$HOST_IP

# 生成测试计划
docker run --rm -v ${PWD}/jmeter:/tests openapitools/openapi-generator-cli generate -i http://$HOST_IP:3000/oas -g jmeter -o /tests