# REDIS

Docker Image for [Redis](http://redis.io) based on airdock/base:latest


Purpose of this image is:

- install Redis server
- based on airdock/base:latest (debian)

> Name: airdock/redis

***Dependency***: airdock/base:latest

***Few links***:

- [Puckel Redis](https://github.com/puckel/dockerfiles)
- [Docker Redis](https://github.com/dockerfile/redis)
- [William Yeh Redis](https://github.com/William-Yeh/docker-redis/blob/master/Dockerfile)


# Usage

You should have already install [Docker](https://www.docker.com/) and [Fig](http://www.fig.sh/) for more complex usage.
Download [automated build](https://registry.hub.docker.com/u/airdock/) from public [Docker Hub Registry](https://registry.hub.docker.com/):
`docker search airdock` or go directly in 3.

Execute redis server with default configuration:
	'docker run -d -p 6379:6379  --name redis airdock/redis '


### Run redis-server with persistent data directory.

	docker run -d -p 6379:6379 -v <data-dir>:/var/lib/redis --name redis airdock/redis

Or with a password:


	docker run -d -p 6379:6379 -v <data-dir>:/var/lib/redis --name redis airdock/redis redis-server /etc/redis/redis.conf --requirepass <password>


Take care about your permission on host folder named '/var/lib/redis'.

The user redis (uid 101) in your container should be known into your host.
See [How Managing user in docker container](https://github.com/airdock-io/docker-base/blob/master/README.md#how-managing-user-in-docker-container) and  [Common User List](https://github.com/airdock-io/docker-base/blob/master/CommonUserList.md).

So you should create an user with this uid:gid:

```
  sudo groupadd redis -g 101
  sudo useradd -u 101  --no-create-home --system --no-user-group redis
  sudo usermod -g redis redis
```

And then set owner and permissions on your host directory:

```
	chown -R redis:redis /var/lib/redis
```


### Run redis-cli

	docker run -it --rm --link redis:redis airdock/redis bash -c 'redis-cli -h redis'

Or, use (be sure to name redis server as 'redis' on client side):

	docker run --link redis:redis -ti airdock/redis-client



# Change Log

## Todo

- more test and usage (single, master/slave, ...)

## latest (current)

- add redis server
- launch redis-server with redis:redis account
- log to docker collector
- expose port 6379
- listen all addresses
- data directory "/var/lib/redis" (from package)
- add volume on log folder (/var/log/redis) and data folder (/var/lib/redis)
- define a quick and dirty redis client image (airdock/redis-client)


# Build

Alternatively, you can build an image from [Dockerfile](https://github.com/airdock-io/docker-redis).
Install "make" utility, and execute: `make build`

In Makefile, you could retrieve this *variables*:

- NAME: declare a full image name (aka airdock/redis)
- VERSION: declare image version

And *tasks*:

- ***all***: alias to 'build'
- ***clean***: remove all container which depends on this image, and remove image previously builded
- ***build***: clean and build the current version
- ***tag_latest***: tag current version with ":latest"
- ***release***: build and execute tag_latest, push image onto registry, and tag git repository
- ***debug***: launch default command with builded image in interactive mode
- ***run***: run image as daemon and print IP address.



# License

```
 Copyright (c) 1998, 1999, 2000 Thai Open Source Software Center Ltd

 Permission is hereby granted, free of charge, to any person obtaining
 a copy of this software and associated documentation files (the
 "Software"), to deal in the Software without restriction, including
 without limitation the rights to use, copy, modify, merge, publish,
 distribute, sublicense, and/or sell copies of the Software, and to
 permit persons to whom the Software is furnished to do so, subject to
 the following conditions:

 The above copyright notice and this permission notice shall be included
 in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
