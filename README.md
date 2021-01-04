
# Ansible setup on Docker

## Pre-Requisites:

**Having Docker Installed on your system**

Refrence to install Docker > [Click here](https://docs.docker.com/engine/install/)

------

This is ansible setup script via Docker and containers.

It creates a workstation where we will create and run ansible scripts.
and 4 node containers under same network as of workstation namely

>NOTE: Default user when nodes starts is user: **root**

So you have to set root as user for ansible scripts.

>You have to write directly the below giveb hostname to your ansible inventory instead of using  IP addresses

## **Workstaion Hostname | user: master**

- workstation

## **Node Hostnames | user: root**

- servera
- serverb
- serverc
- serverd

## Steps of setup

### Step 1 | Build workstation and node Images

Clone the repo through `git clone https://github.com/Rishang/dockerAnsi.git` and `cd dockerAnsi`.

This step has to done only once and may take some time.

    make build

### Step 2 | Start workstation and node containers

    make start

Thats it now workstation and node has been started on same network.

### Step 3 | access workstation

Access shell of workstation

    make run_workstation

This command will give you shell to the workstation container

The `~/script` folder in workstation is mounted to local storage so create all your ansible scripts in `~/scripts`

    cd ~/scripts

OK now good to go, create all your ansible scripts in this directory.

you can also access it form local system in folder called `my_work` also can write sripts directly there and run it inside workstation container.

## Stop all the containers

If your work in completed and want to shut down all container run following command.

    make stop
