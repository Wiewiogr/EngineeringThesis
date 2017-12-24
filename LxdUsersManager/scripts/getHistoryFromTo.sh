#!/usr/bin/env bash

if [[ $# -lt 2 ]] ; then
    echo "usage: $0 <user> <from> [<to>]"
    exit 1
fi

user_name=$1
from=$2
to=$3

if [[ $# -eq 2 ]] ; then
    bash getHistory.sh ${user_name} | awk -v from=${from} '{if($1 > from) print $0}'
elif [[ $# -eq 3 ]] ; then
    bash getHistory.sh ${user_name} | awk -v from=${from} -v to=${to} '{if($1 > from && $1 < to) print $0}'
fi