#!/bin/bash

USER_NAME=$1
PASSWORD=$2
CONTAINER_NAME=C$USER_NAME

echo Creating user with name $USER_NAME and container $CONTAINER_NAME
#useradd $USER_NAME
useradd $USER_NAME --groups lxd
echo "$USER_NAME:$PASSWORD" | chpasswd
mkdir /home/$USER_NAME
sudo usermod --shell /bin/bash --home /home/$USER_NAME $USER_NAME
sudo chown -R "$USER_NAME:$USER_NAME" /home/$USER_NAME
#sudo usermod -G lxd $USER_NAME

lxc launch ubuntu:16.04 $CONTAINER_NAME
lxc config set $CONTAINER_NAME volatile.idmap.next "[]"
lxc config set $CONTAINER_NAME volatile.last_state.idmap "[]"
lxc start $CONTAINER_NAME #or lxd restart

lxc exec $CONTAINER_NAME -- bash -c "useradd $1 -s /bin/bash -m"
lxc exec $CONTAINER_NAME -- bash -c "mkdir -p /home/$1/.ssh "
ssh-keygen -f key -P ""
mkdir /home/$USER_NAME/.ssh
mv key /home/$USER_NAME/.ssh/id_rsa
lxc file push key.pub $CONTAINER_NAME/home/$USER_NAME/.ssh/authorized_keys
mv key.pub /home/$USER_NAME/.ssh/id_rsa.pub
chmod +rw /home/$USER_NAME/.ssh/id_rsa*

cat > /home/$USER_NAME/.profile <<EOF
curl localhost:5000/user/$USER_NAME/entered
#lxc exec $CONTAINER_NAME bash
ssh \$(lxc ls $CONTAINER_NAME -c4 --format=csv | cut -d" " -f1) -l $USER_NAME
curl localhost:5000/user/$USER_NAME/exited
exit
EOF
