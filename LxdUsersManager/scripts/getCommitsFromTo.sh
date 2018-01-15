#!/bin/bash -x

if [[ $# -lt 2 ]] ; then
    echo "usage: $0 <repostiroes> <user> [<from>] [<to>]"
    exit 1
fi

path_to_repos=$1
user_name=$2
container_name=C${user_name}

if [[ $# -eq 2 ]] ; then
    git -C ${path_to_repos}/${user_name} --no-pager log --pretty=oneline | grep -v init | grep -v .hst
elif [[ $# -eq 3 ]] ; then
    git -C ${path_to_repos}/${user_name} --no-pager log --pretty=oneline --since="$(date +"%m.%d.%y %H:%M" -d @$3)" | grep -v init | grep -v .hst
elif [[ $# -eq 4 ]] ; then
    git -C ${path_to_repos}/${user_name} --no-pager log --pretty=oneline --since="$(date +"%m.%d.%y %H:%M" -d @$3)" --until="$(date +"%m.%d.%y %H:%M" -d @$3)" | grep -v init | grep -v .hst
fi

exit 0
