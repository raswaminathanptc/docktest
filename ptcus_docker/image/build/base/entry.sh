#!/bin/bash

# de stands for "docker environment" and is the command to enter or use the
# the docker build environment established for PTCU Systems dev projects

{
    addgroup --gid $FD_GID rg
    adduser --disabled-password --uid $FD_UID --gid $FD_GID --gecos '' r
    echo "r:r" | chpasswd &> /dev/null
    adduser r sudo
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
    ln -s /data/.m2 /home/r/.m2
} &> /dev/null

if [ "$#" -gt 0 ]; then
    echo "In container: executing command"
    ALLARGS="$@"
    echo $ALLARGS
    su r -c "$ALLARGS"
else
    echo "In conatiner: opening shell"
    su r
fi


