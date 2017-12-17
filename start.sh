#!/bin/bash -x
trap "exit" INT TERM
trap "kill 0" EXIT
python LxdUsersManager/start.py LxdUsersManager/scripts &
bash LxdUsersManager/enableGitDaemon.sh /root/repos
wait
