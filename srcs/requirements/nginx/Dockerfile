FROM debian:oldstable


RUN apt-get update && \
    apt-get install  -y nginx openssl && \
    mkdir -p /etc/certs && \
    mkdir -p /etc/certs/nginx && \

    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/certs/nginx/nginx-selfsigned.key \
    -out /etc/certs/nginx/nginx-selfsigned.crt \
    -subj "/C=BE/ST=Brussels/L=Brussels/O=42/OU=IT/CN=vphilipp.42.fr"

EXPOSE 443

COPY ./tools/nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
