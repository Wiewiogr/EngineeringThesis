#!/bin/bash -x

if [[ $# -lt 1 ]] ; then
    echo "usage: $0 <user>"
    exit 1
fi

user_name=$1
container_name=C${user_name}

result=$(lxc info ${container_name})

if [[ $? -eq 0 ]] ; then
    echo $result | grep Status: | cut -d" " -f2
else
    printf Offline
fi
