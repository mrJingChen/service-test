#!/bin/bash

datetime=`date +%Y-%m-%d_%H:%M:%S`

echo "当前时间："$datetime

for ((i = $1; i <= $2; i++))
do
 nohup java -jar target/demo.jar --server.port=$i  &> /dev/null &
 echo "启动jar服务，端口："$i
done


