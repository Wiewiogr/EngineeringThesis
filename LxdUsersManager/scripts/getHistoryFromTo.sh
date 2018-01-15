#!/usr/bin/env bash

if [[ $# -lt 3 ]] ; then
    echo "usage: $0 <repos> <user> <from> [<to>]"
    exit 1
fi

path_to_repos=$1
user_name=$2
from=$3
to=$4
dir=$(echo $0 | awk 'BEGIN{FS=OFS="/"}{$NF=""; NF--; print}')

if [[ $# -eq 3 ]] ; then
    bash ${dir}/getHistory.sh ${path_to_repos} ${user_name} | awk -v from=${from} '{if($1 > from) print $0}'
elif [[ $# -eq 4 ]] ; then
    bash ${dir}/getHistory.sh ${path_to_repos} ${user_name} | awk -v from=${from} -v to=${to} '{if($1 > from && $1 < to) print $0}'
fi
