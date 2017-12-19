# pdf2swf
PDF文件在线预览

## 服务端
### 环境要求
OS：CentOS / Ubuntu<br />
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

## 客户端调用
任何客户端通过HTTP POST请求来调用服务，调用成功后会在被转换文件所在目录生成对应的.swf文件。<br />
比如PDF文件路径：/home/wwwroot/demo/demo.pdf<br />
转换后生成文件：/home/wwwroot/demo/demo.pdf.swf
<table>
  <tr>
    <th colspan="2">http://localhost:52012</th>
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
前端通过JS+Flash实现swf的加载，具体请参考 player/ 

## 相关截图
![image](https://github.com/ah-guobing/pdf2swf/blob/master/resources/install.png)
![image](https://github.com/ah-guobing/pdf2swf/blob/master/resources/post.png)

## 问题反馈
使用中若有问题请联系QQ：46926125
