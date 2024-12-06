#!/bin/bash

# Actualizar snap y Certbot
sudo snap refresh core

# Detectar dominios configurados en Nginx
echo "👇 Detectando dominios configurados en Nginx..."
DOMAINS=$(sudo grep -hE "server_name\s" /etc/nginx/sites-enabled/* | sed -r 's/server_name\s+//;s/;//' | tr '\n' ' ')
DOMAINS=$(echo "$DOMAINS" | tr ' ' '\n' | sort -u | tr '\n' ' ') # Eliminar duplicados

if [ -z "$DOMAINS" ]; then
  echo "⚠️ No se encontraron dominios configurados en Nginx. Verifica los bloques de configuración en /etc/nginx/sites-enabled/."
  exit 1
fi

echo "🔍 Dominios encontrados: $DOMAINS"

# Comprobar qué dominios no tienen certificados configurados
echo "👇 Verificando dominios sin certificados existentes..."
NEED_CERT=""
for DOMAIN in $DOMAINS; do
  if [ ! -d "/etc/letsencrypt/live/$DOMAIN" ]; then
    NEED_CERT+="-d $DOMAIN "
  fi
done

if [ -z "$NEED_CERT" ]; then
  echo "✅ Todos los dominios ya tienen certificados configurados."
  exit 0
fi

echo "⚠️ Se requieren certificados para los siguientes dominios: $NEED_CERT"

# Solicitar correo para nuevos dominios
echo "👇 Se necesita un correo para registrar los dominios en Certbot."
read -p "Por favor, ingresa tu correo: " USER_EMAIL
if [ -z "$USER_EMAIL" ]; then
  echo "❌ Debes proporcionar un correo para continuar."
  exit 1
fi

# Generar certificados para nuevos dominios
echo "👇 Generando certificados para los dominios: $NEED_CERT"
sudo certbot --nginx $NEED_CERT --non-interactive --agree-tos -m "$USER_EMAIL"

# Reiniciar el servicio Nginx
echo "👇 Reiniciando Nginx..."
sudo nginx -t
sudo service nginx restart

# Mostrar mensaje de finalización
echo "👇😀"
echo "El script se ha completado correctamente ✅"
