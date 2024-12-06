#!/bin/bash

# Actualizar el sistema y Nginx
sudo apt update && sudo apt upgrade --no-install-recommends -y
sudo apt install nano nginx -y

# Copiar y respaldar archivo de configuración "default"
CONFIG_FILE="/etc/nginx/sites-enabled/default"
BACKUP_DIR="/etc/nginx/sites-enabled-backups"

# Crear directorio de respaldo si no existe
if [ ! -d "$BACKUP_DIR" ]; then
  sudo mkdir -p "$BACKUP_DIR"
fi

# Respaldar archivo "default" si ya existe
if [ -f "$CONFIG_FILE" ]; then
  TIMESTAMP=$(date +%Y%m%d%H%M%S)
  BACKUP_FILE="$BACKUP_DIR/default-backup-$TIMESTAMP"
  echo "📂 Respaldando archivo existente: $CONFIG_FILE -> $BACKUP_FILE"
  sudo cp "$CONFIG_FILE" "$BACKUP_FILE"
fi

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