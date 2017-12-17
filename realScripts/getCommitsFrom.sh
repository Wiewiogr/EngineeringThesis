#!/bin/bash -x

if [[ $# -eq 0 ]] ; then
    echo "usage: $0 <user> <from>"
    exit 1
fi

user_name=$1
container_name=C${user_name}
path_to_repos=/root/repos

git -C ${path_to_repos}/${user_name} --no-pager shortlog --since="$(date +"%m.%d.%y %H:%M" -d @$2)"
