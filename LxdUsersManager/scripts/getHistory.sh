#!/bin/bash
lxc exec C$1 -- bash -c "cat /home/$1/.hst | tail"
