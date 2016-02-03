#!/bin/bash


# create the "repository" directory if it doesn't exist, otherwise it will be created by "root" when the docker process starts and
# and attempts to mount the host directory as a volume.
MAVEN_HOME=`readlink -f ~/.m2/repository`
if [ ! -d "$MAVEN_HOME" ]; then
    mkdir -p $MAVEN_HOME
fi


# CODE_HOME must be set and exported for the script we are calling
# DOCKER_IMAGE and DOCKER_OPTS are optional but necessary for some builds such as Precision LMS
export CODE_HOME=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export DOCKER_IMAGE="ptcuops/build-base"
export DOCKER_OPTS="-v $MAVEN_HOME:/data/.m2/repository"

# if a parameter that needs to be used by Docker has a space in it
# we have to use this approach; the string here will be converted to an array
# using the comma as a delimiter
export DOCKER_OPTS_ARRAY_STRING="-e,MAVEN_OPTS=-Xmx1024m -XX:MaxPermSize=128m"


ptcus_docker/ptcusystems_docker_initializer.sh $@

