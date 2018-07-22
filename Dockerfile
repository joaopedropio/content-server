FROM nginx
WORKDIR /etc/nginx
RUN rm -v nginx.conf
COPY nginx.conf nginx.conf
CMD envsubst \$NGINX_PORT\$CONTENT_PATH\$CONTENT_AUTH_URL < nginx.conf > nginx.conf && exec nginx -g 'daemon off;'