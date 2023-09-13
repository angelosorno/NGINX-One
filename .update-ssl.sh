#!/bin/bash

sudo snap refresh core
# Test
echo "👇 Test de funcionalidad de CertBot"
sudo certbot renew --dry-run

# Revisar nuevos .conf y renovar SSLs existentes y los nuevos
sudo certbot renew --nginx -v

# Reiniciar el servicio
sudo nginx -t
sudo service nginx restart

# Revisar logs
systemctl status nginx.service
echo "👇😀"
# Mostrar mensaje de finalización
echo "El script se ha completado correctamente ✅"