#!/bin/bash -x

validate_and_setup_parameters() {
    if [[ $# -lt 2 ]] ; then
        echo "usage: $0 <username> <password>"
        exit 1
    fi
    user_name=$1
    password=$2
    container_name=C${user_name}
    path_to_repos=/root/repos
    lxd_host_ip=10.118.5.1
}

create_user() {
    #useradd $USER_NAME
    useradd ${user_name} --groups lxd
    echo "$user_name:$password" | chpasswd
    mkdir -p /home/${user_name}
    sudo usermod --shell /bin/bash --home /home/${user_name} ${user_name}
    sudo chown -R ${user_name}:${user_name} /home/${user_name}
    #sudo usermod -G lxd $USER_NAME
}

create_container() {
    lxc launch ubuntu:16.04 ${container_name}
    lxc config set ${container_name} volatile.idmap.next "[]"
    lxc config set ${container_name} volatile.last_state.idmap "[]"
    lxc start ${container_name} #or lxd restart
}

setup_ssh_on_container() {
    lxc exec ${container_name} -- bash -c "useradd $user_name -s /bin/bash -m"
    lxc exec ${container_name} -- bash -c "mkdir -p /home/$user_name/.ssh "
    local tmp_ssh_key=$(mktemp)
    ssh-keygen -f key -P ""
    mkdir -p /home/${user_name}/.ssh
    cp key /home/${user_name}/.ssh/id_rsa
    lxc file push key.pub ${container_name}/home/${user_name}/.ssh/authorized_keys
    cp key.pub /home/${user_name}/.ssh/id_rsa.pub
    chmod +rw /home/${user_name}/.ssh/id_rsa*
    rm -f key
}

initialize_repo_on_host() {
    local path_to_repo=${path_to_repos}/${user_name}
    mkdir -p ${path_to_repo}
    #git init ${path_to_repos}/${user_name} --bare
    git init ${path_to_repo}
    git -C ${path_to_repo} config --local receive.denyCurrentBranch updateInstead
}

clone_and_configure_repo_on_container() {
    local git_repo_url=git://${lxd_host_ip}/${user_name}
    lxc exec ${container_name} -- bash -c "git clone $git_repo_url /home/$user_name/tmp"
    lxc exec ${container_name} -- bash -c "mv /home/$user_name/tmp/.git /home/$user_name/"
    lxc exec ${container_name} -- bash -c "rm -rf /home/$user_name/tmp"
    lxc file push gitignore ${container_name}/home/${user_name}/.gitignore
    lxc exec ${container_name} -- bash -c "cd /home/$user_name && git add -A && git commit -m \"init\" && git push"
    lxc exec ${container_name} -- bash -c "chown -R $user_name:$user_name /home/$user_name/.git"
    lxc exec ${container_name} -- bash -c "chmod -R +rw /home/$user_name/.git"

    local tmp_gitconfig=$(mktemp)
    cat > ${tmp_gitconfig} <<EOF
[user]
email = ${user_name}@${user_name}.pl
name = ${user_name}
[push]
default = matching
EOF
    lxc file push ${tmp_gitconfig} ${container_name}/home/${user_name}/.gitconfig
    rm ${tmp_gitconfig}
}

create_bash_configuration_for_user_on_host() {
	cat > /home/$user_name/.profile <<EOF
curl localhost:5000/user/${user_name}/entered
ssh \$(lxc ls ${container_name} -c4 --format=csv | cut -d" " -f1) -l ${user_name}
curl localhost:5000/user/${user_name}/exited
exit
EOF
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
