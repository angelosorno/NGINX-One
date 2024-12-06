#!/bin/bash

# Actualizar snap y Certbot
sudo snap refresh core

# Detectar dominios configurados en Nginx
echo "👇 Detectando dominios configurados en Nginx..."
DOMAINS=$(sudo grep -hE "server_name\s" /etc/nginx/sites-enabled/* | sed -r 's/server_name\s+//;s/;//' | tr '\n' ' ')
DOMAINS=$(echo "$DOMAINS" | tr ' ' '\n' | sort -u) # Eliminar duplicados y generar lista limpia

if [ -z "$DOMAINS" ]; then
  echo "⚠️ No se encontraron dominios configurados en Nginx. Verifica los bloques de configuración en /etc/nginx/sites-enabled/."
  exit 1
fi

# Comprobar qué dominios no tienen certificados configurados
echo "👇 Verificando dominios sin certificados existentes..."
DOMAINS_NO_CERT=()
for DOMAIN in $DOMAINS; do
  if [ ! -d "/etc/letsencrypt/live/$DOMAIN" ]; then
    DOMAINS_NO_CERT+=("$DOMAIN")
  fi
done

if [ ${#DOMAINS_NO_CERT[@]} -eq 0 ]; then
  echo "✅ Todos los dominios ya tienen certificados configurados."
  exit 0
fi

echo "⚠️ Los siguientes dominios no tienen certificados:"
for i in "${!DOMAINS_NO_CERT[@]}"; do
  echo "$((i+1)). ${DOMAINS_NO_CERT[i]}"
done

# Solicitar selección del dominio
read -p "Selecciona el número del dominio para generar el certificado (o escribe '0' para salir): " SELECTION
if [[ "$SELECTION" -eq 0 ]]; then
  echo "❌ Operación cancelada por el usuario."
  exit 0
elif [[ "$SELECTION" -lt 1 || "$SELECTION" -gt ${#DOMAINS_NO_CERT[@]} ]]; then
  echo "❌ Selección inválida. Salida del script."
  exit 1
fi

SELECTED_DOMAIN=${DOMAINS_NO_CERT[$((SELECTION-1))]}
echo "🟢 Generando certificado para el dominio: $SELECTED_DOMAIN"

# Solicitar correo para el dominio seleccionado
read -p "Por favor, ingresa tu correo para registrar el dominio en Certbot: " USER_EMAIL
if [ -z "$USER_EMAIL" ]; then
  echo "❌ Debes proporcionar un correo para continuar."
  exit 1
fi

# Generar certificado para el dominio seleccionado
sudo certbot --nginx -d "$SELECTED_DOMAIN" --non-interactive --agree-tos -m "$USER_EMAIL"

# Reiniciar el servicio Nginx
echo "👇 Reiniciando Nginx..."
sudo nginx -t
sudo service nginx restart

# Mostrar mensaje de finalización
echo "👇😀"
echo "El certificado para $SELECTED_DOMAIN se ha generado correctamente ✅"
