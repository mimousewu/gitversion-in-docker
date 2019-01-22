#!/bin/bash
WORKSPACE=$1
docker run --rm -v jenkins_jenkins_home:/var/jenkins_home -e APP=${WORKSPACE} gitversion /showvariable FullSemVer