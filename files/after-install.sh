#!/usr/bin/env bash

getent passwd unbound >/dev/null || \
    useradd -r -g unbound -d /etc/unbound -s /sbin/nologin \
    -c "Unbound DNS resolver" unbound

if pidof systemd; then
    mv -v /tmp/unbound/systemd/unbound.service /usr/lib/systemd/system/unbound.service
    echo "D /var/run/unbound 0755 unbound unbound -" > /usr/lib/tmpfiles.d/unbound.conf
    systemctl daemon-reload
else
    mv -v /tmp/unbound/sysvinit/unbound.sysvinit /etc/init.d/unbound
fi
