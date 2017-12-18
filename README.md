# pdf2swf
PDF文件在线预览

## 服务端
### 环境要求
OS：CentOS<br />
JDK：jdk1.8

### 转换工具安装
安装脚本是针对CentOS编写的，若非CentOS系统，请自行安装resources/ 下的2款软件<br />
&#35; cd pdf2swf<br />
&#35; chmod +x ./*.sh<br />
&#35; ./install.sh

### 微服务安装
考虑到转换工作是由服务端处理的，考虑到多数语言(如PHP)一般是禁用执行系统命令的，所以此处用Java来实现微服务<br />
&#35;&#35; 通过 server.port 参数可自定义监听的端口<br />
&#35; nohup java -jar serv.jar --server.port=52012 >>./serv.log & <br />
&#35;&#35; 检测微服务是否正常<br />
&#35; netstat -anp | grep 上一步指定的端口号

### 客户端调用
任何客户端通过HTTP POST请求来调用服务
<table>
  <tr>
    <th colspan="2" style="text-align:left">http://localhost:52012</th>
  </tr>
  <tr>
    <th>参数</th>
    <th>说明</th>
  </tr>
  <tr>
    <td>pdfFile</td>
    <td>待转换PDF文件的绝对路径</td>
  </tr>
</table>
