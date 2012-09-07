#!/bin/bash

echo "Making ifield workspace"
mkdir ifieldworkspace
cd ifieldworkspace

echo -en '\E[47;34m'"\033[1mE"
echo  "Downloading the Mongo Database files, this is where users are stored."
wget  http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.0.7.tgz 
tar -zxvf mongodb-linux-x86_64-2.0.7.tgz
cd mongodb-linux-x86_64-2.0.7/bin
echo "Creating folders to hold a Mongo database"
mkdir $HOME/ifieldworkspace/data
mkdir $HOME/ifieldworkspace/data/db
echo "Attempting to turn on mongodb on port 8136"
./mongod --dbpath $HOME/ifieldworkspace/data/db --port 8136 &


echo -en '\E[47;35m'"\033[1mJ"   # Magenta
echo "Downloading Node, a javascript server which is what iField uses to run"
cd $HOME/ifieldworkspace
wget http://nodejs.org/dist/v0.6.19/node-v0.6.19.tar.gz
tar -zxvf node-v0.6.19.tar.gz
cd node-v0.6.19
echo "Next three lines give command to compile Node"
./configure --prefix=$HOME/ifieldworkspace/node
make
make install
echo "Next line puts the Node binary directory to path and append it to profile so that it is permanently available for the user"
echo "export PATH=$HOME/ifieldworkspace/node/bin:$PATH" >> ~/.profile 
source ~/.profile

echo -en '\E[47;32m'"\033[1mS"   # Green
echo "Downloading the iField Authentication server from GitHub"
cd $HOME/ifieldworkspace
wget http://ilanguagelab.googlecode.com/files/OpenSourceFieldlinguistics-iField-v1.16.2.tar.gz
tar -zxvf OpenSourceFieldlinguistics-iField-v1.16.2.tar.gz
mv OpenSourceFieldlinguistics-iField-f335d25/ iField
cd iField
echo "Installing the iField dependancies using the Node Package Manager (NPM)...."
echo -e "\033[0m"
npm install
echo "Attempting to run iField, it should say 'Listening on 3001'"
node  app.js &

