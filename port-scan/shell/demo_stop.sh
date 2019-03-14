#!/bin/bash

datetime=`date +%Y-%m-%d_%H:%M:%S`

echo "停服..当前时间："$datetime

ports=`ps -ef |grep "demo.jar" | awk '{print $2}'`
for serverPort in $ports
do 
 kill $serverPort
 echo "关闭进程："$serverPort
done

echo "ps -ef |grep jar -> "`ps -ef |grep jar`


