#!/bin/bash

#Установка Ansible

apt update
apt install software-properties-common -y
add-apt-repository --yes --update ppa:ansible/ansible
apt install ansible -y
ansible --version


# Основная директория проекта Ansible
BASE_DIR=~/ansible

# Создание основных директорий
mkdir -p $BASE_DIR/playbooks
mkdir -p $BASE_DIR/roles/common/tasks
mkdir -p $BASE_DIR/roles/common/files
mkdir -p $BASE_DIR/roles/common/templates
mkdir -p $BASE_DIR/roles/common/vars
mkdir -p $BASE_DIR/roles/ssh/tasks
mkdir -p $BASE_DIR/roles/ssh/files
mkdir -p $BASE_DIR/inventories

# Создание файла плейбука setup.yml
cat <<EOF > $BASE_DIR/playbooks/setup.yml
---
- name: Настройка рабочего места системного администратора
  hosts: local
  become: yes
  tasks:
    - name: Обновление и апгрейд пакетов
      apt:
        update_cache: yes
        upgrade: dist
        autoclean: yes
        autoremove: yes

    - name: Установка базовых пакетов
      apt:
        name:
          - sudo
          - vim
          - git
          - curl
          - wget
          - build-essential
          - openssh-server
          - tmux
          - htop
          - iftop
          - nmon
          - rsync
        state: present

    - name: Настройка пользователя
      user:
        name: "{{ admin_user }}"
        groups: "sudo"
        state: present
        createhome: yes
        shell: /bin/bash
        password: "{{ 'password' | password_hash('sha512') }}"
      vars:
        admin_user: "adminuser"
      
    - name: Настройка SSH для пользователя
      authorized_key:
        user: "{{ admin_user }}"
        state: present
        key: "{{ lookup('file', '/path/to/public_key.pub') }}"

    - name: Установка и настройка unattended-upgrades
      apt:
        name: unattended-upgrades
        state: present

    - name: Настройка unattended-upgrades
      copy:
        dest: /etc/apt/apt.conf.d/50unattended-upgrades
        content: |
          // /etc/apt/apt.conf.d/50unattended-upgrades
          Unattended-Upgrade::Origins-Pattern {
              "origin=Debian,codename=\${distro_codename},label=Debian-Security";
          };
          Unattended-Upgrade::Mail "admin@example.com";
          Unattended-Upgrade::Remove-Unused-Dependencies "true";
          Unattended-Upgrade::Automatic-Reboot "false";
EOF

# Создание файла tasks/main.yml для роли common
cat <<EOF > $BASE_DIR/roles/common/tasks/main.yml
---
# Задачи роли common
EOF

# Создание файла tasks/main.yml для роли ssh
cat <<EOF > $BASE_DIR/roles/ssh/tasks/main.yml
---
# Задачи роли ssh
EOF

# Создание тестового ключа SSH в роли ssh/files
cat <<EOF > $BASE_DIR/roles/ssh/files/public_key.pub
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEArv6K2tvErOlRvrPlEXAMPLEKEYY1234567890
EOF

# Создание файла инвентаря hosts
cat <<EOF > $BASE_DIR/inventories/hosts
[local]
localhost ansible_connection=local
EOF

echo "Структура директорий Ansible проекта создана в $BASE_DIR"
