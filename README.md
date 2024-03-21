# NLLDS
Data System for NeuroLang Lab

## Environment
Java SE 1.8

PHP 7.2.24

Mysql 5.7.42

Tomcat 8.5

## INSTALLATION
1. Prepare Server Environment ( Java & PHP & Mysql & Tomcat)

2. Prepare FTPS(SSL/TLS) Server (openssl + vsftpd)
```
# Vsftpd installation
sudo apt update
sudo apt install vsftpd
sudo systemctl start vsftpd
sudo systemctl enable vsftpd
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem
sudo nano /etc/vsftpd.conf
	ssl_enable=YES
	allow_anon_ssl=NO
	force_local_data_ssl=YES
	force_local_logins_ssl=YES
	ssl_tlsv1=YES
	ssl_sslv2=NO
	ssl_sslv3=NO
	rsa_cert_file=/etc/ssl/private/vsftpd.pem
	rsa_private_key_file=/etc/ssl/private/vsftpd.pem
sudo service vsftpd restart

# Better close the firewall, nor the ftp may not be accessed
sudo ufw disable

# Linux User Group Setting:
groupadd nllds
useradd -d /home/ftpmanger -m ftpmanger -g nllds
passwd ftpmanger

# Set ftp users only can access specific dir
sudo nano /etc/vsftpd.conf
	chroot_local_user=YES
	user_config_dir=/etc/vsftpd_user_list/
	allow_writeable_chroot=YES
sudo mkdir /etc/vsftpd_user_list/
sudo nano /etc/vsftpd_user_list/ftpmanger
	local_root=/media/bmi/BigData/NLL_Project
	write_enable=YES
sudo service vsftpd restart
```

3. Adjust src/main/resources/*.xml files to connect to Mysql

4. Execute NLLDS.sql

5. Build the project and export war package

6. Upload war package to server(tomcat/webapps)
```
# Add this to server.xml in tomcat/conf
<Context path="/NLLDS" docBase="/home/wyd/apache-tomcat-8.5.98/webapps/NLLDS.war" debug="0" reloadable="true" />
```

7. Copy JavaBridge.jar, script-api.jar, php-servlet.jar, php-script.jar to Tomcat/lib folder

8. Adjust tomcat/conf/web.xml

```
Add the following in node <web-app>:
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

Add the following in node <welcome-file-list>:
<welcome-file>index.php</welcome-file>
```

9. Upload elFinder to Tomcat/webapps and adjust the config under php/connector.minimal.php

10. Restart tomcat and visit webpage.


