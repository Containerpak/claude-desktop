FROM ghcr.io/containerpak/mesa:main

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates curl dbus-user-session gnome-keyring libasound2t64 \
    libatspi2.0-0 libayatana-appindicator3-1 libgtk-3-0 libnotify4 \
    libnss3 libsecret-1-0 libuuid1 libxtst6 ovmf qemu-system-x86 \
    qemu-utils trash-cli virtiofsd xdg-utils && \
    curl -fsSL https://downloads.claude.ai/claude-desktop/apt/stable/pool/main/c/claude-desktop/claude-desktop_1.26832.0_amd64.deb \
      -o /tmp/claude-desktop.deb && \
    echo '2bc6f0d4109bb43b307696e1128df53fbf393ef98f947a7869948642450245d7  /tmp/claude-desktop.deb' | sha256sum -c - && \
    dpkg-deb -x /tmp/claude-desktop.deb / && \
    rm /usr/bin/claude-desktop && \
    cpak-clean-junk

COPY claude-desktop /usr/bin/claude-desktop
