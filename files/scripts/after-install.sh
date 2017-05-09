#!/usr/bin/env bash

getent passwd unbound >/dev/null || \
    useradd -r -d /etc/unbound -s /sbin/nologin \
        -c "Unbound DNS resolver" unbound

# create temp directory (needed before reboot for systemd)
mkdir -m 0755 -vp /var/run/unbound
chown unbound:unbound /var/run/unbound

# create control keys
unbound-control-setup

# create directory for root.key
mkdir -v /var/lib/unbound

# install startup script
if pidof systemd; then
    mv -v /tmp/unbound/scripts/systemd/unbound.service /usr/lib/systemd/system/unbound.service
    echo "D /var/run/unbound 0755 unbound unbound -" > /usr/lib/tmpfiles.d/unbound.conf
    systemctl daemon-reload
else
    mv -v /tmp/unbound/scripts/sysvinit/unbound.sysvinit /etc/init.d/unbound
fi
