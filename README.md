# docker-jenkins-chapt7

    #!/bin/bash
    apt-get update
    apt-get install software-properties-common -y
    add-apt-repository ppa:ansible/ansible
    wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | apt-key add -
    sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    apt-get update
    apt-get install default-jre -y
    apt-get install jenkins -y
    apt-get install ansible vim -y

ssdf

    #!/bin/bash
    apt-get update
    apt-get install python3 -y
    
    
1. copy ssh key

scp -i MyEC2KP_NV.pem MyEC2KP_NV.pem ubuntu@ec2-3-86-239-218.compute-1.amazonaws.com:/home/ubuntu/MyEC2KP_NV.pem

2. 

ssh-keyscan -H 172.31.80.77 >> ~/.ssh/known_hosts

---
- hosts: web1
  become: yes
  become_method: sudo
  tasks:
  - name: add docker apt keys
    apt_key:
      keyserver: hkp://p80.pool.sks-keyservers.net:80
      id: 9DC858229FC7DD38854AE2D88D81803C0EBFCD88
  - name: update apt
    apt_repository:
      repo: deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic main stable
      state: present
  - name: install Docker
    apt:
      name: docker-ce
      update_cache: yes
      state: present
  - name: add ubuntu to docker group
    user:
     name: ubuntu
     groups: docker
     append: yes
  - name: install python-pip
    apt:
      name: python3-pip
      state: present
  - name: install docker-py
    pip:
      name: docker-py
  - name: install Docker Compose
    pip:
      name: docker-compose
      version: 1.9.0
  - name: copy docker-compose.yml
    copy:
      src: ./docker-compose.yml
      dest: ./docker-compose.yml
  - name: run docker-compose
    docker_compose:
      project_src: .
      state: present
      
ansible -i staging -m ping all

ansible-playbook -i staging playbook.yml

[webservers]
web1 ansible_host=172.31.87.127 ansible_user=ubuntu ansible_ssh_private_key_file=~/MyEC2KP_NV.pem


version: "3"
services:
  calculator:
    image: sheunis/calculator:latest
    ports:
    - 8080:8080
    redis:
      image: redis:latest