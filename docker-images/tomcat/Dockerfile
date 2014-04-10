FROM wouterd/oracle-jre7

MAINTAINER Wouter Danes "https://github.com/wouterd"

RUN apt-get install -y tomcat6

RUN mkdir -p /var/lib/tomcat6/logs
RUN mkdir -p /var/lib/tomcat6/temp

CMD JAVA_HOME=/usr/lib/jvm/java-7-oracle CATALINA_BASE=/var/lib/tomcat6 CATALINA_HOME=/usr/share/tomcat6 /usr/share/tomcat6/bin/catalina.sh run

EXPOSE 8080
