# pdf2swf
PDF文件在线预览

## 服务端
### 环境要求
OS：CentOS<br />
JDK：jdk1.8

### 转换工具安装
安装脚本是针对CentOS编写的，若非CentOS系统，请自行安装resources/ 下的2款软件<br />
&#35; cd pdf2swf
&#35; chmod +x ./*.sh<br />
&#35; ./install.sh

### 微服务
考虑到转换工作是由服务端处理的，考虑到多数语言(如PHP)一般是禁用执行服务器Shell的，所以此处用Java来实现微服务
&#35; nohup java -jar serv.jar --server.port=端口号 >>./serv.log & <br />
&#35;&#35; 检测微服务是否正常<br />
&#35; netstat -anp | grep 上一步指定的端口号
