FROM debian:12

ENV DEBIAN_FRONTEND noninteractive

# Prevents Postfix's installation from failing
RUN mkdir -p /etc/postfix && echo "myhostname = localhost" > /etc/postfix/main.cf

RUN apt-get update && \
    apt-get install -y --no-install-recommends rsyslog postfix libsasl2-modules postfix-pcre ca-certificates

ADD main.cf /etc/postfix/main.cf
ADD startservices.sh /
ADD rsyslog.conf /etc/rsyslog.conf
ADD sasl_passwd /etc/postfix/sasl_passwd

RUN chmod +x startservices.sh

EXPOSE 25

CMD ["/startservices.sh"]
