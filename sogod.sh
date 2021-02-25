#!/bin/sh

mkdir -p /var/run/sogo
touch /var/run/sogo/sogo.pid
chown -R sogo:sogo /var/run/sogo

# Copy distribution config files to /srv as example
mkdir -p /srv/etc
mkdir -p /etc/sogo
cp /etc/sogo/sogo.conf /srv/etc/sogo.conf.orig

# Copy back administrator's configuration
cp /srv/etc/sogo.conf /etc/sogo/sogo.conf

# Create SOGo home directory if missing
mkdir -p /srv/lib/sogo
chown -R sogo /srv/lib/sogo

# Copy crontab to /srv as example
cp /etc/cron.d/sogo /srv/etc/cron.orig

# Load crontab
cp /srv/etc/cron /etc/cron.d/sogo

# Run SOGo in foreground
exec /sbin/setuser sogo /usr/local/sbin/sogod -WOUseWatchDog $USEWATCHDOG -WONoDetach YES -WOPort 20000 -WOPidFile /var/run/sogo/sogo.pid