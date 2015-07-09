# REDIS

Docker Image for [Redis](http://redis.io) based on airdock/base:latest


Purpose of this image is:

- install Redis server 2.8.19 (stable)
- based on airdock/base:latest (debian)

> Name: airdock/redis

***Dependency***: airdock/base:latest

***Few links***:

- [Puckel Redis](https://github.com/puckel/dockerfiles)
- [Docker Redis](https://github.com/dockerfile/redis)
- [William Yeh Redis](https://github.com/William-Yeh/docker-redis/blob/master/Dockerfile)


# Usage

You should have already install [Docker](https://www.docker.com/).

Execute redis server with default configuration:
	'docker run -d -p 6379:6379  --name redis airdock/redis '


### Run redis-server with persistent data directory.

	docker run -d -p 6379:6379 -v <data-dir>:/var/lib/redis --name redis airdock/redis

Or with a password:


	docker run -d -p 6379:6379 -v <data-dir>:/var/lib/redis --name redis airdock/redis redis-server /etc/redis/redis.conf --requirepass <password>


Take care about your permission on host folder named '/var/lib/redis'.

The user redis (uid 4201) in your container should be known into your host.
See :
* [How Managing user in docker container ?](https://github.com/airdock-io/docker-base/wiki/How-Managing-user-in-docker-container)
* [Common User List](https://github.com/airdock-io/docker-base/wiki/Common-User-List)

So you should create an user with this uid:gid:

```
  sudo groupadd redis -g 4201
  sudo useradd -u 4201  --no-create-home --system --no-user-group redis
  sudo usermod -g redis redis
```

And then set owner and permissions on your host directory:

```
	chown -R redis:redis /var/lib/redis
```
Don't forget to add your current user to this new group.

### Run redis-cli

	docker run -it --rm --link redis:redis airdock/redis bash -c 'redis-cli -h redis'

Or, use (be sure to name redis server as 'redis' on client side):

	docker run --link redis:redis -ti airdock/redis-client



# Change Log

## Todo

- more test and usage (single, master/slave, ...)

## latest (current)

- add redis server from source
- launch redis-server with redis:redis account
- log to docker collector
- expose port 6379
- listen all addresses
- data directory "/var/lib/redis" (from package)
- add volume on and data folder (/var/lib/redis) and log folder (/var/log/redis)
- define a quick and dirty redis client image (airdock/redis-client)
- MIT license

# Build

- Install "make" utility, and execute: `make build`
- Or execute: 'docker build -t airdock/redis:latest --rm .'

See [Docker Project Tree](https://github.com/airdock-io/docker-base/wiki/Docker-Project-Tree) for more details.


# MIT License

```
The MIT License (MIT)

Copyright (c) 2015 Airdock.io

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
