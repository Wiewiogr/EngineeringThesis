#!/bin/bash

USER_NAME=$1
PASSWORD=$2

echo Creating user with name $USER_NAME
useradd $USER_NAME --groups lxd
echo "$USER_NAME:$PASSWORD" | chpasswd
mkdir /home/$USER_NAME
sudo usermod --shell /bin/bash --home /home/$USER_NAME $USER_NAME
sudo chown -R "$USER_NAME:$USER_NAME" /home/$USER_NAME
sudo usermod -G lxd test
lxc launch ubuntu:16.04 $USER_NAME
lxc config set $USER_NAME volatile.idmap.next "[]"
lxc config set $USER_NAME volatile.last_state.idmap "[]"

cat > /home/$USER_NAME/.profile <<EOF
lxc exec $USER_NAME bash
exit
EOF
