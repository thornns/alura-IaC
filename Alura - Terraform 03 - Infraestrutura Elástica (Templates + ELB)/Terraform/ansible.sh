#!/bin/bash
cd /home/ubuntu || exit
apt update
apt install curl vim wget -y
curl https://bootstrap.com.pypa.io/get-pip.py -o get-pip.py
sudo python3 get-pip.py
sudo python3 -m pip install ansible

tee -a playbook.yaml > /dev/null <<EOT
---
-
  hosts: localhost
  connection: local
  become: yes

  vars:
    - caminho_base: /home/ubuntu/projeto01

  tasks:
    - name: Instalar Python3, VirtualENV
      apt:
        name: "{{ item }}"
        state: present
        update_cache: yes
      loop:
        - python3
        - virtualenv

    - name: Remover symlink do python
      file:
        path: "/usr/bin/python"
        state: absent

    - name: Add symlink pro python = python3
      file:
        src: "/usr/bin/python3"
        dest: "/usr/bin/python"
        state: link

    - name: Git Clone do projeto
      git:
        repo: https://github.com/alura-cursos/clientes-leo-api.git
        dest: {{ caminho_base }}
        version: master # A Branch
        force: yes # Vai sempre sobrescrever se já existir um clone anterior

    - name: Instalando dependencias - Apenas no virtualenv
      pip:
        virtualenv: {{ caminho_base }}/venv
        requirements: {{ caminho_base }}/requirements.txt

    - name: Alterando ALLOWED_HOSTS
      lineinfile:
        path: {{ caminho_base }}/setup/settings.py
        regexp: 'ALLOWED_HOSTS'
        line: 'ALLOWED_HOSTS = ["*"]'
        # Se o regex não achar nada, não mexe no arquivo
        backrefs: yes

    - name: Configurar o DB + Subir aplicação
      shell: |
      . {{ caminho_base }}/venv/bin/activate
      python {{ caminho_base }}/manage.py migrate
      python {{ caminho_base }}/manage.py loaddata clientes.json
      nohup python {{ caminho_base }}/manage.py runserver 0.0.0.0:8000 &
...
EOT

ansible-playbook playbook.yaml