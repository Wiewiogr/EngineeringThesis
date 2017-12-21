#!/usr/bin/env bash

if [[ $# -lt 3 ]] ; then
    echo "usage: $0 <user> <from> <to>"
    exit 1
fi

user_name=$1
from=$2
to=$3

bash getHistory.sh ${user_name} | awk -v from=${from} -v to=${to} '{if($1 > from && $1 < to) print $0}'
