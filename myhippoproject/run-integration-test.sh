#!/bin/bash
docker images | grep wouterd/tomcat || ./build-docker-images.sh
IMAGEID=$(docker build --rm -q=false . | grep "Successfully built" | cut -d " " -f 3)
mkdir -p logs
CONTAINERID=$(docker run -d -v $(pwd)/logs:/var/log/tomcat6 ${IMAGEID})

echo -n "Waiting for tomcat to finish startup..."

CATALINA_LOG_FILE="$(pwd)/logs/catalina.$(date +%Y-%m-%d).log"

# Give Tomcat some time to wake up...
while ! grep -q 'INFO: Server startup' ${CATALINA_LOG_FILE} ; do
    sleep 5
    echo -n "."
done

echo "Done"

IP=$(docker inspect --format '{{.NetworkSettings.IPAddress}}' ${CONTAINERID})

curl -i http://$IP:8080/site/

docker kill ${CONTAINERID}
docker rm ${CONTAINERID}
docker rmi ${IMAGEID}
