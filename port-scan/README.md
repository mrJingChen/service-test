
#### 结构
```
service-test(pom)
	|
	—— port-scan(jar) ✔
	|
	—— http-cors(jar)
	
```

#### port-scan 端口扫描

1、切入pom目录
```
cd port-scan
```

2、打包
```
mvn clean package -Dmaven.test.skip=true
```

3、开启8080到8085之间端口的web服务：
```
shell/demo_start.sh 8080 8085
```

4、浏览器端服务验证：
```
http://127.0.0.1:8080
```

5、nmap扫描（请求：-v列出扫描过程详细信息；-n不做反向DNS解析；-sT基本TCP扫描方式类型；-p端口；-p T:TCP端口。响应：Open开启；closed关闭；unfiltered未过滤，端口关闭；(4).filtered过滤，表示防火墙、包过滤和其它的网络安全软件掩盖了这个端口）：
```
nmap  -v   -n  -sT  -p T:8080-8085  127.0.0.1

```

