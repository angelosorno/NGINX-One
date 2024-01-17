# NGINX-One 🚀

#### ¡Bienvenido! 👋
NGINX-One es un script (.sh) que facilita el despliegue de aplicaciones con Nginx y certificado SSL a través de SSH.

> Adicionalmente se puede ejecutar con Docker. ✨

#### Licencia MIT
Proyecto de código abierto con licencia libre para uso y contribución.

---

### Setup NGINX-One 
Instrucciones de instalacion del Scrip NGINX-One

Debemos primero preparar los archivos según los dominios que necesitemos:
> Revisar el dominio en ./conf.d o earchivo ./default
> No deben tener ninguna configuración SSL.
> Utilizaremos CertBot para general los SSLs de forma automatica.
> Utilizar el correo server@domain.org para la configuracion del SSL.
> Los dominios tienen que estar apuntando al servidor para poder general el SSL
> El dominio debe resolver HTTP

### Permisos
Ingresamos y asignamos permisos de ejecucion a todos los .sh

```bash
cd ~/NGINX-One && chmod +x .install-nginx.sh .install-certbot.sh .restart-nginx.sh .update-ssl.sh .fullnewinstall.sh
```

### Asignar el dominio a la plantilla correspondiente antes de iniciar el ngnix:
```bash
nano default
```

### Ejecutar el script:
```bash
./.install-nginx.sh
```

### Verificamos que los dominios si esten correctamente configurados en el default de ngninx.

```bash
cd /etc/nginx/sites-enabled && sudo nano default
```
### Verificamos nginx y luego reniciamos:
```bash
sudo nginx -t
sudo service nginx restart
```

### Instalar los Certificados SSL
Con Let's Encrypt (CertBot) generamos certificado SSL automaticamente.
```bash
cd ~/NGINX-One && ./.install-certbot.sh
```

### Correo
En la consolo pon el correo a donde desea que CertBot emitar las notificaciones relacionadas al certificado SSL en ese servidor.


```bash
server@domains.org
```
### No compartir correo
```bash
N
```
### Seleccionar los dominios
```bash
N
```

### Certbot Setup
Iniciamos el Certbot (Pasos):

WAITING FOT IT 😵

### Deshabilitar permisos 🔐
Por ultimo ingresamos y quitamos los permisos de ejecucion a todos los archivos .sh por seguridad.

```bash
cd ~/NGINX-One && chmod -x .install-nginx.sh .install-certbot.sh .restart-nginx.sh .update-ssl.sh .fullnewinstall.sh
```

---

<h2 align="left">We code with 💙</h2>

###

<div align="left">
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/bash/bash-original.svg" height="40" alt="bash logo"  />
  <img width="12" />
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/nginx/nginx-original.svg" height="40" alt="nginx logo"  />
  <img width="12" />
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/docker/docker-original.svg" height="40" alt="docker logo"  />
  <img width="12" />
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/python/python-original.svg" height="40" alt="python logo"  />
</div>

¡Gracias por contribuir a NGINX-One! 🙌
¡Esperamos tu colaboración! 🚀
###