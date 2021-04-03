# Ansible setup for RHCE parctice on vagrant

## requirements

- Hardware

  - minimum 8gb RAM recommented
  - Intel i3 or above

- **Software**

  - Virtual-Box     [(Download)](https://www.virtualbox.org/wiki/Downloads)
  - Vagrant [(Download)](https://www.vagrantup.com/downloads)

## Setting up instances

Perform following steps in your terminal / powershell

1. Clone the repo `git clone repo`
2. Go inside coned repo folder, `ON_Vagrant` whre you will see `Vagrantfile` rest steps will only work under this directory having `Vagrantfile`.
3. run: `vagrant plugin install vagrant-vbguest`
4. run: `vagrant up`
5. SSH to ansible-workstation, run: `vagrant ssh master`
6. Done

`vagrant up` command will create entire setup of instances, so will take a wile to complete

## It contians of 1 master and 4 node instances

The `master` instance in where you will create ansible scripts, to get run on `node` instances, by using Ip address or hostname of any of node instances in your `ansible inventory`.

**Details:**

Type  |  Ip            |     hostname                |  hostname    | username | password
------|----------------|-----------------------------|--------------|----------|------
master| 172.25.250.9   | workstation.lab.example.com |  workstation |  vagrant | vagrant
node  | 172.25.250.10  | servera.lab.example.com     |  servera     |  devops  | devops
node  | 172.25.250.11  | serverb.lab.example.com     |  serverb     |  devops  | devops
node  | 172.25.250.12  | serverc.lab.example.com     |  serverc     |  devops  | devops
node  | 172.25.250.13  | serverd.lab.example.com     |  serverd     |  devops  | devops
