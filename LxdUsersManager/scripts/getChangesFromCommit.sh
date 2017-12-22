#!/usr/bin/env bash

if [[ $# -lt 2 ]] ; then
    echo "usage: $0 <user> <commit_id>"
    exit 1
fi

user_name=$1
path_to_repos=/root/repos
commit_id=$2

git -C ${path_to_repos}/${user_name} diff ${commit_id}
