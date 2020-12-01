::@echo off
:: docker容器相关设置
set NAME=jmeter
set IMAGE=justb4/jmeter:5.3

:: 替换测试计划中的变量 
for /f "tokens=4" %%a in ('route print^|findstr 0.0.0.0.*0.0.0.0') do (
 set IP=%%a
)
set TARGET_PORT=3000
set TARGET_TEST_CASES=1

:: 指定文件位置 
set DIR_IN_HOST=jmeter
set DIR_IN_DOCKER=/tests
set REPORT_DIR=report
set REPORT_IN_HOST=%DIR_IN_HOST%\%REPORT_DIR%
set REPORT_IN_DOCKER=%DIR_IN_DOCKER%/%REPORT_DIR%


for /f "delims=." %%p in ('dir /b .\%DIR_IN_HOST%\*.jmx') do call :runOnePlan %%p
:: 执行单个测试计划
:runOnePlan
  :: Reporting dir: start fresh
  rd/s/q %REPORT_IN_HOST%\%1 
  md  %REPORT_IN_HOST%\%1

  del %DIR_IN_HOST%\%1.jtl %DIR_IN_HOST%\%1-jmeter.log  

  docker stop %NAME% 
  docker rm %NAME% 
  docker run --name %NAME% -i -v %~dp0%DIR_IN_HOST%:%DIR_IN_DOCKER% %IMAGE% ^
    -Dlog_level.jmeter=INFO ^
    -Jhost=%IP% -Jport=%TARGET_PORT% -JtestCases=%TARGET_TEST_CASES% ^
    -n -t %DIR_IN_DOCKER%/%1.jmx -l %DIR_IN_DOCKER%/%1.jtl -j %DIR_IN_DOCKER%/%1-jmeter.log ^
    -e -o %REPORT_IN_DOCKER%/%1

  echo ==== jmeter.log ====
  type %DIR_IN_HOST%\%1-jmeter.log

  echo ==== Raw Test Report ====
  type %DIR_IN_HOST%\%1.jtl

  echo ==== HTML Test Report ====
  echo See HTML test report in %REPORT_IN_HOST%\%1index.html
goto :eof