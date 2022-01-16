#!/bin/bash

# Check for pavlov updates
echo "Updating Pavlov"
/usr/games/steamcmd +force_install_dir /usr/src/pavlovserver +login anonymous  +app_update 622970 -beta shack +exit

# check for sdk updates
echo "Updating SDK64"

/usr/games/steamcmd +force_install_dir /usr/src/sdk64 +login anonymous +app_update 1007 +quit

# check first launch to add template
mkdir -p /usr/src/pavlovserver/Pavlov/Saved
if find -- "/usr/src/pavlovserver/Pavlov/Saved" -prune -type d -empty | grep -q '^'; then
    mv /usr/src/tmp/* /usr/src/pavlovserver/Pavlov/Saved
fi
rm -r /usr/src/tmp

# remove copy created when launching server
rm /home/steam/.steam/sdk64/steamclient.so
rm /usr/src/pavlovserver/Pavlov/Binaries/Linux/steamclient.so

echo "Launch Pavlov Server"
cd "/usr/src/pavlovserver"
sh PavlovServer.sh