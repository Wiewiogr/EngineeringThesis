#!/bin/bash -x

validate_and_setup_parameters() {
    if [[ $# -lt 3 ]] ; then
        echo "usage: $0 <repository> <username> <password>"
        exit 1
    fi
    dir=$(echo $0 | awk 'BEGIN{FS=OFS="/"}{$NF=""; NF--; print}')
    user_name=$2
    password=$3
    container_name=C${user_name}
    path_to_repos=$1
    lxd_host_ip=10.118.5.1
    echo "validation end" 1>&2
}

create_user() {
    echo "create user beg" 1>&2
    #useradd $USER_NAME
    useradd ${user_name} --groups lxd
    echo "$user_name:$password" | chpasswd
    mkdir -p /home/${user_name}
    sudo usermod --shell /bin/bash --home /home/${user_name} ${user_name}
    sudo chown -R ${user_name}:${user_name} /home/${user_name}
    #sudo usermod -G lxd $USER_NAME
    echo "create user end" 1>&2
}

create_container() {
    echo "create cont beg" 1>&2
    lxc launch ubuntu:16.04 ${container_name}
    lxc config set ${container_name} volatile.idmap.next "[]"
    lxc config set ${container_name} volatile.last_state.idmap "[]"
    lxc start ${container_name} #or lxd restart
    echo "create cont end" 1>&2
}

setup_ssh_on_container() {
    echo "setup ssh on cont beg" 1>&2
    lxc exec ${container_name} -- bash -c "useradd $user_name -s /bin/bash -m"
    lxc exec ${container_name} -- bash -c "mkdir -p /home/$user_name/.ssh "
    ssh-keygen -f key -P ""
    mkdir -p /home/${user_name}/.ssh
    cp key /home/${user_name}/.ssh/id_rsa
    lxc file push key.pub ${container_name}/home/${user_name}/.ssh/authorized_keys
    cp key.pub /home/${user_name}/.ssh/id_rsa.pub
    chmod +rw /home/${user_name}/.ssh/id_rsa*
    rm -f key key.pub
    echo "setup ssh on cont end" 1>&2
    
    #Configure history
    echo "cofigure history beg" 1>&2
    echo $0 | cut -d"/" -f-1
    lxc exec ${container_name} -- bash -c "cd /home/$user_name && touch .hst && chown ${user_name}:${user_name} .hst && chmod -r .hst && chattr +a .hst"
    lxc file push ${dir}/bashrc ${container_name}/home/${user_name}/.bashrc
    echo "cofigure history end" 1>&2
}

initialize_repo_on_host() {
    echo "initialize repo on host beg" 1>&2
    mkdir -p ${path_to_repos}/${user_name}
    git init ${path_to_repos}/${user_name} --bare
    # git clone -l ${path_to_repos}/${user_name} ${path_to_repos}/${user_name}-wc
    echo "initialize repo on host end" 1>&2
}

clone_and_configure_repo_on_container() {
    echo "clone and configure repo on container beg" 1>&2
    local git_repo_url=git://${lxd_host_ip}/${user_name}
    lxc exec ${container_name} -- bash -c "git clone $git_repo_url /home/$user_name/tmp"
    lxc exec ${container_name} -- bash -c "mv /home/$user_name/tmp/.git /home/"
    lxc exec ${container_name} -- bash -c "rm -rf /home/$user_name/tmp"
    lxc file push ${dir}/gitignore ${container_name}/home/.gitignore
    lxc exec ${container_name} -- bash -c "cd /home && git add -A && git commit -m \"init\" && git push"
    lxc exec ${container_name} -- bash -c "apt-get update"
    echo "clone and configure repo on container end" 1>&2

    #Configure inotify
    echo "configure intoify beg" 1>&2
    lxc exec ${container_name} -- bash -c "apt-get install inotify-tools --assume-yes"
    echo "1" 1>&2
    lxc file push ${dir}/inotifyScript.sh ${container_name}/root/inotifyScript.sh
    lxc file push ${dir}/inotify.service ${container_name}/etc/systemd/system/inotify@.service
    lxc exec ${container_name} -- bash -c "chmod +x /root/inotifyScript.sh"
    lxc exec ${container_name} -- bash -c "systemctl enable inotify@${user_name}.service"
    lxc exec ${container_name} -- bash -c "systemctl start inotify@${user_name}.service"
    echo "2" 1>&2
    echo "configure intoify ned" 1>&2

    #disable git for user
    lxc exec ${container_name} -- bash -c "setfacl -m u:${user_name}:r /usr/bin/git"

    #disable message of the day
    lxc exec ${container_name} -- bash -c "chmod -x /etc/update-motd.d/*"
    
}

create_bash_configuration_for_user_on_host() {
	echo "create bash config beg" 1>&2
	cat > /home/$user_name/.profile <<EOF
curl -s localhost:5000/user/${user_name}/entered > /dev/null
ssh -o StrictHostKeyChecking=no \$(lxc ls ${container_name} -c4 --format=csv | cut -d" " -f1) -l ${user_name}
curl -s localhost:5000/user/${user_name}/exited > /dev/null
exit
EOF
	echo "create bash config end" 1>&2
}

main() {
    validate_and_setup_parameters $@
    create_user
    create_container
    setup_ssh_on_container
    initialize_repo_on_host
    sleep 10
    clone_and_configure_repo_on_container
    create_bash_configuration_for_user_on_host
}

main $@
echo "elo" 1>&2
