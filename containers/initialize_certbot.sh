#!/bin/bash

podman run -it --rm --name certbot \
            -p 80:80 -p 443:443 \
            -v "./data/letsencrypt/:/etc/letsencrypt" \
            certbot/certbot certonly --standalone \
                 -d gitlab.<Domain> \
                 # Include as many SubDomains as you want to generate Certs for -d gitlab.<Domain> \
                 --non-interactive --agree-tos \
                 --email <Email Address who owns the domain> --expand
