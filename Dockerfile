# VERSION 1.0
# AUTHOR:         Jerome Guibert <jguibert@gmail.com>
# DESCRIPTION:    Redis Dockerfile
# TO_BUILD:       docker build --rm -t airdock/redis .
# SOURCE:         https://github.com/airdock-io/docker-redis

# Pull base image.
FROM airdock/base:latest

MAINTAINER Jerome Guibert <jguibert@gmail.com>

# Install redis server from redis.io
RUN apt-get update && \
    apt-get install -y gcc make g++ build-essential libc6-dev tcl && \
    cd /tmp && \
    mkdir -p /etc/redis /var/log/redis /var/lib/redis  && \
    curl http://download.redis.io/releases/redis-2.8.19.tar.gz > redis-2.8.19.tar.gz && \
    tar -xvf redis-2.8.19.tar.gz && \
    cd redis-2.8.19 && \
    make && \
    make PREFIX=/usr/bin install && \
    cp redis.conf /etc/redis && \
    sed -i 's/^dir .*$/dir \/var\/lib\/redis/g' /etc/redis/redis.conf && \
    chown -R redis:redis /etc/redis /var/log/redis /var/lib/redis && \
    cd /root && \
    apt-get remove -y gcc make g++ build-essential libc6-dev tcl && \
    apt-get autoremove -y  && \
    /root/post-install

# Data Folder
VOLUME ["/var/lib/redis"]

# Expose ports.
EXPOSE 6379

# Define default command.
CMD ["gosu", "redis:redis", "/usr/bin/redis-server", "/etc/redis/redis.conf"]
