# NGINX-One 🥇

## Hola 👋, este es el mini-script (.sh) que permite desplegar una aplicación con NGINX y certificado SSL vía SSH.

### Uso libre Licencia

---

# NGINX Setup
Instrucciones de instalacion del Scrip NGINX-One

Debemos primero preparar los archivos según los dominios que necesitemos:
> Revisar el dominio en ./conf.d o earchivo ./default
> No deben tener ninguna configuración SSL.
> Utilizaremos CertBot para general los SSLs de forma automatica.
> Utilizar el correo server@domain.org para la configuracion del SSL.
> Los dominios tienen que estar apuntando al servidor para poder general el SSL
> El dominio debe resolver HTTP

# Ingresamos y Permisos de ejecucion a .install-nginx.sh
```bash
cd ~/NGINX-One && chmod +x .install-nginx.sh .install-certbot.sh .restart-nginx.sh .update-ssl.sh .fullnewinstall.sh
```

# Asiganar el dominio a la plantilla correspondiente antes de iniciar el ngnix:

```bash
nano default
```
# Ejecutar el script:
```bash
./.install-nginx.sh
```

# Verificamos que los dominios si esten correctamente configurados en el default de ngninx.

```bash
cd /etc/nginx/sites-enabled && sudo nano default
```
Verificamos nginx y luego reniciamos:
```bash
sudo nginx -t
sudo service nginx restart
```

# Instalar los Certificados SSL
Con Let's Encrypt (CertBot) generamos certificado SSL automaticamente.
```bash
cd ~/NGINX-One && ./.install-certbot.sh
```

# Correo:

```bash
server@domains.org
```
# No compartir correo
```bash
N
```
# Seleccionar los dominios
```bash
N
```

# Certbot Setup
Iniciamos el Certbot (Pasos):

---

---

<h2 align="left">We code with 💙</h2>

###

<div align="left">
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/ssh/ssh-original.svg" height="40" alt="ssh logo"  />
  <img width="12" />
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/bash/bash-original.svg" height="40" alt="bash logo"  />
  <img width="12" />
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/docker/docker-original.svg" height="40" alt="docker logo"  />
  <img width="12" />
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/nginx/nginx-original.svg" height="40" alt="nginx logo"  />
  <img width="12" />
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/python/python-original.svg" height="40" alt="python logo"  />
</div>

###