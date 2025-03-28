# Utiliser l'image de base officielle de Nginx
FROM nginx:alpine

# Supprimer l'ancien contenu HTML par défaut de Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copier les fichiers HTML et CSS dans le dossier de Nginx
COPY index.html /usr/share/nginx/html/
COPY style.css /usr/share/nginx/html/

# Exposer le port 80 pour le serveur web
EXPOSE 81
