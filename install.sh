#! /bin/sh

currentDir=`pwd`
sudo apt install openjdk-8-jre-headless

# add minecraft user
sudo useradd -r -m -U -d /opt/minecraft -s /bin/bash minecraft

# change the current user to minecraft
sudo su - minecraft

# tools  -> mcrcon server
# server -> Minecraft server
mkdir -p ~/{tools,server}

# compile mcrcon
cd ~/tools && git clone https://github.com/Tiiffi/mcrcon.git
cd ~/tools/mcrcon
gcc -std=gnu11 -pedantic -Wall -Wextra -O2 -s -o mcrcon mcrcon.c
./mcrcon -h

cp $currentDir/server.* eula.txt ~/server

# add minecraft service
sudo cp $currentDir/minecraft.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start minecraft

# auto boot
sudo systemctl enable minecraft
