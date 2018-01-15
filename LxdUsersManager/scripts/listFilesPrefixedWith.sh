#!/bin/bash

if [[ $# -lt 3 ]] ; then
    echo "usage: $0 <repos> <user> <prefix> [<commit_id>] "
    exit 1
fi

path_to_repos=$1
user_name=$2
prefix=$(echo $3 | base64 --decode)
dir=$(echo $0 | awk 'BEGIN{FS=OFS="/"}{$NF=""; NF--; print}')

if [[ $# -eq 2 ]] ; then
    bash ${dir}/listFiles.sh ${path_to_repos} ${user_name} | grep ^${prefix}
else
    commit_id=$4
    bash ${dir}/listFiles.sh ${path_to_repos} ${user_name} ${commit_id}| grep ^${prefix}
fi
