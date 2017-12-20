#!/bin/bash -x

if [[ $# -lt 2 ]] ; then
    echo "usage: $0 <user> <file> <from> [<to>]"
    exit 1
fi

user_name=$1
path_to_repos=/root/repos
file=$(echo $2 | base64 --decode)

if [[ $# -eq 2 ]] ; then
    git -C ${path_to_repos}/${user_name} --no-pager log --pretty=oneline -- ${file}
elif [[ $# -eq 3 ]] ; then
    git -C ${path_to_repos}/${user_name} --no-pager log --pretty=oneline --since="$(date +"%m.%d.%y %H:%M" -d @$3)" -- ${file}
elif [[ $# -eq 4 ]] ; then
    git -C ${path_to_repos}/${user_name} --no-pager log --pretty=oneline --since="$(date +"%m.%d.%y %H:%M" -d @$3)" --until="$(date +"%m.%d.%y %H:%M" -d @$4)" -- ${file}
fi
