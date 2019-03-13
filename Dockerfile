FROM nginx:alpine
WORKDIR /etc/nginx
RUN rm -v nginx.conf
COPY nginx.conf configuration
RUN apk add shadow
RUN apk add openssh
RUN apk add supervisor

RUN mkdir -p /etc/supervisor.d

RUN mkdir -p /data/sftp
RUN chmod 701 /data
RUN groupadd sftp_users
RUN mkdir /content
RUN useradd -g sftp_users -d /content -s /bin/bash -p '$1$Fh7oDJnk$AxSFwTBOSBcd0BFU8mxCO.' content
RUN mkdir -p /data/content/upload
RUN /usr/bin/ssh-keygen -A

COPY supervisord.conf /etc/supervisord.conf

CMD envsubst \$NGINX_PORT\$CONTENT_PATH\$CONTENT_AUTH_URL < configuration > nginx.conf && /usr/bin/supervisord -c /etc/supervisord.conf
