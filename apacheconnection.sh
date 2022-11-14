cd /usr/local/download
wget https://archive.apache.org/dist/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.48-src.tar.gz
tar -xvzf tomcat-connectors-1.2.48-src.tar.gz
cd /usr/local/download/tomcat-connectors-1.2.48-src/native
./configure --with-apxs=/usr/local/apache/bin/apxs
make && make install
cd /usr/local/apache/conf
sed -i -e "s|mod_rewrite.so|mod_rewrite.so\nLoadModule jk_module modules/mod_jk.so|g" /usr/local/apache/conf/httpd.conf
echo "<IfModule jk_module>
Include conf/mod_jk.conf
</IfModule>" >> /usr/local/apache/conf/httpd.conf

echo "<VirtualHost *:80>
 ServerName 172.25.0.149
 JkMount /* tomcat1	
</VirtualHost>" >> /usr/local/apache/conf/httpd.conf

echo "<IfModule mod_jk.c>
  JkWorkersFile /usr/local/apache/conf/workers.properties

  JkLogFile logs/mod_jk.log

  JkLogLevel info

  JkLogStampFormat \"[%a %b %d %H:%M:%S %Y] \"
</IfModule>" > /usr/local/apache/conf/mod_jk.conf

echo "<IfModule jk_module>
Include conf/mod_jk.conf
</IfModule>" >> /usr/local/apache/conf/httpd.conf

echo "worker.list=tomcat1

worker.tomcat1.port=8009
worker.tomcat1.host=172.25.0.88
worker.tomcat1.type=ajp13
worker.tomcat1.lbfactor=1" > /usr/local/apache/conf/workers.properties




cd /usr/local/apache/bin
./httpd -t
./apachectl -k restart

