#!/bin/bash

if [[ $# -lt 2 ]] ; then
    echo "usage: $0 <user> <prefix> [<commit_id>] "
    exit 1
fi

user_name=$1
prefix=$(echo $2 | base64 --decode)
dir=$(echo $0 | awk 'BEGIN{FS=OFS="/"}{$NF=""; NF--; print}')

if [[ $# -eq 2 ]] ; then
    bash ${dir}/listFiles.sh ${user_name} | grep ^${prefix}
else
    commit_id=$3
    bash ${dir}/listFiles.sh ${user_name} ${commit_id}| grep ^${prefix}
fi
