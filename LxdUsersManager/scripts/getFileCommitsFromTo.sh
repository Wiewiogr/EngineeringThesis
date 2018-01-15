#!/bin/bash -x

if [[ $# -lt 3 ]] ; then
    echo "usage: $0 <repos> <user> <file> <from> [<to>]"
    exit 1
fi

path_to_repos=$1
user_name=$2
file=$(echo $3 | base64 --decode)

if [[ $# -eq 3 ]] ; then
    git -C ${path_to_repos}/${user_name} --no-pager log --pretty=oneline -- ${file}
elif [[ $# -eq 4 ]] ; then
    git -C ${path_to_repos}/${user_name} --no-pager log --pretty=oneline --since="$(date +"%m.%d.%y %H:%M" -d @$4)" -- ${file}
elif [[ $# -eq 5 ]] ; then
    git -C ${path_to_repos}/${user_name} --no-pager log --pretty=oneline --since="$(date +"%m.%d.%y %H:%M" -d @$4)" --until="$(date +"%m.%d.%y %H:%M" -d @$5)" -- ${file}
fi
