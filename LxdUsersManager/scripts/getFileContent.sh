#!/bin/bash -x

if [[ $# -lt 2 ]] ; then
    echo "usage: $0 <user> <file> [<id>]"
    exit 1
fi

user_name=$1
path_to_repos=/root/repos
file=$(echo $2 | base64 --decode)

if [[ $# -eq 2 ]] ; then
    git -C ${path_to_repos}/${user_name} --no-pager show HEAD:${file}
else
    commit_id=$3
    git -C ${path_to_repos}/${user_name} --no-pager show ${commit_id}:${file}
fi
