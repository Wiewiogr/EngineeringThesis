#!/bin/bash -x

if [[ $# -lt 2 ]] ; then
    echo "usage: $0 <repo> <user>"
    exit 1
fi

user_name=$2
container_name=C${user_name}

tmp_file=$(mktemp)

lxc info ${container_name} > ${tmp_file}

if [[ $? -eq 0 ]] ; then
    cat ${tmp_file} | grep Status: | awk '{print $2}' | tr -d '\n'
else
    printf Offline
fi

rm ${tmp_file}
