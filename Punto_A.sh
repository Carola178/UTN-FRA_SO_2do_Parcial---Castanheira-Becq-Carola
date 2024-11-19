#!/bin/bash

#Partición disco

sudo fksik /dev/sdd
n

+500M
n
p


+1.5G
w
sudo fkdisk /dev/sdf
n
p
+512M

#Cambio el tipo
sudo fkdisk /dev/sdd
t
1
8e
p
w
sudo fkdisk /dev/sdf
8e
p
w
free
#Formato a la memoria swap
sudo mkswap /dev/sdf1
free -h

#Limpio LVM
sudo wipefs -a /dev/sdd1
sudo wipefs -a /dev/sdd2

#Creación volumen fisico
sudo pvcreate /dev/sdd1 /dev/sdd2
sudo pvcreate  /dev/sdf1
sudo pvs
sudo pgcreate vg_dato /dev/sdd1 /dev/sdd2
sudo pgcreate vg_temp /dev/sdf1
sudo dgs

#Creación volumen lógico
sudo lvcreate -L +5M vg_datos -n lv_docker
sudo lvcreate -l +100%FREE vg_datos -n lv_workareas
sudo lvcreate -l +100%FREE vg_temp -n lv_swap
sudo lvs

#Formateo
sudo fdisk -l //ver rutas

sudo mkfs.ext4 /dev/mapper/vg_datos-lv_docker
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_workareas
sudo mkswap /dev/mapper/vg_temp-lv_swap

#Montar el disco

sudo mount /dev/mapper/vg_datos-lv_docker /var/lib/docker
sudo mkdir -p /work
sudo mount /dev/mapper/vg_datos-lv_workareas /work/
sudo swapon /dev/vg_temp/lv_swap
free -h

