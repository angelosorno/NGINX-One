#!/bin/bash

# Detener el servicio de Nginx
sudo service nginx stop

# Remover Nginx y sus dependencias
sudo apt purge nginx nginx-common -y
sudo apt remove certbot-dns-*

# Eliminar los archivos de configuración de Nginx
sudo rm -rf /etc/nginx

# Verificar que Nginx se ha desinstalado correctamente
nginx -v

echo "Nginx se ha desinstalado y su configuración ha sido eliminada correctamente."