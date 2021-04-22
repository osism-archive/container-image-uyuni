FROM opensuse/leap:15.2

ARG VERSION

RUN zypper --non-interactive --quiet ar https://download.opensuse.org/repositories/systemsmanagement:/Uyuni:/Stable/images/repo/Uyuni-Server-POOL-x86_64-Media1/ uyuni-server-stable \
    && zypper --gpg-auto-import-keys refresh \
    && zypper --non-interactive in -y patterns-uyuni_server \
    && zypper --non-interactive in -y systemd systemd-sysvinit \
    && zypper --non-interactive clean

# NOTE: based on https://github.com/univention/ucs-appliance-container

RUN rm -f \
    /etc/{machine-id,localtime,hostname,shadow,locale.conf} \
    /var/lib/dbus/machine-id \
  && rm -rf \
    /var/lib/apt/lists/* /tmp/* /var/tmp/* /run/* /var/run/* \
    /etc/rc*.d/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/multi-user.target.wants/* \
    /lib/systemd/system/systemd-update-utmp* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
  && systemctl mask -- tmp.mount \
  && systemctl mask -- lvm2.service \
  && systemctl mask -- lvm2-activation.service \
  && systemctl mask -- lvm2-monitor.service \
  && systemctl mask -- lvm2-lvmpolld.socket \
  && systemctl mask -- lvm2-lvmpolld.service \
  && systemctl mask -- lvm2-lvmetad.socket \
  && systemctl mask -- lvm2-lvmetad.service \
  && systemctl mask -- dm-event.socket \
  && systemctl mask -- dm-event.service

ENTRYPOINT ["/sbin/init"]

LABEL "org.opencontainers.image.documentation"="https://docs.osism.de" \
      "org.opencontainers.image.licenses"="ASL 2.0" \
      "org.opencontainers.image.source"="https://github.com/osism/container-image-uyuni" \
      "org.opencontainers.image.url"="https://www.osism.de" \
      "org.opencontainers.image.vendor"="Betacloud Solutions GmbH"
