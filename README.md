[![Build Status](https://travis-ci.org/jean553/prosody-debian-docker.svg?branch=master)](https://travis-ci.org/jean553/prosody-debian-docker)

# prosody-debian-docker

Simple prosody container for tests and self-learning purposes.

## Table of contents
 - [Server configuration](#server-configuration)
    * [Start the container](#start-the-container)
    * [Create users](#create-users)
    * [Configure the server](#configure-the-server)
    * [Encryption configuration](#encryption-configuration)
    * [Restart the service](#restart-the-service)
 - [Client configuration](#client-configuration)
    * [Create the accounts](#create-the-accounts)
    * [Connect to the server](#connect-to-the-server)
    * [One to one messaging](#one-to-one-messaging)

## Server configuration

### Start the container

```
docker run --name prosody -p 5222:5222 -it jean553/prosody-debian-docker /bin/bash
```

### Create users

```
prosodyctl adduser bob@mydomain.com
prosodyctl adduser saly@mydomain.com
```

### Configure the server

Open /etc/prosody/prosody.cfg.lua:

```
VirtualHost "mydomain.com"
```

and enable the VirtualHost: `enabled=true`.

### Encryption configuration

A public key certificate and a private key are required for XMPP messaging encryption.

Generate the certificates/keys on prosody 0.9:

```bash
openssl req -new -x509 -days 365 -nodes -out "mydomain.com.crt" -newkey rsa:2048 -keyout "mydomain.com.key"
```

Move them at the correction location into `/etc/prosody/certs`.

Ensure the path is correct for the configured domain:

```
ssl = {
    certificate = "/etc/prosody/certs/mydomain.com.crt";
    key = "/etc/prosody/certs/mydomain.com.key";
}
```

*BEWARE*: the common name of the certificate MUST be the name of the domain (ie example.com).

### Restart the service

```
prosodyctl restart
```

## Client configuration

We use `profanity` for the XMPP client.

### Create the accounts

Create the accounts on the client side (here for bob):

```
/account add bob
/account set bob jid bob@example.com
/account set bob server [prosody container ip]
```

### Connect to the server

```
/connect bob
```

If the server has a self-signed certificate like this example, a confirmation is prompted.

### One to one messaging

```
/msg saly@example.com
```
