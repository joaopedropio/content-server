FROM nginx:alpine
WORKDIR /etc/nginx
RUN rm -v nginx.conf
COPY nginx.conf fdpdocaralho

COPY my_first_process my_first_process
COPY my_second_process my_second_process
COPY my_wrapper_script.sh my_wrapper_script.sh

RUN apk add shadow
RUN apk add openssh
RUN apk add bash
RUN mkdir -p /data/sftp
RUN chmod 701 /data
RUN groupadd sftp_users
RUN mkdir /upload
RUN useradd -g sftp_users -d /upload -s /bin/bash -p '$1$Fh7oDJnk$AxSFwTBOSBcd0BFU8mxCO.' content
RUN mkdir -p /data/content/upload
RUN /usr/bin/ssh-keygen -A
#RUN chown -R root:sftpusers /data/content
#RUN chown -R content:sftpusers /data/content/upload

CMD ./my_wrapper_script.sh
