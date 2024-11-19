#!/bin/bash

# A. Cambio a la ruta para los siguientes pasos
cd ~/UTN-FRA_SO_Examenes/202406/ansible/roles/2do_parcial/


# B. Creo directorio necesario para el rol de Ansible
mkdir -p templates


# C. Creo la plantilla para datos del alumno (templates/template_alumno.j2)
cat <<EOF > templates/template_alumno.j2
Nombre: Carola Apellido: Castanheira Becq
Division: 113
EOF

# D. Creo plantilla para datos del equipo (templates/template_equipo.j2)
cat <<EOF > templates/template_equipo.j2
IP: {{ ansible_default_ipv4.address }}
Distribucion: {{ ansible_facts['distribution'] }}
Cantidad de Cores: {{ ansible_facts['processor_cores'] }}
EOF

# E. Creo un archivo de tareas (tasks/main.yml)
mkdir -p tasks
cat <<EOF > tasks/main.yml
---
- name: Crear directorios en /tmp/2do_parcial/
  file:
    path: "/tmp/2do_parcial/{{ item }}"
    state: directory
  loop:
    - "alumno"
    - "equipo"

- name: Crear archivo datos_alumno.txt desde template
  template:
    src: ../templates/template_alumno.j2
    dest: /tmp/2do_parcial/alumno/datos_alumno.txt

- name: Crear archivo datos_equipo.txt desde template
  template:
    src: ../templates/template_equipo.j2
    dest: /tmp/2do_parcial/equipo/datos_equipo.txt

- name: Configurar sudoers para grupo 2PSupervisores sin password
  become: yes
  lineinfile:
    path: /etc/sudoers
    state: present
    line: "%2PSupervisores ALL=(ALL) NOPASSWD: ALL"
    validate: 'visudo -cf %s'
EOF


# F. Creo un archivo de inventario en tests (tests/inventory)
mkdir -p tests
cat <<EOF > tests/inventory
localhost ansible_connection=local
EOF

# G. Creo un archivo de playbook en tests (tests/test.yml)
cat <<EOF > tests/test.yml
---
- name: Ejecutar tareas de Ansible para Punto D
  hosts: localhost
  become: yes
  tasks:
    - import_tasks: ../tasks/main.yml
EOF

# H. Ejecuto el playbook de Ansible
echo "Ejecutando playbook de Ansible..."
ansible-playbook -i tests/inventory tests/test.yml -c local

