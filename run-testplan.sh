#!/bin/bash

# docker容器相关设置
NAME="jmeter"
IMAGE="justb4/jmeter:5.3"

# 替换测试计划中的变量 
export TARGET_HOST=$(ifconfig en0 | awk '/inet / { print $2 }')
export TARGET_PORT="3000"
export TARGET_TEST_CASES=1

# 指定文件位置 
DIR_IN_HOST=jmeter
DIR_IN_DOCKER=/tests
REPORT_DIR=report
REPORT_IN_HOST=${DIR_IN_HOST}/${REPORT_DIR}
REPORT_IN_DOCKER=${DIR_IN_DOCKER}/${REPORT_DIR}

# 执行单个测试计划
runOnePlan(){
  # Reporting dir: start fresh
  rm -rf ${REPORT_IN_HOST}/$1 > /dev/null 2>&1
  mkdir -p ${REPORT_IN_HOST}/$1

  /bin/rm -f ${DIR_IN_HOST}/$1.jtl ${DIR_IN_HOST}/$1-jmeter.log  > /dev/null 2>&1

  docker stop ${NAME} > /dev/null 2>&1
  docker rm ${NAME} > /dev/null 2>&1
  docker run --name ${NAME} -i -v ${PWD}/${DIR_IN_HOST}:${DIR_IN_DOCKER} ${IMAGE} \
    -Dlog_level.jmeter=INFO \
    -Jhost=${TARGET_HOST} -Jport=${TARGET_PORT} -JtestCases=${TARGET_TEST_CASES}\
    -n -t ${DIR_IN_DOCKER}/$1.jmx -l ${DIR_IN_DOCKER}/$1.jtl -j ${DIR_IN_DOCKER}/$1-jmeter.log \
    -e -o ${REPORT_IN_DOCKER}/$1

  echo "==== jmeter.log ===="
  cat ${DIR_IN_HOST}/$1-jmeter.log

  echo "==== Raw Test Report ===="
  cat ${DIR_IN_HOST}/$1.jtl

  echo "==== HTML Test Report ===="
  echo "See HTML test report in ${REPORT_IN_HOST}/$1/index.html"
}

for file in $(ls ./${DIR_IN_HOST}/*.jmx)
do
  plan=${file#./${DIR_IN_HOST}/}
  plan=${plan%.jmx}
  runOnePlan $plan
done