#!/bin/bash
echo "Updating miners for nvOC V0019-2.x"
echo "Stopping miner and watchdog to reduce errors"
pkill -f 5watcdog
pkill -e screen
sleep 1
echo ""
sudo -- sh -c 'sudo apt install rar -y'

echo ""
mkdir -p /home/m1/Downloads/miners
cd /home/m1/Downloads/miners

echo "Checking Equihash DSTM zm_miner 0.6"
if [ ! $(cat /home/m1/zec/zm/latest/version | grep 0.6) ]
then
  echo "Downloading and making changes for DSTM ZM miner 0.6"
  mkdir -p /home/m1/zec/zm/latest
  wget -O- https://raw.githubusercontent.com/papampi/nvOC_miners/master/DSTM/DSTM_0.6.tar.gz | tar -xzC /home/m1/zec/zm/latest/ --strip 1
  chmod a+x /home/m1/zec/zm/latest/zm_miner
else
  echo "DSTM zm miner is v0.6"
fi

echo""

echo "Checking Claymore v11.7"
if [ ! $(cat /home/m1/eth/claymore/latest/version | grep 11.7) ]
then
  echo "Downloading and making changes for Claymore 11.7"
  mkdir -p /home/m1/eth/claymore/latest/
  wget -O- https://raw.githubusercontent.com/papampi/nvOC_miners/master/claymore/Claymore-v11.7.tar.gz | tar -xzC /home/m1/eth/claymore/latest/ --strip 1
  chmod a+x /home/m1/eth/claymore/latest/ethdcrminer64
else
  echo "Claymore is 11.7"
fi

echo""

echo "Checking z-enemy 1.09a"
if [ ! $(cat /home/m1/z-enemy/version | grep 1.09a) ]
then
  echo "Downloading and making changes for z-enemy 1.09a"
  mkdir -p /home/m1/z-enemy/
  wget -O- https://raw.githubusercontent.com/papampi/nvOC_miners/master/z-enemy/z-enemy-1.09a-cuda80.tar.gz | tar -xzC /home/m1/z-enemy/ --strip 1
  chmod a+x /home/m1/z-enemy/z-enemy_miner
else
  echo "z-enemy is 1.09a"
fi

echo""
echo "Checking Tpruvot ccminer-2.2.5"
if [ ! $(cat /home/m1/TPccminer/version | grep 2.2.5) ]
then
  cd /home/m1/Downloads/miners
  echo "Downloading Tpruvot 2.2.5"
  mkdir -p /home/m1/TPccminer/
  wget -N https://raw.githubusercontent.com/papampi/nvOC_miners/master/TPccminer/TPccminer.rar
  rar x -y TPccminer.rar
  cp -rf /home/m1/Downloads/miners/TPccminer/* /home/m1/TPccminer/
  chmod a+x /home/m1/TPccminer/ccminer
  rm /home/m1/Downloads/miners/TPccminer.rar
  rm -rf /home/m1/Downloads/miners/TPccminer/
else
  echo "Tpccminer-2.2.5 already downloaded"
fi

echo""

echo "Checking MSFT Tpruvot ccminer-2.2.5 (RVN)"
if [ ! $(cat /home/m1/MSFTccminer/version | grep 2.2.5) ]
then
  cd /home/m1/Downloads/miners
  echo "Downloading MSFT Tpruvot 2.2.5"
  mkdir -p /home/m1/MSFTccminer/
  git clone https://github.com/MSFTserver/ccminer.git MSFTccminer
  cd /home/m1/Downloads/miners/MSFTccminer
  wget -N https://raw.githubusercontent.com/papampi/nvOC_miners/master/MSFTccminer/MSFTccminer.rar
  rar x -y MSFTccminer.rar
  cd /home/m1/Downloads/miners
  cp -rf /home/m1/Downloads/miners/MSFTccminer/* /home/m1/MSFTccminer/
  chmod a+x /home/m1/MSFTccminer/ccminer
  rm -rf /home/m1/Downloads/miners/MSFTccminer/
else
  echo "MSFTccminer-2.2.5 already downloaded"
fi

echo""

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

echo "Checking Ethminer 0.14.0"
if [ ! $(cat /home/m1/eth/ethminer/latest/version | grep 0.14.0) ]
then
  mkdir -p /home/m1/eth/ethminer/latest
  echo "Downloading and making changes for Ethminer 0.14.0"
  wget -O- https://raw.githubusercontent.com/papampi/nvOC_miners/master/ethminer/ethminer-0.14.0-Linux.tar.gz | tar -xzC /home/m1/eth/ethminer/latest/ --strip 1
  chmod a+x  /home/m1/eth/ethminer/latest/ethminer
else
  echo "ethminer is already v0.14.0"
fi

echo""

echo "Checking KTccminer-cryptonight"
if [ ! $( cat /home/m1/KTccminer-cryptonight/version | grep 2.06) ]
then
  echo "Downloading KTccminer-cryptonight 2.06"
  mkdir -p /home/m1/KTccminer-cryptonight
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

echo "Checking Equihash Bminer"
if [ ! $(cat /home/m1/zec/bminer/latest/version | grep 6.1) ]
then
  echo "Downloading and making changes for Bminer 6.1"
  mkdir -p /home/m1/zec/bminer/latest/
  wget -O- https://raw.githubusercontent.com/papampi/nvOC_miners/master/Bminer/bminer-v6.1.0.tar.gz | tar -xzC /home/m1/zec/bminer/latest/ --strip 1
  chmod a+x /home/m1/zec/bminer/latest/bminer
else
  echo "Bminer is already v6.1"
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
echo""
echo "Downloading and checking new miners for nvOC-v0019-2.x finished"
echo""
echo""
sleep 2

echo -n "Do you want to re-compile your miners (y/N)?  "
sleep 1
read -n 1 ANSWER
if [ ! "${ANSWER}" = "y" ] ; then
  echo ""
  echo "Canceled.."
  echo "Re starting miner..."
  pkill -f 3main
  sleep 1
  exit 0
else
  echo ""
  echo ""
  echo "Checking if bn.h bignum error is fixed for compiling miners or not"
  if [ -e  /home/m1/Downloads/openssl-1.0.1e/bn.h.backup ]
  then
    echo "bn.h openssl already fixed for compiling miners"
    echo ""
  else
    cd /home/m1/Downloads
    wget http://www.openssl.org/source/openssl-1.0.1e.tar.gz
    tar -xvzf openssl-1.0.1e.tar.gz
    cp /usr/local/include/openssl/bn.h /home/m1/Downloads/openssl-1.0.1e/bn.h.backup
    sudo cp /home/m1/Downloads/openssl-1.0.1e/crypto/bn/bn.h /usr/local/include/openssl/
    sleep 1
    echo ""
    echo "bn.h openssl fixed for compiling miners"
    echo ""
  fi

  while true; do
    IFS=', '
    echo "Select miners to compile (multiple comma separated values: 1,6,7)"
    echo "1- ASccminer"
    echo "2 -KTccminer"
    echo "3 -KTccminer-cryptonight"
    echo "4- KXccminer"
    echo "5 -NAccminer"
    echo "6- SPccminer"
    echo "7- TPccminer"
    echo "8- vertminer"
    echo "9- ANXccminer"
    echo "R- MSFTccminer (RVN)"
    echo ""
    read -p "Do your Choice: [A]LL [1] [2] [3] [4] [5] [6] [7] [8] [9] [R] [E]xit: " -a array
    for choice in "${array[@]}"; do
      case "$choice" in
        [Aa]* ) echo "ALL"
          echo "Compiling ASccminer"
          echo "This could take a while ..."
          cd /home/m1/ASccminer
          /home/m1/ASccminer/autogen.sh
          /home/m1/ASccminer/configure
          /home/m1/ASccminer/build.sh
          echo "Finished compiling ASccminer"
          echo ""
          echo ""
          echo "Compiling KlausT ccminer"
          echo " This could take a while ..."
          cd /home/m1/KTccminer
          /home/m1/KTccminer/autogen.sh
          /home/m1/KTccminer/configure
          /home/m1/KTccminer/build.sh
          echo ""
          echo "Finished compiling KlausT ccminer"
          echo ""
          echo ""
          echo "Compiling KlausT ccminer cryptonight"
          echo " This could take a while ..."
          cd /home/m1/KTccminer-cryptonight
          /home/m1/KTccminer-cryptonight/autogen.sh
          /home/m1/KTccminer-cryptonight/configure
          /home/m1/KTccminer-cryptonight/build.sh
          echo ""
          echo "Finished compiling KlausT ccminer cryptonight"
          echo ""
          echo ""
          echo "Compiling krnlx ccminer"
          echo " This could take a while ..."
          cd /home/m1/KXccminer
          /home/m1/KXccminer/autogen.sh
          /home/m1/KXccminer/configure
          /home/m1/KXccminer/build.sh
          echo ""
          echo "Finished compiling Krnlx ccminer"
          echo ""
          echo ""
          echo "Compiling Nanashi ccminer"
          echo " This could take a while ..."
          cd /home/m1/NAccminer
          /home/m1/NAccminer/autogen.sh
          /home/m1/NAccminer/configure
          /home/m1/NAccminer/build.sh
          echo ""
          echo "Finished compiling Nanashi ccminer"
          echo ""
          echo ""
          echo "Compiling SPccminer"
          echo " This could take a while ..."
          cd /home/m1/SPccminer
          /home/m1/SPccminer/autogen.sh
          /home/m1/SPccminer/configure
          /home/m1/SPccminer/build.sh
          echo ""
          echo "Finished compiling tpruvot ccminer"
          echo ""
          echo ""
          echo "Compiling tpruvot ccminer"
          echo " This could take a while ..."
          cd /home/m1/TPccminer
          /home/m1/TPccminer/autogen.sh
          /home/m1/TPccminer/configure
          /home/m1/TPccminer/build.sh
          echo ""
          echo "Finished compiling tpruvot ccminer"
          echo ""
          echo ""
          echo "Compiling MSFTccminer"
          echo " This could take a while ..."
          cd /home/m1/MSFTccminer
          /home/m1/MSFTccminer/autogen.sh
          /home/m1/MSFTccminer/configure
          /home/m1/MSFTccminer/build.sh
          echo ""
          echo "Finished compiling MSFTccminer"
          echo ""
          echo ""
          echo "Compiling Vertminer"
          echo " This could take a while ..."
          cd /home/m1/vertminer
          /home/m1/vertminer/autogen.sh
          /home/m1/vertminer/configure
          /home/m1/vertminer/build.sh
          echo ""
          echo "Finished compiling vertminer"
          echo ""
          echo ""
          echo "Compiling ANXccminer"
          echo " This could take a while ..."
          cd /home/m1/ANXccminer
          /home/m1/ANXccminer/autogen.sh
          /home/m1/ANXccminer/configure
          /home/m1/ANXccminer/build.sh
          echo ""
          echo "Finished compiling ANXccminer"
          ;;
        [1]* ) echo -e "$choice"
          echo "Compiling ASccminer"
          echo "This could take a while ..."
          cd /home/m1/ASccminer
          /home/m1/ASccminer/autogen.sh
          /home/m1/ASccminer/configure
          /home/m1/ASccminer/build.sh
          echo "Finished compiling ASccminer"
          ;;
        [2]* ) echo -e "$choice"
          echo "Compiling KlausT ccminer"
          echo " This could take a while ..."
          cd /home/m1/KTccminer
          /home/m1/KTccminer/autogen.sh
          /home/m1/KTccminer/configure
          /home/m1/KTccminer/build.sh
          echo ""
          echo "Finished compiling KlausT ccminer"
          ;;
        [3]* ) echo -e "$choice\n"
          echo "Compiling KlausT ccminer cryptonight"
          echo " This could take a while ..."
          cd /home/m1/KTccminer-cryptonight
          /home/m1/KTccminer-cryptonight/autogen.sh
          /home/m1/KTccminer-cryptonight/configure
          /home/m1/KTccminer-cryptonight/build.sh
          echo ""
          echo "Finished compiling KlausT ccminer cryptonight"
          ;;
        [4]* ) echo -e "$choice"
          echo "Compiling krnlx ccminer"
          echo " This could take a while ..."
          cd /home/m1/KXccminer
          /home/m1/KXccminer/autogen.sh
          /home/m1/KXccminer/configure
          /home/m1/KXccminer/build.sh
          echo ""
          echo "Finished compiling Krnlx ccminer"
          ;;
        [5]* ) echo -e "$choice"
          echo "Compiling Nanashi ccminer"
          echo " This could take a while ..."
          cd /home/m1/NAccminer
          /home/m1/NAccminer/autogen.sh
          /home/m1/NAccminer/configure
          /home/m1/NAccminer/build.sh
          echo ""
          echo "Finished compiling Nanashi ccminer"
          ;;
        [6]* ) echo -e "$choice"
          echo "Compiling SPccminer"
          echo " This could take a while ..."
          cd /home/m1/SPccminer
          /home/m1/SPccminer/autogen.sh
          /home/m1/SPccminer/configure
          /home/m1/SPccminer/build.sh
          echo ""
          echo "Finished compiling tpruvot ccminer"
          ;;
        [7]* ) echo -e "$choice"
          echo "Compiling tpruvot ccminer"
          echo " This could take a while ..."
          cd /home/m1/TPccminer
          /home/m1/TPccminer/autogen.sh
          /home/m1/TPccminer/configure
          /home/m1/TPccminer/build.sh
          echo ""
          echo "Finished compiling tpruvot ccminer"
          ;;
        [8]* ) echo -e "$choice"
          echo "Compiling Vertminer"
          echo " This could take a while ..."
          cd /home/m1/vertminer
          /home/m1/vertminer/autogen.sh
          /home/m1/vertminer/configure
          /home/m1/vertminer/build.sh
          echo ""
          echo "Finished compiling vertminer"
          ;;
        [9]* ) echo -e "$choice"
          echo "Compiling ANXccminer"
          echo " This could take a while ..."
          cd /home/m1/ANXccminer
          /home/m1/ANXccminer/autogen.sh
          /home/m1/ANXccminer/configure
          /home/m1/ANXccminer/build.sh
          echo ""
          echo "Finished compiling ANXccminer"
          ;;
        [R]* ) echo -e "$choice"
          echo "Compiling MSFTccminer"
          echo " This could take a while ..."
          cd /home/m1/MSFTccminer
          /home/m1/MSFTccminer/autogen.sh
          /home/m1/MSFTccminer/configure
          /home/m1/MSFTccminer/build.sh
          echo ""
          echo "Finished compiling MSFTccminer"
          ;;

        [Ee]* ) echo "exited by user"; exit;;
        * ) echo "Are you kidding me???";;
      esac
    done
    echo "Compilation finished, Want to compile more?"
    echo ""
  done
  echo " Restarting miner"
  pkill -f 3main
fi
