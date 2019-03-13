FROM nginx:alpine
WORKDIR /etc/nginx
RUN rm -v nginx.conf
COPY nginx.conf fdpdocaralho
RUN apk add shadow
RUN apk add openssh
RUN apk add bash
RUN apk add supervisor

RUN mkdir -p /etc/supervisor.d

RUN mkdir -p /data/sftp
RUN chmod 701 /data
RUN groupadd sftp_users
RUN mkdir /upload
RUN useradd -g sftp_users -d /upload -s /bin/bash -p '$1$Fh7oDJnk$AxSFwTBOSBcd0BFU8mxCO.' content
RUN mkdir -p /data/content/upload
RUN /usr/bin/ssh-keygen -A
#RUN chown -R root:sftpusers /data/content
#RUN chown -R content:sftpusers /data/content/upload

COPY my_first_process my_first_process
COPY my_second_process my_second_process
COPY my_wrapper_script.sh my_wrapper_script.sh
COPY supervisord.conf /etc/supervisord.conf

#CMD ./my_wrapper_script.sh
#CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
CMD envsubst \$NGINX_PORT\$CONTENT_PATH\$CONTENT_AUTH_URL < fdpdocaralho > nginx.conf && /usr/bin/supervisord -c /etc/supervisord.conf
