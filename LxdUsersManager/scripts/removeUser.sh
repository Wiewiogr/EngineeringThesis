#!/bin/bash
USER_NAME=$1
CONTAINER_NAME=C$USER_NAME
PATH_TO_REPOS=/root/repos

userdel $USER_NAME
rm -rf /home/$USER_NAME
lxc delete --force $CONTAINER_NAME
rm -rf $PATH_TO_REPOS/$USER_NAME
