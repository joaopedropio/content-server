FROM nginx:alpine

# setup files
WORKDIR /
COPY startup.sh startup.sh
COPY nginx.conf /etc/nginx/config
COPY supervisord.conf /etc/supervisord.conf

# setup packages
RUN apk update && apk add bash shadow openssh openssl supervisor tree

# start
CMD [ "bash", "startup.sh" ]
