#!/bin/bash

if [[ $# -eq 1 ]] ; then
    echo "usage: $0 <repos> <username>"
    exit 1
fi

path_to_repos=$1
user_name=$2
container_name=C${user_name}

userdel ${user_name}
rm -rf /home/${user_name}
lxc delete --force ${container_name}
rm -rf ${path_to_repos}/${user_name}
