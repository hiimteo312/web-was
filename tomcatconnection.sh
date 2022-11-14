sed -i -e 's|address="::1"|address="0.0.0.0""|g' /usr/local/tomcat/conf/server.xml
sed -i -e 's|port="8009"|port="8009"\n               secretRequired="false"|g' /usr/local/tomcat/conf/server.xml
sed -i -e '115d;121d' /usr/local/tomcat/conf/server.xml
cd /usr/local/tomcat/bin
source /etc/profile
sh shutdown.sh
sh startup.sh

