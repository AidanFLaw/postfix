#!/bin/bash

interrupt_handler() {
    echo "Interrupt signal received. Cleaning up..."
    sh /etc/init.d/postfix stop
    kill $(pgrep rsyslogd)
    exit 0
}

trap interrupt_handler SIGINT

postmap -r /etc/postfix/sasl_passwd

rsyslogd -n &
sh /etc/init.d/postfix start
tail -f /var/log/mail.log
