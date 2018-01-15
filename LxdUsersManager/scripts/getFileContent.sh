#!/bin/bash -x

if [[ $# -lt 3 ]] ; then
    echo "usage: $0 <repos> <user> <file> [<id>]"
    exit 1
fi

path_to_repos=$1
user_name=$2
file=$(echo $3 | base64 --decode)

if [[ $# -eq 3 ]] ; then
    git -C ${path_to_repos}/${user_name} --no-pager show HEAD:${file}
else
    commit_id=$4
    git -C ${path_to_repos}/${user_name} --no-pager show ${commit_id}:${file}
fi
