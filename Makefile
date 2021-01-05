compose-file = centos-compose.yml
WORKSTATION_USER = master
WORKSTATION = ansible_workstation
NODE_A = "ansible_servera"
NODE_B = "ansible_serverb"
NODE_C = "ansible_serverc"
NODE_D = "ansible_serverd"

define _NODE_CONFIG
    docker exec $(1) sh -c 'echo -e "nameserver 8.8.4.4\nnameserver 8.8.8.8" >> /etc/resolv.conf'
	docker exec $(1) sh -c "rm /run/nologin"
	docker exec $(1) sh -c "systemctl start firewalld"
	docker exec $(1) sh -c "firewall-cmd --permanent --zone=public --change-interface=eth0 && firewall-cmd --reload"
endef

build:
	@echo "Building ansible master /node images"
	chmod 600 .ssh/id_rsa
	chmod 640 .ssh/id_rsa.pub
	docker-compose -f  ${compose-file} build

start:
	@echo "Starting all containers"
	docker-compose -f  ${compose-file} up -d
	sleep 4
	$(call _NODE_CONFIG, ${NODE_A})
	$(call _NODE_CONFIG, ${NODE_B})
	$(call _NODE_CONFIG, ${NODE_C})
	$(call _NODE_CONFIG, ${NODE_D})

stop:
	@echo "Removing all containers"
	docker-compose -f  ${compose-file} down

run_workstation:
	@echo "Running ${WORKSTATION} with user ${WORKSTATION_USER}"
	docker exec ${WORKSTATION} pwd || make start
	docker exec ${WORKSTATION} sh -c "rm -rf /run/nologin"
	docker exec ${WORKSTATION} su -c "chown -R ${WORKSTATION_USER}:${WORKSTATION_USER} ~/scripts || echo ${WORKSTATION_USER} not have ~/scripts." ${WORKSTATION_USER}
	docker exec -it ${WORKSTATION} su ${WORKSTATION_USER}
