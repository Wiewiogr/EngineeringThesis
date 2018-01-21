#!/bin/bash -x

if [[ $# -lt 2 ]] ; then
    echo "usage: $0 <user> <start/stop>"
    exit 1
fi

user_name=$1
container_name=C${user_name}
status=$2

lxc ${status} ${container_name}
