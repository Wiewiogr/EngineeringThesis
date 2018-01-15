#!/usr/bin/env bash

if [[ $# -lt 3 ]] ; then
    echo "usage: $0 <repositories> <users_db> <save_path>"
    exit 1
fi

path_to_repos=$1
users_db=$2
save_path=$(echo $3 | base64 --decode )

mkdir -p ${save_path}/repositories
cp ${users_db} ${save_path}
cp ${path_to_repos}/* ${save_path}/repositories