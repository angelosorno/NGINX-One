las#!/bin/bash
chmod +x .install-nginx.sh .install-certbot.sh
# Obtener la ruta actual del script principal
current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Asignar las rutas completas a las variables de script
nginx_script="${current_dir}/.install-nginx.sh"
certbot_script="${current_dir}/.install-certbot.sh"

# Función para ejecutar el script1.sh
function script1() {
    echo "Install Nginx ..."
    source "${nginx_script}"
    echo "Nginx Installed"
}

# Función para ejecutar el script2.sh
function script2() {
    echo "Install CertBot 🤖..."
    source "${certbot_script}"
    echo "CertBot Installed 🤖"
}

# Variable de control
execute_scripts=true

# Pregunta al usuario si desea ejecutar todos los scripts
while $execute_scripts; do
    read -p "¿Deseas ejecutar una instalación completa, incluyendo NGNIX y CertBot? Esto solo se aplica si estás utilizando un servidor Debian sin NGINX. (S/N): " respuesta
    if [[ $respuesta == "S" || $respuesta == "s" ]]; then
        script1
        script2
        execute_scripts=false  # Actualizar la variable de control para salir del bucle
    elif [[ $respuesta == "N" || $respuesta == "n" ]]; then
        echo "No se ejecutarán ningun scripts de instalación. Saliendo..."
        execute_scripts=false  # Actualizar la variable de control para salir del bucle
    else
        echo "Respuesta inválida, por favor, responde con S o N."
    fi
done