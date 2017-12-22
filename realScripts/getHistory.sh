#!/bin/bash
if [[ $# -lt 1 ]] ; then
    echo "usage: $0 <user> [<number_of_lines>]"
    exit 1
fi

user_name=$1
container_name=C$1

if [[ $# -eq 1 ]] ; then
    lxc exec ${container_name} -- bash -c "cat /home/${user_name}/.hst"
elif [[ $# -eq 2 ]] ; then
    number_of_lines=$2
    lxc exec ${container_name} -- bash -c "cat /home/${user_name}/.hst | tail -n ${number_of_lines}"
fi
