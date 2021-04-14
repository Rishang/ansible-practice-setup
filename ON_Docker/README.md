
# Ansible setup on Docker

## Pre-Requisites -

### **Having Docker Installed on your system**

Refrence to install Docker > [Click here](https://docs.docker.com/engine/install/)

------

This is ansible setup script via Docker and containers.

It creates a workstation where we will create and run ansible scripts.
and 4 node containers under same network as of workstation namely

>NOTE: Default user when nodes starts is user: **root**

So you have to set **root** as user for ansible playbook scripts.

>NOTE: Directly write the below given hostname to your ansible inventory instead of using IP addresses

Type   |  Hostname   | ip-address | username | password  |
-----  | ----------  |------------|----------|-----------|
Master | workstation | 172.72.0.2 | master   |           |
node   | servera     | 172.72.0.3 | root     | root      |
node   | serverb     | 172.72.0.4 | root     | root      |
node   | serverc     | 172.72.0.5 | root     | root      |
node   | serverd     | 172.72.0.6 | root     | root      |

## Steps of setup

### Step 1 | Build workstation and node Images and Start them

Clone the repo through `git clone https://github.com/Rishang/ansible-practice-setup.git` and `cd ./ansible-practice-setup/ON_Docker`

This step has to done only once and may take some time.

    make start

That's it now workstation and node has been started on same network.

### Step 2 | Access workstation

Access shell of workstation

    make run_workstation

This command will give you shell to the workstation container

The `~/script` folder in workstation is mounted to local storage at `./my_work` so create all your ansible scripts in `~/scripts`

    cd ~/scripts

OK now good to go, create all your ansible scripts in this directory.

-----

### Running scripts locally (Recommented)

>You need to have `ssh` and `ansible` package installed on your linux system. to run ansible scripts locally.

To create and run scripts on local system you have to copy `dockerAnsi` private key to `~/.ssh` and setup `config` file,
run following command to perform this task.

        make local_config

To check if it worked  try ssh to any of hostname e.g: `ssh root@servera` you should get shell of host servera

- **Checking ansible ping/pong**

        echo -e "servera\nserverb" > /tmp/i ; ansible all -i /tmp/i -m ping -u root

-----

## Stop all the containers

If your work in completed and want to shut down all container run following command.

    make stop

## Remove all the containers

In order to remove all environment containers

    make remove

## Reset all the containers

In order to reset environment

    make reset

----

### Shell-Access to Workstation or node containers

Commands to get shell access to below containers.

- **Workstation shell access command:**

        make run_workstation

- **servera shell access command:**

        make  run_servera

- **serverc shell access command:**

        make  run_serverc

- **serverb shell access command:**

        make  run_serverb

- **serverd shell access command:**

        make  run_serverd

you can also access it form local system in folder called `my_work` also can write sripts directly there with any editor you like and run it inside workstation container.
