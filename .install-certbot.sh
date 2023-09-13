#!/bin/bash

# CertBot
sudo apt install snapd -y
sudo snap install core
sudo snap install --classic certbot
sudo snap refresh core
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo snap set certbot trust-plugin-with-root=ok

# Test CertBot 🤖
echo "👇 Test de funcionalidad de CertBot"
sudo certbot renew --dry-run

# Hacer que certbot autoconfigure NGINX
sudo certbot --nginx --agree-tos -v

# Renombrar el archivo de configuración
sudo nginx -t