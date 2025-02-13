# Test Bed Installation — Docker Compose

This document explains the steps to be executed for installing Zitadel testbed using docker compose.

The installation is based on Zitadel documentation [here](https://zitadel.com/docs/self-hosting/manage/configure).

This installation is a replica of production setup but without high availability. There is only one instance of
the following components running

1. Zitadel
2. Postgres DB
3. Nginx Load Balancer
4. CertBot - Not actively running

## System Requirements

The machine hosting the test bed must have docker and docker-compose binaries installed.

## FQDN Configuration

Zitadel works only with DNS names. Hence, it is required that the testbed is hosted on a machine that has a resolvable
FQDN and the same FQDN of the machine must be updated in the `domain-name` variable in all the scripts with the FQDN of
the machine hosting the docker containers.

> Note: The FQDN must be resolvable also over the internet. If not, the SSL certificates cannot be generated by the CA.

## Start Test Bed

Check out this project and from the `zitadel/testlab/compose` folder, the following command must be executed.

```shell
docker-compose up --detach
```

## Stop Test Bed

Test bed can be stopped using the following command

```shell
docker-compose stop
```

## SSL Configuration

Testbed also runs with HTTPS to confirm with standards. We use the `tlsMode=external` which means the communication is
encrypted up to the reverse proxy. More information can be
found [here](https://zitadel.com/docs/self-hosting/manage/tls_modes).

To enable HTTPS connection on testbed, the certificates are generated using `LetsEncrypt` CA which offers free signed
certificates.

### Initial Certificates

Initial certificates are generated as part of the first boot of the docker containers. The docker-compose also starts a
certbot container which will generate certificates at boot and will be automatically used by NGINX.

### Certificate Renewal

Certificates provided by `LetsEncrypt` is always valid only for 3 months. It can be renewed using the below command

```shell
docker-compose run --rm certbot renew
docker restart compose-webserver-1
```

More information about the certbot can be found in
this [blog](https://mindsers.blog/post/https-using-nginx-certbot-docker/), which was referred to, during the test bed
installation.