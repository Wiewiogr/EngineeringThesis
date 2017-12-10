#!/bin/bash -x
trap "exit" INT TERM
trap "kill 0" EXIT
python LxdUsersManager/start.py &
bash LxdUsersManager/enableGitDaemon.sh /root/repos $
newgrp lxd 
lxd
wait
