#!/bin/bash

cd docker-images

docker build -t wouterd/mysql -rm mysql

docker build -t wouterd/oracle-jre7 -rm oracle-jre7

docker build -t wouterd/tomcat -rm tomcat