#!/bin/bash
if [ ./* == "./*" ]; then
    mv /usr/src/tmp/* /usr/src/pavlovserver/Pavlov/Saved
fi
rm -r /usr/src/tmp

# Check for pavlov updates
echo "Updating Pavlov"
/usr/games/steamcmd +force_install_dir /usr/src/pavlovserver +login anonymous  +app_update 622970 -beta shack_beta +exit

# check for sdk updates
echo "Updating SDK64"
/usr/games/steamcmd +force_install_dir /usr/src/sdk64 +login anonymous +app_update 1007 +quit
cp -rf /usr/src/SteamSDK/linux64/steamclient.so /home/steam/.steam/sdk64/steamclient.so
cp -rf /usr/src/SteamSDK/linux64/steamclient.so /usr/src/pavlovserver/Pavlov/Binaries/Linux/steamclient.so

# Set permissions + change to user
echo "Changing folders permissions"
chown steam:steam -R /usr/src
chown steam:steam -R /home/steam

echo "Log in steam user"
runuser -l steam -c bash<<_

# Launch Server
echo "Launch Pavlov Server"
cd "/usr/src/pavlovserver"
sh PavlovServer.sh
_