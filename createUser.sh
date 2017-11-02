#!/bin/bash


USER_NAME=$1
PASSWORD=$2
LXC_DIR="/lxc"

echo Creating user with name $USER_NAME
useradd $USER_NAME
echo "$USER_NAME:$PASSWORD" | chpasswd
mkdir /home/$USER_NAME
sudo usermod --shell /bin/bash --home /home/$USER_NAME $USER_NAME
sudo chown -R "$USER_NAME:$USER_NAME" /home/$USER_NAME

sudo /usr/sbin/usermod --add-subuids 100000-165536 $USER_NAME
sudo /usr/sbin/usermod --add-subgids 100000-165536 $USER_NAME

mkdir -p /home/$USER_NAME/.config/lxc
cat > /home/$USER_NAME/.config/lxc/default.conf <<EOF
lxc.idmap = u 0 100000 65536
lxc.idmap = g 0 100000 65536
EOF

mkdir -p /home/$USER_NAME/.local/share/lxc
chmod -R  a+x /home/$USER_NAME


#mkdir $LXC_DIR
#lxc-create --lxcpath=$LXC_DIR -t download -n $1



#cat <<EOF
#sudo lxc-attach --lxcpath $LXC_DIR --name unpriviliged
#wait
#exit
#EOF > /home/$USER_NAME/.profile

