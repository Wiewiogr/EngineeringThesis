#!/bin/bash -x

if [[ $# -lt 1 ]] ; then
    echo "usage: $0 <path-to-snapshot>"
    exit 1
fi

users_db=$1/users
repositories=$1/repositories

trap "exit" INT TERM
trap "kill 0" EXIT
python LxdUsersManager/start.py --scripts=LxdUsersManager/scripts --users_db=${users_db} --repositories=${repositories} &
bash LxdUsersManager/enableGitDaemon.sh ${repositories} &
sleep 1
cd lxc-monitor && ng serve
wait
