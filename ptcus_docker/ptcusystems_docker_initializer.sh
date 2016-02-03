#!/bin/bash

# if we're executing in the CircleCI environment, don't --rm the container;
# this causes an issue with that environment
if [ -z "$CIRCLECI" ]; then
    OPTS="--rm"
fi


if [ -z "DOCKER_IMAGE" ]; then
    DOCKER_IMAGE="ptcuops/build-base"
fi

if [ -z "CODE_HOME" ]; then
    echo " The environment variable CODE_HOME must be set to match the"
    echo " root directory of the code base that is being build. This"
    echo " This directory will be exported to the Docker image and"
    echo " used as the root for the commands that are executed."
fi

# parse the strings into an array so that we can later include in on the command line
IFS=',' read -ra DOCKER_OPTS_ARRAY <<< "$DOCKER_OPTS_ARRAY_STRING"

OPTS="$OPTS -e "FD_UID=$(id -u)" -e "FD_GID=$(id -g)" -v $CODE_HOME:/data/code -w /data/code $DOCKER_OPTS  $DOCKER_IMAGE"
#echo $DOCKER_IMAGE
#echo $DOCKER_OPTS
#echo $OPTS

if [ $# -eq 0 ]; then
    echo "  No arguments supplied. Your arguments should be 'shell' or whatever"
    echo "  commands you want run from the code base directory (i.e. mvn clean compile)."
    echo "  You can issue multiple commands in one line by surronding the commands with"
    echo "  one set of quotation marks and putting '&&' between each command ( i.e"
    echo "  \"cd fusion-service && mvn clean compile\" which would only compile the "
    echo "  fusion-service module)"
elif [ "$1" = "shell" ]; then
    # open shell
    echo docker run -i -t "${DOCKER_OPTS_ARRAY[@]}" $OPTS /entry.sh
    docker run -i -t "${DOCKER_OPTS_ARRAY[@]}" $OPTS /entry.sh
else
   # pass arguments to entry script which will run them
   echo docker run "${DOCKER_OPTS_ARRAY[@]}" $OPTS /entry.sh "$@"
   docker run "${DOCKER_OPTS_ARRAY[@]}" $OPTS /entry.sh "$@"
fi


