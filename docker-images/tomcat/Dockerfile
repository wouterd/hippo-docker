FROM        wouterd/java7

VOLUME      ["/var/log/tomcat6"]

MAINTAINER  Wouter Danes "https://github.com/wouterd"

RUN         apt-get update && \
            apt-get install -y tomcat6

ENV         CATALINA_BASE /var/lib/tomcat6

ENV         CATALINA_HOME /usr/share/tomcat6

ENTRYPOINT  ["/usr/share/tomcat6/bin/catalina.sh", "run"]

EXPOSE      8080
