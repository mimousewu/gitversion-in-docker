#!/bin/bash
WORKSPACE=$1
if [ ! -z $(docker images |grep -E "^gitversion" | wc -l) ]; then
docker build -f gitversion/Dockerfile-gitversion -t gitversion gitversion/
fi
docker run --rm -v jenkins_jenkins_home:/var/jenkins_home -e APP=${WORKSPACE} gitversion > .gitversion.json
