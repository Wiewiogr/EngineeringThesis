#!/bin/bash

if [[ $# -lt 2 ]] ; then
    echo "usage: $0 <user> <prefix> [<commit_id>] "
    exit 1
fi

user_name=$1
prefix=$(echo $2 | base64 --decode)

if [[ $# -eq 2 ]] ; then
    bash listFiles.sh ${user_name} | grep ^${prefix}
else
    commit_id=$3
    bash listFiles.sh ${user_name} ${commit_id}| grep ^${prefix}
fi
