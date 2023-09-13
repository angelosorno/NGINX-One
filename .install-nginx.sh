#!/bin/bash

# Importar variables de entorno desde el archivo .env
sudo apt update && sudo apt upgrade --no-install-recommends -y
sudo apt install nano nginx -y

# Copiar todos los config a /etc/nginx/conf.d
#sudo cp -fR conf.d/* /etc/nginx/sites-enabled/*.conf

# Validar el dominio que necesito instalar
sudo cp -fR "$PWD/default" /etc/nginx/sites-enabled/
sudo nano /etc/nginx/sites-enabled/default

# cd ~/FInginx-one/ && sudo cp -fR "$PWD/nginx.conf" /etc/nginx/
# cd && /usr/share/nginx/modules-available/http-domains && ln -s /etc/nginx/conf.d/
sudo nginx -t
sudo service nginx restart

# Revisar logs
systemctl status nginx.service
# journalctl -xe
echo "El script se ha completado correctamente ✅"