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
