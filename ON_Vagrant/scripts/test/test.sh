#!/usr/bin/bash
source /tmp/scripts/vars.sh


cat <<EOF > /tmp/i
servera
serverb
serverc
serverd
EOF


ansible all -i /tmp/i -m ping -u ${SERVER_USER}

