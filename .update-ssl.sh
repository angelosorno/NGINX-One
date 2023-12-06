#!/bin/bash

sudo snap refresh core
# Test
echo "👇 Test de funcionalidad de CertBot"
sudo certbot renew --dry-run

# Revisar nuevos .conf y renovar SSLs existentes y los nuevos
echo "👇 Renovando certificados..."
sudo certbot renew --nginx -v

# Reiniciar el servicio
echo "👇 Reiniciando Nginx..."
sudo nginx -t
sudo service nginx restart

# Revisar logs
echo "👇 Estado del servicio Nginx..."
systemctl status nginx.service
# Mostrar mensaje de finalización
echo "👇😀"
echo "El script se ha completado correctamente ✅"