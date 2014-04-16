FROM wouterd/tomcat

MAINTAINER Wouter Danes "https://github.com/wouterd"

ADD myhippoproject.tar.gz /tmp/app-distribution/

RUN for i in $(ls /tmp/app-distribution/) ; do mkdir -p /var/lib/tomcat6/${i} && cp -f /tmp/app-distribution/${i}/* /var/lib/tomcat6/${i}/ ; done

EXPOSE 1099