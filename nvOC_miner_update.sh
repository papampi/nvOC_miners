#!/bin/bash
echo "Updating miners for nvOC V0019-2.x"
sleep 1
echo ""
sudo -- sh -c 'sudo apt install rar -y'


echo ""
sleep 1
mkdir -p /home/m1/Downloads/miners
cd /home/m1/Downloads/miners

echo "Checking Equihash DSTM zm_miner 0.5.8"
if [ ! $(cat /home/m1/zec/zm/latest/version | grep 0.5.8) ]
then
  echo "Downloading and making changes for DSTM ZM miner 0.5.8"
  mkdir -p /home/m1/zec/zm/latest
  wget -O- https://raw.githubusercontent.com/papampi/nvOC_miners/master/DSTM/DSTM_0.5.8.tar.gz| tar -xzC /home/m1/zec/zm/latest/ --strip 1
  chmod a+x /home/m1/zec/zm/latest/zm_miner
else
  echo "DSTM zm miner is v0.5.8"
fi

echo""
sleep 1

echo "Checking Claymore 10.6"
if [ ! $(cat /home/m1/eth/claymore/latest/version | grep 10.6) ]
then
  echo "Downloading and making changes for Claymore 10.6"
  mkdir -p /home/m1/eth/claymore/latest/
  wget -O- https://raw.githubusercontent.com/papampi/nvOC_miners/master/claymore/Claymore.tar.gz | tar -xzC /home/m1/eth/claymore/latest/ --strip 1
  chmod a+x /home/m1/eth/claymore/latest/ethdcrminer64
else
  echo "Claymore is v10.6"
fi

echo""
sleep 1

echo "Checking Tpruvot ccminer-2.2.4"
if [ ! $(cat /home/m1/TPccminer/version | grep 2.2.4) ]
then
  cd /home/m1/Downloads/miners
  echo "Downloading Tpruvot 2.2.4"
  mkdir -p /home/m1/TPccminer/
  wget -N https://raw.githubusercontent.com/papampi/nvOC_miners/master/TPccminer/TPccminer.rar
  rar x -y TPccminer.rar
  cp -rf /home/m1/Downloads/miners/TPccminer/* /home/m1/TPccminer/
  chmod a+x /home/m1/TPccminer/ccminer
  rm /home/m1/Downloads/miners/TPccminer.rar
  rm -rf /home/m1/Downloads/miners/TPccminer/
else
  echo "Tpccminer-2.2.4 already downloaded"
fi

echo""
sleep 1

echo "Checking KlausT ccminer 8.20"
if [ ! $( cat /home/m1/KTccminer/version | grep 8.20) ]
then
  cd /home/m1/Downloads/miners
  echo "Downloading Klaust ccminer 8.20"
  mkdir -p /home/m1/KTccminer/
  wget -N https://raw.githubusercontent.com/papampi/nvOC_miners/master/KTccminer/KTccminer.rar
  rar x -y KTccminer.rar
  cp -rf /home/m1/Downloads/miners/KTccminer/* /home/m1/KTccminer/
  rm /home/m1/Downloads/miners/KTccminer.rar
  rm -rf /home/m1/Downloads/miners/KTccminer/
  chmod a+x /home/m1/KTccminer/ccminer
else
  echo "KlausT ccminer is v8.20"
fi

echo""
sleep 1

echo "Checking Vertminer v1.0-stable.2 Release"
if [ ! $( cat /home/m1/vertminer/version | grep 1.0.2 ) ]
then
  echo "Downloading vertminer-1.0-stable.2 Release"
  mkdir -p /home/m1/vertminer/
  wget -N https://raw.githubusercontent.com/papampi/nvOC_miners/master/vertminer/vertminer-nvidia-1.0-stable.2.rar
  rar x -y vertminer-nvidia-1.0-stable.2.rar
  cp -rf /home/m1/Downloads/miners/vertminer-nvidia-1.0-stable.2/* /home/m1/vertminer/
  rm /home/m1/Downloads/miners/vertminer-nvidia-1.0-stable.2.rar
  rm -rf /home/m1/Downloads/miners/vertminer-nvidia-1.0-stable.2/
  chmod a+x /home/m1/vertminer/vertminer
else
  echo "Vertminer is v1.0-stable.2 Release"
fi

echo""
sleep 1

echo "Checking nanashi-ccminer-2.2-mod-r2"
if [ ! $(cat /home/m1/NAccminer/version | grep 2.2-mod-r2 ) ]
then
  echo "Downloading nanashi ccminer 2.2-mod-r2"
  mkdir -p /home/m1/NAccminer
  wget -N https://raw.githubusercontent.com/papampi/nvOC_miners/master/nanashi-ccminer/nanashi-ccminer-2.2-mod-r2.rar
  rar x -y  nanashi-ccminer-2.2-mod-r2.rar
  cp -rf /home/m1/Downloads/miners/nanashi-ccminer-2.2-mod-r2/* /home/m1/NAccminer/
  rm /home/m1/Downloads/miners/nanashi-ccminer-2.2-mod-r2.rar
  rm -rf /home/m1/Downloads/miners/nanashi-ccminer-2.2-mod-r2/
  chmod a+x /home/m1/NAccminer/ccminer
else
  echo "nanashi-ccminer is already 2.2-mod-r2"
fi

echo""
sleep 1

echo "Checking Ethminer 0.13.0"
if [ ! $(cat /home/m1/eth/ethminer/latest/version | grep 0.13.0) ]
then
  mkdir -p /home/m1/eth/ethminer/latest
  echo "Downloading and making changes for Ethminer 0.13.0"
  wget -O- https://raw.githubusercontent.com/papampi/nvOC_miners/master/ethminer/ethminer-0.13.0-Linux.tar.gz | tar -xzC /home/m1/eth/ethminer/latest/ --strip 1
  chmod a+x  /home/m1/eth/ethminer/latest/ethminer
else
  echo "ethminer is already v0.13.0"
fi

echo""
sleep 1

echo "Checking KTccminer-cryptonight"
if [ ! $( cat /home/m1/KTccminer-cryptonight/version | grep 2.06) ]
then
  echo "Downloading KTccminer-cryptonight 2.06"
  mkdir -p /home/m1/KTccminer
  wget -N https://raw.githubusercontent.com/papampi/nvOC_miners/master/KTccminer-cryptonight/KTccminer-cryptonight.rar
  rar x -y  KTccminer-cryptonight.rar
  cp -rf /home/m1/Downloads/miners/KTccminer-cryptonight/* /home/m1/KTccminer-cryptonight/
  rm /home/m1/Downloads/miners/KTccminer-cryptonight.rar
  rm -rf /home/m1/Downloads/miners/KTccminer-cryptonight/
  chmod a+x /home/m1/KTccminer-cryptonight/ccminer
else
  echo "KTccminer-cryptonight is already v2.06"
fi

echo""
sleep 1

echo "Checking Equihash Bminer"
if [ ! $(cat /home/m1/zec/bminer/latest/version | grep 5.3.0) ]
then
  echo "Downloading and making changes for Bminer 5.3.0"
  mkdir -p /home/m1/zec/bminer/latest/
  wget -O- https://raw.githubusercontent.com/papampi/nvOC_miners/master/Bminer/bminer-v5.3.0.tar.gz | tar -xzC /home/m1/zec/bminer/latest/ --strip 1
  chmod a+x /home/m1/zec/bminer/latest/bminer
else
  echo "Bminer is already v5.3.0"
fi

echo "Checking ANXccminer"
  if [[ ! -d /home/m1/ANXccminer/ ]]
then
  echo "Downloading and making changes for ANXccminer"
  mkdir -p /home/m1/ANXccminer/
  wget -O- https://nvoc-mining-os.com/download/1177/ | tar -xzC /home/m1/ANXccminer/ --strip 1
  chmod a+x /home/m1/ANXccminer/ccminer
else
  echo "ANXccminer is already added"
fi


echo""
sleep 1

echo "Downloading and checking new miners for nvOC-v0019-2.x finished"
