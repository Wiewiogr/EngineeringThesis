#!/bin/bash
if [[ $# -lt 2 ]] ; then
    echo "usage: $0 <repos> <user> [<number_of_lines>]"
    exit 1
fi

path_to_repos=$1
user_name=$2
container_name=C$3

if [[ $# -eq 2 ]] ; then
    lxc exec ${container_name} -- bash -c "cat /home/${user_name}/.hst"
elif [[ $# -eq 3 ]] ; then
    number_of_lines=$3
    lxc exec ${container_name} -- bash -c "cat /home/${user_name}/.hst | tail -n ${number_of_lines}"
fi
