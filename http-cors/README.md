
#### 结构
```
service-test(pom)
	|
	—— port-scan(jar)
	|
	—— http-cors(jar) ✔

```

#### http-cors 提供GET\POST-JSON\POST-FILE，3种请求，供验证服务接口是否允许跨域

1、切入pom目录
```
cd http-cors
```

2、打包
```
mvn clean package -Dmaven.test.skip=true
```

3、运行当前web服务：
```
java  -jar  -Dserver.port=8080  target/httpcors.jar
```

4、浏览器端系统首页：
```
http://127.0.0.1:8080/demo
```

