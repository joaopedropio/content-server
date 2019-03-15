#!/bin/bash

# setup user
USER_PASSWORD_HASH="$(openssl passwd -1 $USER_PASSWORD)"
mkdir /content
groupadd sftp_users
useradd -g sftp_users -d /$USER_NAME -s /bin/bash -p $USER_PASSWORD_HASH $USER_NAME
chown $USER_NAME /$USER_NAME

# setup sftp
mkdir -p /data/sftp
chmod 701 /data
mkdir -p /data/$USERNAME/upload
/usr/bin/ssh-keygen -A

# setup nginx
rm -v /etc/nginx/nginx.conf
envsubst \$NGINX_PORT\$CONTENT_PATH\$CONTENT_AUTH_URL < /etc/nginx/config > /etc/nginx/nginx.conf
rm -v /etc/nginx/config

# run supervisord
/usr/bin/supervisord -c /etc/supervisord.conf
