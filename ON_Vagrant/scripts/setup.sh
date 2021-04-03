#! /usr/bin/bash
source /tmp/scripts/vars.sh
set -x

function _service() {
    if ! [[ $(systemctl status $1 | grep ": active") ]];then
        systemctl enable $1;systemctl restart $1 || return 1
    else
        echo "active: $1"
    fi
}

function _sudo_user {
      # $1 : username
      # $2 : passwd
      
      groupadd --gid 27 sudo || echo group sudo exist

      if ! id $1 &>/dev/null;then
        useradd -m -s /bin/bash -U -G sudo -p $2 "$1"
        grep "%sudo" /etc/sudoers || echo "%sudo ALL=(ALL:ALL) ALL" >> /etc/sudoers
        grep "$1" /etc/sudoers || echo "$1 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
      else
        echo user: $1 exist
      fi
}


# user task file
u_tasks=${s_scripts}/user.sh
chmod +x $u_tasks

# set hosts
grep -E "server[a-z]" /etc/hosts || cat ${s_scripts}/conf/hosts >> /etc/hosts


if [[ $HOSTNAME == 'workstation' ]];then
    _sudo_user  ${WORKSTATION_USER} ${pass_w}

    # ssh conf
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
    sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config
    
    systemctl restart sshd
    
    # vagrant ssh temp fixup to workstation_user
    # [[ -e /home/vagrant/.bashrc ]] && echo "sudo bash -c \"cd /home/${WORKSTATION_USER}; exec su ${WORKSTATION_USER}\"" >> /home/vagrant/.bashrc
    
    # run another user tasks
    su -s $u_tasks $WORKSTATION_USER
else
    _sudo_user ${SERVER_USER} ${pass_s}

    su -s $u_tasks $SERVER_USER
fi

# clean
yum clean all -y
