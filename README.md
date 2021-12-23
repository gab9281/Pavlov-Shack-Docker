# Pavlov-Shack-Docker
Docker Repo for Pavlov Dedicated Server (Quest)

How to use :
```bash
    docker run --rm -d \
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
* Profit $$$
