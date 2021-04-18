#!/usr/bin/bash
source /tmp/scripts/vars.sh

set -x

[[ -e ~/.ssh ]] || mkdir ~/.ssh

if [[ $HOSTNAME == 'workstation' ]];then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    cp ${s_scripts}/conf/id_rsa ${s_scripts}/conf/id_rsa.pub ~/.ssh
    sudo chown -R ${WORKSTATION_USER}:${WORKSTATION_USER} ~/.ssh
    chmod 400  ~/.ssh/id_rsa
    chmod 600  ~/.ssh/id_rsa.pub
else

    grep "${WORKSTATION_USER}"  ~/.ssh/authorized_keys || cat ${s_scripts}/conf/id_rsa.pub >> ~/.ssh/authorized_keys
fi
