#!/bin/bash -x
trap "exit" INT TERM
trap "kill 0" EXIT
python LxdUsersManager/start.py --scripts=LxdUsersManager/scripts --users_db=users --repositories=/root/repos &
bash LxdUsersManager/enableGitDaemon.sh /root/repos &
sleep 1
cd lxc-monitor && ng serve
wait
