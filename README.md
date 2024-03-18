# NLLDS
Data System for NeuroLang Lab

## Environment
Java SE 1.8

PHP 7.2.24

Mysql 5.7.42

Tomcat 8.5

IDE(Recommand): Eclipse (neon) for JavaEE

## INSTALLATION
1. 配置IDE(Eclipse) 的JDK/JRE(window→Preferences)

2. 配置Project(Properties)的Java Compiler(JDK)/Java Build Path(JRE Libraries)

3. 配置Project(Properties)的Deployment Assembly(like src/main…, target, WebContent, Maven, etc.)

4. 配置Server ( Java & PHP & Mysql & Tomcat)

5. 配置SSL/TLS opssl + vsftpd

6. Adjust project’s xml files to connect to Mysql

7. Export war package and upload to server(tomcat/webapps). Remember add <Context> to server.xml in tomcat.

8. 安装PHP: sudo apt install php-cgi

9. Add JavaBridge.jar, script-api.jar, php-servlet.jar, php-script.jar to Tomcat/lib folder

10. 修改web.xml

```
在<web-app>节点中加入以下内容:
<listener>
<listener-class>php.java.servlet.ContextLoaderListener</listener-class>
</listener>
<servlet>
<servlet-name>PhpJavaServlet</servlet-name>
<servlet-class>php.java.servlet.PhpJavaServlet</servlet-class>
</servlet>
<servlet>
<servlet-name>PhpCGIServlet</servlet-name>
<servlet-class>php.java.servlet.fastcgi.FastCGIServlet</servlet-class>
<init-param>
<param-name>prefer_system_php_exec</param-name>
<param-value>On</param-value>
</init-param>
<init-param>
<param-name>php_include_java</param-name>
<param-value>Off</param-value>
</init-param>
</servlet>
<servlet-mapping>
<servlet-name>PhpJavaServlet</servlet-name>
<url-pattern>*.phpjavabridge</url-pattern>
</servlet-mapping>
<servlet-mapping>
<servlet-name>PhpCGIServlet</servlet-name>
<url-pattern>*.php</url-pattern>
</servlet-mapping>

在<welcome-file-list>节点中加入以下内容:
<welcome-file>index.php</welcome-file>
```

11. Restart tomcat and visit webpage.