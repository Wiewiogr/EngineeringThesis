#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo "usage: $0 <username>"
    exit 1
fi
user_name=$1
container_name=C${user_name}
path_to_repos=/root/repos

userdel ${user_name}
rm -rf /home/${user_name}
lxc delete --force ${container_name}
rm -rf ${path_to_repos}/${user_name}
# rm -rf ${path_to_repos}/${user_name}-wc
