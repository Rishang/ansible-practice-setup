WORKSTATION_USER = master
WORKSTATION = ansible_workstation
NODE_A = "ansible_servera"
NODE_B = "ansible_serverb"
NODE_C = "ansible_serverc"
NODE_D = "ansible_serverd"

define _NODE_CONFIG
    docker exec $(1) sh -c 'grep -E "nameserver 8.8.(4.4|8.8)" /etc/resolv.conf || echo -e "nameserver 8.8.4.4\nnameserver 8.8.8.8" >> /etc/resolv.conf'
	docker exec $(1) sh -c "rm -f /run/nologin"
endef

define _WORKSTATION_CONFIG
	docker exec $(1) sh -c "rm -rf /run/nologin"
	docker exec $(1) su -c "sudo chown -R ${WORKSTATION_USER}:${WORKSTATION_USER} ~/scripts || echo ${WORKSTATION_USER} not have ~/scripts." ${WORKSTATION_USER}
endef

build:
	which docker-compose || @echo "docker-compose not found, Install it running: pip install docker-compose"
	@echo "Building ansible master /node images"
	chmod 600 .ssh/dockerAnsi
	chmod 600 .ssh/config
	chmod 640 .ssh/dockerAnsi.pub
	docker-compose build

start:
	@echo "Starting all containers"
	make build
	docker-compose up -d
	sleep 4
	$(call _WORKSTATION_CONFIG, ${WORKSTATION})
	$(call _NODE_CONFIG, ${NODE_A})
	$(call _NODE_CONFIG, ${NODE_B})
	$(call _NODE_CONFIG, ${NODE_C})
	$(call _NODE_CONFIG, ${NODE_D})

stop:
	@echo "Stopping all containers"
	docker-compose kill


remove:
	@echo "Removing all containers"
	docker-compose down


reset:
	@echo "Removing all containers"
	make remove
	make start

run_workstation:
	@docker exec -it ${WORKSTATION} su ${WORKSTATION_USER} || (make start ; sleep 1 \
	&& docker exec -it ${WORKSTATION} su ${WORKSTATION_USER})

run_servera:
	@sh -c "docker exec -it ${NODE_A} bash" || (make start ; sleep 1 \
	&& docker exec -it ${NODE_A} bash)

run_serverb:
	@sh -c "docker exec -it ${NODE_B} bash" || (make start ; sleep 1 \
	&& docker exec -it ${NODE_B} bash)

run_serverc:
	@sh -c "docker exec -it ${NODE_C} bash" || (make start ; sleep 1 \
	&& docker exec -it ${NODE_C} bash)

run_serverd:
	sh -c "docker exec -it ${NODE_D} bash" || (make start ; sleep 1 \
	&& docker exec -it ${NODE_D} bash)

local_config:
	chmod 600 .ssh/dockerAnsi
	chmod 600 .ssh/config
	cp .ssh/dockerAnsi ~/.ssh
	sh -c 'grep -E "Host server[a-d]" ~/.ssh/config || cat .ssh/config >> ~/.ssh/config'
