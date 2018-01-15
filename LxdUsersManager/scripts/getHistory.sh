#!/bin/bash
if [[ $# -lt 2 ]] ; then
    echo "usage: $0 <repos> <user> [<number_of_lines>]"
    exit 1
fi

path_to_repos=$1
user_name=$2
container_name=C$2
dir=$(echo $0 | awk 'BEGIN{FS=OFS="/"}{$NF=""; NF--; print}')
file=$(echo ${user_name}/.hst | base64 )

if [[ $# -eq 2 ]] ; then
    bash ${dir}/getFileContent.sh ${path_to_repos} ${user_name} ${file}
elif [[ $# -eq 3 ]] ; then
    number_of_lines=$3
    bash ${dir}/getFileContent.sh ${path_to_repos} ${user_name} ${file} | tail -n ${number_of_lines}
fi
