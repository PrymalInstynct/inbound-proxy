# Installation Instructions for the Inbound Proxy Server

## OS Installation

### Installation Destination
- /
- /boot
- /boot/efi (If using a UEFI BIOS Bootloader)
- /home
- /tmp
- /var
- /var/log
- /var/log/audit
- /var/tmp

### Software Selection
- Minimal Install
  - Container Management
  - Headless Management

### Kdump
- Disabled

### Network & Hostname
- Disable IPv6

## Software Installation
- Elevate to Root
- `sudo -i`
- Patch the Host
- `dnf -y upgrade --refresh`
- Intsall Ansible and VIM
- `dnf -y install ansible-core vim`
- Install Python Dependencies
- `pip3.9 install --user podman-compose jmespath`
- Fix Root's Path
- `vim ~/.bash_profile`
    ```bash
      # .bash_profile

      # Get the aliases and functions
      if [ -f ~/.bashrc ]; then
              . ~/.bashrc
      fi

      # User specific environment and startup programs

      PATH=$PATH:$HOME/bin:/usr/local/bin

      export PATH
    ```
- Close Root session
- `exit`
- Copy the Inbound Proxy Project to a users home directory
- `scp -r inbound-proxy user@alma.local:/home/user`
- `sudo mv /home/user/inbound-proxy /opt/`
- Elevate to Root
- `sudo -i`
- Validate project permissions
- `find /opt/inbound-proxy -type d | xargs -I {} chmod 750 '{}'`
- `find /opt/inbound-proxy -type f | xargs -I {} chmod 640 '{}'`
- `find /opt/inbound-proxy -type f | grep -P "\.sh$" | xargs -I {} chmod 750 '{}'`
- Symlink Ansible Roles to /etc/ansible/roles/ directory
- `ln -s /opt/inbound-proxy/ansible/aide /etc/ansible/roles`
- `ln -s /opt/inbound-proxy/ansible/rhel8-stig /etc/ansible/roles`
- `ln -s /opt/inbound-proxy/ansible/usbguard /etc/ansible/roles`
- `cd /opt/inbound-proxy`
- Install Ansible Dependencies
- `ansible-galaxy install -r ansible/rhel8-stig/requirements.yml`
- Update the passwords in the STIG Vault file
- `vim ansible/rhel8-stig/vars/vault.yml`
- Encrypt the STIG Vault
- `ansible-vault encrypt ansible/rhel8-stig/vars/vault.yml`
- Apply RHEL8 STIG
- `ansible-playbook -i ansible/rhel8-stig/inventory.yml ansible/rhel8-stig/configure-rhel8-stig.yml --ask-vault`
- Reboot the Host
- Configure Host firewall
- `firewall-cmd --add-service={http,https} --permanent`
- `firewall-cmd --complete-reload`
- Initialize the Let's Encrypt Certificates
- `cd /opt/inbound-proxy/containers`
- `chmod +x initialize_certbot.sh`
- Start the Containers
- `podman-compose up -d`
- Validate the containers are running
- `podman ps -a`
- Stop the Containers
- `podman-compose down`
- Set Containers to start at boot time
- `vim /etc/systemd/system/nginx-container.service`
  ```
  [Unit]
  Description=NGINX Podman Container Service
  StartLimitIntervalSec=60

  [Service]
  WorkingDirectory=/opt/inbound-proxy/containers
  ExecStart=/usr/local/bin/podman-compose up -d
  ExecStop=/usr/local/bin/podman-compose down
  TimeoutStartSec=0
  Restart=on-failure
  StartLimitBurst=3

  [Install]
  WantedBy=multi-user.target
  ```
- `systemctl daemon-reload`
- `systemctl enable --now nginx-container.service`
