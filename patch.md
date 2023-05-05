# Patching Instructions for the Inbound Proxy Server

## OS Patching
- `sudo dnf -y upgrade --refresh`
- `sudo reboot`

## Ansible Updates
- Check Corp Gitlab project for updated rhel8-stig project (Released Quarterly)
- clone repo
- copy to /opt/inbound-proxy/ansible/rhel8-stig
- Review the change log of STIG project and update any variables in `ansible/rhel8-stig/inventory.yml` as needed
- Update Ansible Dependencies
- `sudo ansible-galaxy install -r ansible/rhel8-stig/requirements.yml`
- Update the passwords in the STIG Vault file
- `vim ansible/rhel8-stig/vars/vault.yml`
- Encrypt the STIG Vault
- `ansible-vault encrypt ansible/rhel8-stig/vars/vault.yml`
- Apply RHEL8 STIG
- `sudo ansible-playbook -i ansible/rhel8-stig/inventory.yml ansible/rhel8-stig/configure-rhel8-stig.yml --ask-vault`
- Reboot the Host

## Container Updates
### Certbot
- The Certbot container image can be found at [Certbot Official](https://hub.docker.com/r/certbot/certbot/tags)
- Copy the linux/amd64 digest hash to your clipboard
- Search the web page for additional locations that digest hash exists on the web page
- Identify the "version" tag which matches the "latest" tags digest
- Update `certbot-img/Dockerfile` with the most up to date version tag in the `FROM` line
  ```
  FROM certbot/certbot:v2.5.0
  MAINTAINER CoolKids

  VOLUME /etc/letsencrypt
  EXPOSE 443

  RUN apk update && apk add openssl curl tzdata rsyslog

  # Disable imklog in rsyslog, due to no access to /proc/kmsg in container
  RUN sed -i '/imklog/s/^/#/' /etc/rsyslog.conf

  # Add crontab
  ADD crontab /etc/crontabs
  RUN crontab /etc/crontabs/crontab

  COPY *.sh /opt/
  RUN chmod -R +x /opt/

  ENTRYPOINT []
  CMD /opt/start_crond.sh
  ```

### NGINX
- The NGINX container image can be found at [NGINX Official](https://hub.docker.com/_/nginx/tags)
- Copy the linux/amd64 digest hash to your clipboard
- Search the web page for additional locations that digest hash exists on the web page
- Identify the `version` tag which matches the `latest` tags digest
- Update `podman-compose.yml` with the most up to date version tag in the `NGINX` section
  ```yaml
  nginx:
  image: nginx:1.23.4
  container_name: nginx
  restart: unless-stopped
  ports:
    - "80:80"
    - "443:443"
  volumes:
    - ./data/nginx/conf.d:/etc/nginx/conf.d # NGINX reverse proxy configuration files
    - ./data/nginx/nginx-certbot.conf:/etc/nginx/nginx-certbot.conf # .well-known path for certbot
    - ./data/letsencrypt:/etc/letsencrypt:ro # Certificates from certbot
    - ./data/certbot-www:/var/www/certbot:ro # ACME challange files when certbot renews
  ```
