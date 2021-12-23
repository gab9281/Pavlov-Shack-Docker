FROM ubuntu:latest

WORKDIR /usr/src

ARG BUILD_DATE
ARG VERSION

LABEL build_version="version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="gab9281"

# PreInit TZ to bypass configuration
ENV TZ="Etc/UTC"

# Download steamcmd and Pavlov dependencies
RUN dpkg --add-architecture i386 &&\
    apt update &&\
    echo steam steam/question select "I AGREE" | debconf-set-selections &&\
    apt full-upgrade -y &&\
    apt install -y lib32gcc1 gdb curl lib32gcc1 libc++-dev unzip libsdl2-2.0-0:i386 wget steamcmd

# Clear Apt
RUN apt clean autoclean &&\
    apt autoremove -y &&\
    rm -rf /var/lib/{apt,dpkg,cache,log}

# Install Pavlov
RUN /usr/games/steamcmd +force_install_dir /usr/src/pavlovserver +login anonymous +app_update 622970 -beta shack +exit

# Install Steam SDK
RUN /usr/games/steamcmd +force_install_dir /usr/src/SteamSDK +login anonymous +app_update 1007 +quit &&\
    mkdir -p /home/steam/.steam/sdk64/ &&\
    cp -rf /usr/src/SteamSDK/linux64/steamclient.so /home/steam/.steam/sdk64/steamclient.so &&\
    cp -rf /usr/src/SteamSDK/linux64/steamclient.so /usr/src/pavlovserver/Pavlov/Binaries/Linux/steamclient.so

# Adds defaults configurations
RUN mkdir -p /usr/src/pavlovserver/Pavlov/Saved &&\
    mkdir -p "/home/steam/.config/Epic/Epic Games" &&\
    touch "/home/steam/.config/Epic/Epic Games/KeyValueStore.ini"

COPY ./Saved /usr/src/tmp

# Adds launch script
COPY ./launch.sh /usr/src/pavlovserver/launch.sh

# Starts the server
EXPOSE 7777/udp 
EXPOSE 7777/tcp 
EXPOSE 8177/udp 
EXPOSE 8177/tcp 
EXPOSE 9100/tcp
VOLUME /usr/src/pavlovserver/Pavlov/Saved/

# Let server to run as normal user
RUN groupadd -g 999 steam && \
    useradd -r -u 999 -g steam steam &&\
    chown steam:steam -R /usr/src &&\
    chown steam:steam -R /home/steam

ENTRYPOINT ["/usr/src/pavlovserver/launch.sh", "", "FOREGROUND"]
