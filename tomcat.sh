mkdir /usr/local/download
cd /usr/local/download
wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.82/bin/apache-tomcat-8.5.82.tar.gz
wget https://github.com/AdoptOpenJDK/openjdk8-upstream-binaries/releases/download/jdk8u342-b07/OpenJDK8U-jdk_x64_linux_8u342b07.tar.gz
mkdir /usr/local/java
cd /usr/local/java
tar -xvzf /usr/local/download/OpenJDK8U-jdk_x64_linux_8u342b07.tar.gz
cd /usr/local
tar -xvzf /usr/local/download/apache-tomcat-8.5.82.tar.gz
mv apache-tomcat-8.5.82 tomcat
echo "export JAVA_HOME=/usr/local/java/openjdk-8u342-b07
export CATALINA_HOME=/usr/local/tomcat
export PATH=$JAVA_HOME/bin:$PATH:$CATALINA_HOME/bin
export CLASSPATH=$CLASSPATH:$JAVA_HOME/jre/lib/ext:$JAVA_HOME/lib/tools.jar:$CATALINA_HOME/lib-jsp-api.jar:$CATALINA_HOME/lib/servlet.jar" >> /etc/profile
source /etc/profile
cd /usr/local/tomcat/bin
sh startup.sh
ps -ef | grep tomcat
netstat -anlp | grep java
