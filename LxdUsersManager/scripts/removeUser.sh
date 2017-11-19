#!/bin/bash
userdel $1
rm -rf /home/$1
lxc delete --force C$1
exit 0
