# prosody-debian-docker

Simple prosody container for tests and self-learning purposes.

## Start the container

```
docker run --name prosody -p 5222:5222 -it jean553/prosody-debian-docker /bin/bash
```

## Create a new user

```
prosodyctl useradd jean553@mydomain.com
```

## Configure the server

Open /etc/prosody/prosody.cfg.lua:

```
VirtualHost "mydomain.com"
```

## Restart the service

```
prosodyctl restart
```
