# Pavlov-Shack-Docker
Docker Repo for Pavlov Dedicated Server (Quest)

How to use :
```bash
docker run -d \
  --name=pavlov-dedicated-quest \
  -e TZ=America/New_York \
  -e PUID=1000 \
  -e PGID=1000 \
  -p 7777:7777/tcp \
  -p 7777:7777/udp \
  -p 8177:8177/tcp \
  -p 8177:8177/udp \
  -p 9100:9100 \
  -v ${YourConfigFolder}:/usr/src/pavlovserver/Pavlov/Saved/ \
ghcr.io/gab9281/pavlov-shack-docker:main
```

* Start once to populate your configs
* Stop the container
* Set your configs
* Restart your container
* Port forward all ports
* Profit $$$

This docker image is created to be started/restarted.
It will automatically check for new version of pavlov on startup.
All steps were taken from the [wiki](http://wiki.pavlov-vr.com/index.php?title=Dedicated_server#Hosting_at_home).
