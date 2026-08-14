FROM ubuntu:26.04 AS source

ADD --checksum=sha256:2bc6f0d4109bb43b307696e1128df53fbf393ef98f947a7869948642450245d7 https://downloads.claude.ai/claude-desktop/apt/stable/pool/main/c/claude-desktop/claude-desktop_1.26832.0_amd64.deb /tmp/source

RUN dpkg-deb -x /tmp/source /out

FROM ghcr.io/containerpak/gtk3:main

ARG DEBIAN_FRONTEND=noninteractive

COPY --from=source /out /

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    dbus-user-session gnome-keyring libasound2t64 \
    libatspi2.0-0 libayatana-appindicator3-1 libgtk-3-0 libnotify4 \
    libnss3 libsecret-1-0 libuuid1 libxtst6 ovmf qemu-system-x86 \
    qemu-utils trash-cli virtiofsd xdg-utils && \
    rm -f /usr/bin/claude-desktop && \
    cpak-clean-junk

COPY claude-desktop /usr/bin/claude-desktop
