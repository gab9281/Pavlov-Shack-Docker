docker run -d --name=pavlov -e TZ=America/New_York -e PUID=1000 -e PGID=1000 -p 7777:7777/tcp -p 7777:7777/udp -p 8177:8177/tcp -p 8177:8177/udp -p 9100:9100 -v D:\Pavlov\Config:/usr/src/pavlovserver/Pavlov/Saved/ pavlovshackdocker:latest