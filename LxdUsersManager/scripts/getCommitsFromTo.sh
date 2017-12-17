#!/bin/bash -x

if [[ $# -lt 2 ]] ; then
    echo "usage: $0 <user> <from> [<to>]"
    exit 1
fi

user_name=$1
container_name=C${user_name}
path_to_repos=/root/repos

if [[ $# -eq 2 ]] ; then
    git -C ${path_to_repos}/${user_name} --no-pager shortlog --since="$(date +"%m.%d.%y %H:%M" -d @$2)"
elif [[ $# -eq 3 ]] ; then
    git -C ${path_to_repos}/${user_name} --no-pager shortlog --since="$(date +"%m.%d.%y %H:%M" -d @$2)" --until="$(date +"%m.%d.%y %H:%M" -d @$3)"
fi