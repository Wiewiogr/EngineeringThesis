#!/bin/bash -x

if [[ $# -lt 3 ]] ; then
    echo "usage: $0 <repos> <user> <start/stop>"
    exit 1
fi

user_name=$2
container_name=C${user_name}
status=$3

lxc ${status} ${container_name}
