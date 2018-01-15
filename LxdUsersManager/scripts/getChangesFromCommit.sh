#!/usr/bin/env bash

if [[ $# -lt 3 ]] ; then
    echo "usage: $0 <repositories> <user> <commit_id>"
    exit 1
fi

path_to_repos=$1
user_name=$2
commit_id=$3

git -C ${path_to_repos}/${user_name} --no-pager show ${commit_id}
