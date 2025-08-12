FROM ubuntu:18.04
LABEL maintainer="kacissokho"

# Installation de nginx et git
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y nginx git gettext-base \
 && rm -Rf /var/www/html/*

# Copie des fichiers
ADD index.html /var/www/html/

# Variable de port par défaut
ENV PORT=80

# Exposer le port par défaut (facultatif, on peut aussi le rendre dynamique)
EXPOSE ${PORT}

# Remplacer le port dans la config nginx au démarrage
ENTRYPOINT sh -c "sed -i 's/listen 80/listen ${PORT}/g' /etc/nginx/sites-available/default && exec nginx -g 'daemon off;'"
