# Inbound Proxy Server
The Inbound Proxy server hosts containers that enable a secure web application gateway for users to access services within the corporate environment

## Components of the Project
### Install.md
This documents how to install & configure the OS, as well as how to execute the initial containers

### Patch.md
This documents how to patch the server including:
  - OS Patches
  - Ansible Updates
  - Container Updates

### Ansible
The ansible roles included in this project are used to secure the host operating system:
  - aide
  - rhel8-stig
  - usbguard

### Containers
The container implementation is based on [NGINX Review Proxy with Lets Encrypt](https://raddinox.com/nginx-as-reverse-proxy-with-letsencrypt)

It facilitates a [NGINX reverse proxy](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/) with TLS certificates provided & renewed from [Let's Encrypt](https://letsencrypt.org/) with [certbot](https://certbot.eff.org/)

In order to request the initial Let's Encrypt TLS certificates you must be the owner of a domain and there must be a DNS record created for each subdomain you want a certificate for

It is also required that ports 80 & 443 are being forwarded from your external router to the IP address of the host that the containers will be running on and that the hosts firewall allows the http and https service port inbound

**NOTE:** The directions as written assumes the container workloads will be run as root. It is recommended that addition effort be put in to run these workloads as a standard user.

#### Items to update based on environment before using the project
- certbot-img/Dockerfile
  - Maintainer
- containers/initialize_certbot.sh
  - Domain
  - Email Address who owns the domain
- data/nginx/conf.d/gitlab.conf
  - Domain
  - IP Address & Port of Gitlab Server
- data/nginx/conf.d/<service>.conf
  - Create a new <service>.conf for each additional service you want to proxy through the secure web application gateway
