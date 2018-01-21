#!/bin/bash -x

if [[ $# -lt 1 ]] ; then
    echo "usage: $0 <user>"
    exit 1
fi

user_name=$1
container_name=C${user_name}

lxc info ${container_name} | grep Status: | cut -d" " -f2
