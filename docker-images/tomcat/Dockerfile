FROM wouterd/oracle-jre7

MAINTAINER Wouter Danes "https://github.com/wouterd"

RUN apt-get install -y tomcat6

RUN mkdir -p /usr/share/tomcat6/logs
RUN mkdir -p /usr/share/tomcat6/temp

CMD export JAVA_HOME=/usr/lib/jvm/java-7-oracle && export CATALINA_BASE=/var/lib/tomcat6 && /usr/share/tomcat6/bin/catalina.sh run

EXPOSE 8080