::@echo off

:: 获取电脑本机IP
::@echo off
for /f "tokens=4" %%a in ('route print^|findstr 0.0.0.0.*0.0.0.0') do (
 set IP=%%a
) 
echo 获得本机IP地址%IP%
:: 生成测试计划
docker run --rm -v %~dp0jmeter:\tests openapitools/openapi-generator-cli generate -i http://%IP%:3000/oas -g jmeter -o \tests