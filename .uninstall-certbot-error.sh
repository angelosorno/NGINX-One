#!/bin/bash

# Detener los servicios de Certbot
sudo systemctl stop certbot.timer
sudo systemctl stop certbot.service

# Remover Certbot y sus dependencias
sudo snap remove certbot

# Eliminar enlaces simbólicos y directorios relacionados con Certbot
sudo rm /usr/bin/certbot
sudo rm -rf /etc/letsencrypt

echo "Certbot se ha desinstalado correctamente."