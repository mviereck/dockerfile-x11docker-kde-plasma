# x11docker/kde-plasma
# 
# Run KDE plasma desktop in docker. 
# Use x11docker to run image: 
#   https://github.com/mviereck/x11docker 
#
# Examples: 
#  - Run desktop:
#      x11docker --desktop --gpu --init=systemd -- x11docker/kde-plasma
#  - Run single application:
#      x11docker x11docker/kde-plasma konsole
#  - Run Plasma as Wayland compositor:
#      x11docker --gpu --init=systemd -- --cap-add=SYS_RESOURCE -- x11docker/kde-plasma startplasmacompositor
#
# Options:
#   Persistent home folder stored on host with   --home
#   Shared host file or folder with              --share PATH
#   Hardware acceleration with option            --gpu
#   Clipboard sharing with option                --clipboard
#   ALSA sound support with option               --alsa
#   Pulseaudio sound support with option         --pulseaudio
#   Language locale setting with option          --lang [=$LANG]
#   Printer support over CUPS with option        --printer
#   Webcam support with option                   --webcam
#
# See x11docker --help for further options.

FROM debian:buster

ENV LANG=en_US.UTF-8
RUN apt-get update && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      locales && \
    echo "$LANG UTF-8" >> /etc/locale.gen && \
    locale-gen && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      kwin-x11 \
      plasma-desktop \
      plasma-workspace && \
    apt-get remove -y bluedevil && \
    apt-get autoremove -y

# Dirty fix to avoid kdeinit error ind startkde. Did not find a proper solution.
RUN sed -i 's/.*kdeinit/###&/' /usr/bin/startkde

# Wayland: startplasmacompositor
RUN env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      kwin-wayland-backend-x11 kwin-wayland-backend-wayland && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      plasma-workspace-wayland && \
    sed -i 's/--libinput//' /usr/bin/startplasmacompositor
    
RUN env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      konsole \
      kwrite \
      libcups2 \
      libpulse0 \
      procps \
      psmisc \
      sudo \
      synaptic \
      systemsettings

CMD startkde
