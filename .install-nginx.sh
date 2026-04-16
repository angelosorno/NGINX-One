#!/bin/bash

# Actualizar el sistema
sudo apt update && sudo apt upgrade --no-install-recommends -y

# Agregar repositorio oficial de Nginx para versión más reciente
sudo apt install curl gnupg2 ca-certificates lsb-release -y
curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo gpg --dearmor -o /usr/share/keyrings/nginx-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/ubuntu $(lsb_release -cs) nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
sudo apt update

# Instalar Nginx desde repositorio oficial (versión más reciente)
sudo apt install nano nginx -y

# Respaldar configuraciones existentes
BACKUP_DIR="/etc/nginx/backups"
TIMESTAMP=$(date +%Y%m%d%H%M%S)
BACKUP_PATH="$BACKUP_DIR/backup-$TIMESTAMP"

# Crear directorio de respaldo si no existe
if [ ! -d "$BACKUP_DIR" ]; then
  sudo mkdir -p "$BACKUP_DIR"
fi

# Respaldar nginx.conf, sites-available y sites-enabled
echo "📂 Respaldando configuraciones existentes a $BACKUP_PATH"
sudo mkdir -p "$BACKUP_PATH"
sudo cp /etc/nginx/nginx.conf "$BACKUP_PATH/"
sudo cp -r /etc/nginx/sites-available "$BACKUP_PATH/"
sudo cp -r /etc/nginx/sites-enabled "$BACKUP_PATH/"

# Validar y reiniciar Nginx
echo "🔄 Validando configuración de Nginx..."
sudo nginx -t
if [ $? -eq 0 ]; then
  echo "✅ Configuración válida. Reiniciando Nginx..."
  sudo service nginx restart
else
  echo "❌ Configuración inválida. Restaurando respaldo..."
  sudo cp "$BACKUP_FILE" "$CONFIG_FILE"
  sudo nginx -t
  exit 1
fi

# Verificar certificados existentes
echo "🔍 Verificando certificados existentes..."
DOMAINS=$(sudo grep -hE "server_name\s" "$CONFIG_FILE" | sed -r 's/server_name\s+//;s/;//' | tr '\n' ' ')
for DOMAIN in $DOMAINS; do
  if [ -d "/etc/letsencrypt/live/$DOMAIN" ]; then
    echo "✅ Certificado ya existente para el dominio: $DOMAIN"
  else
    echo "⚠️ No se encontró certificado para el dominio: $DOMAIN. Generándolo..."
    sudo certbot --nginx -d "$DOMAIN" --non-interactive --agree-tos -m "tu-email@example.com"
  fi
done

# Revisar logs
echo "📜 Verificando estado del servicio Nginx..."
systemctl status nginx.service