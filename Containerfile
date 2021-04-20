FROM opensuse/leap:15.2

ARG VERSION

RUN zypper --non-interactive --quiet ar https://download.opensuse.org/repositories/systemsmanagement:/Uyuni:/Stable/images/repo/Uyuni-Server-POOL-x86_64-Media1/ uyuni-server-stable \
    && zypper --gpg-auto-import-keys refresh \
    && zypper --non-interactive in -y patterns-uyuni_server \
    && zypper --non-interactive clean

LABEL "org.opencontainers.image.documentation"="https://docs.osism.de" \
      "org.opencontainers.image.licenses"="ASL 2.0" \
      "org.opencontainers.image.source"="https://github.com/osism/container-image-uyuni" \
      "org.opencontainers.image.url"="https://www.osism.de" \
      "org.opencontainers.image.vendor"="Betacloud Solutions GmbH"
