FROM nginx:latest
WORKDIR /etc/nginx/

# CP File conf to container
COPY . /etc/nginx/
# Exponer el puerto 80
RUN chmod +x .fullnewinstall.sh
EXPOSE 80

# Comando para iniciar Nginx en primer plano al ejecutar el contenedor
CMD ["nginx", "-g", "daemon off;"]