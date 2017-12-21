#!/bin/bash

if [[ $# -lt 1 ]] ; then
    echo "usage: $0 <user> [<commit_id>] "
    exit 1
fi

user_name=$1
container_name=C${user_name}
path_to_repos=/root/repos

if [[ $# -eq 1 ]] ; then
    git -C ${path_to_repos}/${user_name} --no-pager ls-tree --name-only -r HEAD
else
    commit_id=$2
    git -C ${path_to_repos}/${user_name} --no-pager ls-tree --name-only -r ${commit_id}
fi
