FROM ghcr.io/containerpak/gtk3:main

ARG DEBIAN_FRONTEND=noninteractive

LABEL org.opencontainers.image.source="https://github.com/Containerpak/claude-desktop"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    dbus-user-session gnome-keyring libasound2t64 \
    libatspi2.0-0 libayatana-appindicator3-1 libdrm2 libgbm1 \
    libgtk-3-0t64 libnotify4 libnss3 libsecret-1-0 libuuid1 libxcb-dri3-0 \
    libxtst6 ovmf qemu-system-x86 qemu-utils trash-cli virtiofsd \
    xdg-desktop-portal xdg-desktop-portal-gtk xdg-utils && \
    cpak-clean-junk

COPY claude-desktop /usr/local/bin/claude-desktop-cpak
COPY com.anthropic.Claude.cpak.desktop /usr/share/applications/com.anthropic.Claude.cpak.desktop
