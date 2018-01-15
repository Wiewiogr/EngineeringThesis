#!/bin/bash

if [[ $# -lt 2 ]] ; then
    echo "usage: $0 <repos> <user> [<commit_id>] "
    exit 1
fi

path_to_repos=$1
user_name=$2
container_name=C${user_name}

if [[ $# -eq 2 ]] ; then
    git -C ${path_to_repos}/${user_name} --no-pager ls-tree --name-only -r HEAD
else
    commit_id=$3
    git -C ${path_to_repos}/${user_name} --no-pager ls-tree --name-only -r ${commit_id}
fi
