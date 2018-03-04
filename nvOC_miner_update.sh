#!/bin/bash

echo "Updating miners for nvOC V0019-2.x"
echo "Stopping miner and watchdog to reduce errors"
pkill -f 5watcdog
pkill -e screen
sleep 1
echo ""
sudo -- sh -c 'sudo apt install rar -y'

echo ""
export NVOC_MINERS=$(pwd)

echo "Checking Equihash DSTM zm_miner 0.6"
if [ ! $(cat ${NVOC_MINERS}/zec/zm/latest/version | grep 0.6) ]
then
  echo "Extracting and making changes for DSTM ZM miner 0.6"
  mkdir -p ${NVOC_MINERS}/zec/zm/latest/
  cat ${NVOC_MINERS}/DSTM/DSTM_0.6.tar.gz | tar -xzC ${NVOC_MINERS}/zec/zm/latest/ --strip 1
  chmod a+x ${NVOC_MINERS}/zec/zm/latest/zm_miner
else
  echo "DSTM zm miner is v0.6"
fi

echo""

echo "Checking Claymore v11.2"
if [ ! $(cat ${NVOC_MINERS}/eth/claymore/latest/version | grep 11.2) ]
then
  echo "Extracting and making changes for Claymore 11.2"
  mkdir -p ${NVOC_MINERS}/eth/claymore/latest/
  cat ${NVOC_MINERS}/claymore/Claymore.tar.gz | tar -xzC ${NVOC_MINERS}/eth/claymore/latest/ --strip 1
  chmod a+x ${NVOC_MINERS}/eth/claymore/latest/ethdcrminer64
else
  echo "Claymore is 11.2"
fi

echo""

echo "Checking Tpruvot ccminer-2.2.4"
if [ ! $(cat ${NVOC_MINERS}/TPccminer/version | grep 2.2.4) ]
then
  # cd ~/Downloads/miners
  echo "Extracting Tpruvot 2.2.4"
  mkdir -p ${NVOC_MINERS}/TPccminer/
  # wget -N https://raw.githubusercontent.com/papampi/nvOC_miners/master/TPccminer/TPccminer.rar
  cd ${NVOC_MINERS}/TPccminer
  rar x -y TPccminer.rar
  # cp -rf ~/Downloads/miners/TPccminer/* ${NVOC_MINERS}/TPccminer/
  chmod a+x ${NVOC_MINERS}/TPccminer/ccminer
  # rm ~/Downloads/miners/TPccminer.rar
  # rm -rf ~/Downloads/miners/TPccminer/
else
  echo "Tpccminer-2.2.4 already downloaded"
fi

echo""

echo "Checking KlausT ccminer 8.20"
if [ ! $( cat ${NVOC_MINERS}/KTccminer/version | grep 8.20) ]
then
  # cd ~/Downloads/miners
  echo "Extracting Klaust ccminer 8.20"
  mkdir -p ${NVOC_MINERS}/KTccminer/
  # wget -N https://raw.githubusercontent.com/papampi/nvOC_miners/master/KTccminer/KTccminer.rar
  cd ${NVOC_MINERS}/KTccminer
  rar x -y KTccminer.rar
  # cp -rf ~/Downloads/miners/KTccminer/* ${NVOC_MINERS}/KTccminer/
  # rm ~/Downloads/miners/KTccminer.rar
  # rm -rf ~/Downloads/miners/KTccminer/
  chmod a+x ${NVOC_MINERS}/KTccminer/ccminer
else
  echo "KlausT ccminer is v8.20"
fi

echo""

echo "Checking Vertminer v1.0-stable.2 Release"
if [ ! $( cat ${NVOC_MINERS}/vertminer/version | grep 1.0.2 ) ]
then
  echo "Extracting vertminer-1.0-stable.2 Release"
  mkdir -p ${NVOC_MINERS}/vertminer/
  # wget -N https://raw.githubusercontent.com/papampi/nvOC_miners/master/vertminer/vertminer-nvidia-1.0-stable.2.rar
  cd ${NVOC_MINERS}/vertminer
  rar x -y vertminer-nvidia-1.0-stable.2.rar
  # cp -rf ~/Downloads/miners/vertminer-nvidia-1.0-stable.2/* ${NVOC_MINERS}/vertminer/
  # rm ~/Downloads/miners/vertminer-nvidia-1.0-stable.2.rar
  # rm -rf ~/Downloads/miners/vertminer-nvidia-1.0-stable.2/
  chmod a+x ${NVOC_MINERS}/vertminer/vertminer
else
  echo "Vertminer is v1.0-stable.2 Release"
fi

echo""

echo "Checking nanashi-ccminer-2.2-mod-r2"
if [ ! $(cat ${NVOC_MINERS}/NAccminer/version | grep 2.2-mod-r2 ) ]
then
  echo "Extracting nanashi ccminer 2.2-mod-r2"
  mkdir -p ${NVOC_MINERS}/NAccminer/
  # wget -N https://raw.githubusercontent.com/papampi/nvOC_miners/master/nanashi-ccminer/nanashi-ccminer-2.2-mod-r2.rar
  cd ${NVOC_MINERS}/NAccminer
  rar x -y  nanashi-ccminer-2.2-mod-r2.rar
  # cp -rf ~/Downloads/miners/nanashi-ccminer-2.2-mod-r2/* ${NVOC_MINERS}/NAccminer/
  # rm ~/Downloads/miners/nanashi-ccminer-2.2-mod-r2.rar
  # rm -rf ~/Downloads/miners/nanashi-ccminer-2.2-mod-r2/
  chmod a+x ${NVOC_MINERS}/NAccminer/ccminer
else
  echo "nanashi-ccminer is already 2.2-mod-r2"
fi

echo""

echo "Checking Ethminer 0.13.0"
if [ ! $(cat ${NVOC_MINERS}/eth/ethminer/latest/version | grep 0.13.0) ]
then
  mkdir -p ${NVOC_MINERS}/eth/ethminer/0.13.0/
  cd ${NVOC_MINERS}/eth/ethminer
  if [[ -L "latest" && -d "latest" ]]
  then
    rm latest
  else
    rm -rf latest
  fi
  ln -s "${NVOC_MINERS}/eth/ethminer/0.13.0" latest
  echo "Extracting and making changes for Ethminer 0.13.0"
  cat ${NVOC_MINERS}/ethminer/ethminer-0.13.0-Linux.tar.gz | tar -xzC ${NVOC_MINERS}/eth/ethminer/latest/ --strip 1
  chmod a+x  ${NVOC_MINERS}/eth/ethminer/latest/ethminer
else
  echo "ethminer is already v0.13.0"
fi

echo""

echo "Checking KTccminer-cryptonight"
if [ ! $( cat ${NVOC_MINERS}/KTccminer-cryptonight/version | grep 2.06) ]
then
  echo "Extracting KTccminer-cryptonight 2.06"
  mkdir -p ${NVOC_MINERS}/KTccminer-cryptonight/
  # wget -N https://raw.githubusercontent.com/papampi/nvOC_miners/master/KTccminer-cryptonight/KTccminer-cryptonight.rar
  cd ${NVOC_MINERS}/KTccminer-cryptonight
  rar x -y  KTccminer-cryptonight.rar
  # cp -rf ~/Downloads/miners/KTccminer-cryptonight/* ${NVOC_MINERS}/KTccminer-cryptonight/
  # rm ~/Downloads/miners/KTccminer-cryptonight.rar
  # rm -rf ~/Downloads/miners/KTccminer-cryptonight/
  chmod a+x ${NVOC_MINERS}/KTccminer-cryptonight/ccminer
else
  echo "KTccminer-cryptonight is already v2.06"
fi

echo""

echo "Checking Equihash Bminer"
if [ ! $(cat ${NVOC_MINERS}/zec/bminer/latest/version | grep 5.4.0) ]
then
  echo "Extracting and making changes for Bminer 5.4.0"
  mkdir -p ${NVOC_MINERS}/zec/bminer/latest/
  cat ${NVOC_MINERS}/Bminer/bminer-v5.4.0.tar.gz | tar -xzC ${NVOC_MINERS}/zec/bminer/latest/ --strip 1
  chmod a+x ${NVOC_MINERS}/zec/bminer/latest/bminer
else
  echo "Bminer is already v5.4.0"
fi

echo""

echo "Checking ANXccminer"
if [[ ! -e ${NVOC_MINERS}/ANXccminer/ccminer ]]
then
  echo "Extracting and making changes for ANXccminer"
  mkdir -p ${NVOC_MINERS}/ANXccminer/
  cat ${NVOC_MINERS}/ANXccminer/ANXccminer.tar.xz | tar -xJC ${NVOC_MINERS}/ANXccminer/ --strip 1
  chmod a+x ${NVOC_MINERS}/ANXccminer/ccminer
else
  echo "ANXccminer is already added"
fi
echo""
echo""
echo "Extracting and checking new miners for nvOC-v0019-2.x finished"
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
  if [ -e  ~/Downloads/openssl-1.0.1e/bn.h.backup ]
  then
    echo "bn.h openssl already fixed for compiling miners"
    echo ""
  else
    cd ~/Downloads
    wget http://www.openssl.org/source/openssl-1.0.1e.tar.gz
    tar -xvzf openssl-1.0.1e.tar.gz
    cp /usr/local/include/openssl/bn.h ~/Downloads/openssl-1.0.1e/bn.h.backup
    sudo cp ~/Downloads/openssl-1.0.1e/crypto/bn/bn.h /usr/local/include/openssl/
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
    echo ""
    read -p "Do your Choice: [A]LL [1] [2] [3] [4] [5] [6] [7] [8] [9] [E]xit: " -a array
    for choice in "${array[@]}"; do
      case "$choice" in
        [Aa]* ) echo "ALL"
          echo "Compiling ASccminer"
          echo "This could take a while ..."
          cd ${NVOC_MINERS}/ASccminer
          ${NVOC_MINERS}/ASccminer/autogen.sh
          ${NVOC_MINERS}/ASccminer/configure
          ${NVOC_MINERS}/ASccminer/build.sh
          echo "Finished compiling ASccminer"
          echo ""
          echo ""
          echo "Compiling KlausT ccminer"
          echo " This could take a while ..."
          cd ${NVOC_MINERS}/KTccminer
          ${NVOC_MINERS}/KTccminer/autogen.sh
          ${NVOC_MINERS}/KTccminer/configure
          ${NVOC_MINERS}/KTccminer/build.sh
          echo ""
          echo "Finished compiling KlausT ccminer"
          echo ""
          echo ""
          echo "Compiling KlausT ccminer cryptonight"
          echo " This could take a while ..."
          cd ${NVOC_MINERS}/KTccminer-cryptonight
          ${NVOC_MINERS}/KTccminer-cryptonight/autogen.sh
          ${NVOC_MINERS}/KTccminer-cryptonight/configure
          ${NVOC_MINERS}/KTccminer-cryptonight/build.sh
          echo ""
          echo "Finished compiling KlausT ccminer cryptonight"
          echo ""
          echo ""
          echo "Compiling krnlx ccminer"
          echo " This could take a while ..."
          cd ${NVOC_MINERS}/KXccminer
          ${NVOC_MINERS}/KXccminer/autogen.sh
          ${NVOC_MINERS}/KXccminer/configure
          ${NVOC_MINERS}/KXccminer/build.sh
          echo ""
          echo "Finished compiling Krnlx ccminer"
          echo ""
          echo ""
          echo "Compiling Nanashi ccminer"
          echo " This could take a while ..."
          cd ${NVOC_MINERS}/NAccminer
          ${NVOC_MINERS}/NAccminer/autogen.sh
          ${NVOC_MINERS}/NAccminer/configure
          ${NVOC_MINERS}/NAccminer/build.sh
          echo ""
          echo "Finished compiling Nanashi ccminer"
          echo ""
          echo ""
          echo "Compiling SPccminer"
          echo " This could take a while ..."
          cd ${NVOC_MINERS}/SPccminer
          ${NVOC_MINERS}/SPccminer/autogen.sh
          ${NVOC_MINERS}/SPccminer/configure
          ${NVOC_MINERS}/SPccminer/build.sh
          echo ""
          echo "Finished compiling tpruvot ccminer"
          echo ""
          echo ""
          echo "Compiling tpruvot ccminer"
          echo " This could take a while ..."
          cd ${NVOC_MINERS}/TPccminer
          ${NVOC_MINERS}/TPccminer/autogen.sh
          ${NVOC_MINERS}/TPccminer/configure
          ${NVOC_MINERS}/TPccminer/build.sh
          echo ""
          echo "Finished compiling tpruvot ccminer"
          echo ""
          echo ""
          echo "Compiling Vertminer"
          echo " This could take a while ..."
          cd ${NVOC_MINERS}/vertminer
          ${NVOC_MINERS}/vertminer/autogen.sh
          ${NVOC_MINERS}/vertminer/configure
          ${NVOC_MINERS}/vertminer/build.sh
          echo ""
          echo "Finished compiling vertminer"
          echo ""
          echo ""
          echo "Compiling ANXccminer"
          echo " This could take a while ..."
          cd ${NVOC_MINERS}/ANXccminer
          ${NVOC_MINERS}/ANXccminer/autogen.sh
          ${NVOC_MINERS}/ANXccminer/configure
          ${NVOC_MINERS}/ANXccminer/build.sh
          echo ""
          echo "Finished compiling ANXccminer"
          ;;
        [1]* ) echo -e "$choice"
          echo "Compiling ASccminer"
          echo "This could take a while ..."
          cd ${NVOC_MINERS}/ASccminer
          ${NVOC_MINERS}/ASccminer/autogen.sh
          ${NVOC_MINERS}/ASccminer/configure
          ${NVOC_MINERS}/ASccminer/build.sh
          echo "Finished compiling ASccminer"
          ;;
        [2]* ) echo -e "$choice"
          echo "Compiling KlausT ccminer"
          echo " This could take a while ..."
          cd ${NVOC_MINERS}/KTccminer
          ${NVOC_MINERS}/KTccminer/autogen.sh
          ${NVOC_MINERS}/KTccminer/configure
          ${NVOC_MINERS}/KTccminer/build.sh
          echo ""
          echo "Finished compiling KlausT ccminer"
          ;;
        [3]* ) echo -e "$choice\n"
          echo "Compiling KlausT ccminer cryptonight"
          echo " This could take a while ..."
          cd ${NVOC_MINERS}/KTccminer-cryptonight
          ${NVOC_MINERS}/KTccminer-cryptonight/autogen.sh
          ${NVOC_MINERS}/KTccminer-cryptonight/configure
          ${NVOC_MINERS}/KTccminer-cryptonight/build.sh
          echo ""
          echo "Finished compiling KlausT ccminer cryptonight"
          ;;
        [4]* ) echo -e "$choice"
          echo "Compiling krnlx ccminer"
          echo " This could take a while ..."
          cd ${NVOC_MINERS}/KXccminer
          ${NVOC_MINERS}/KXccminer/autogen.sh
          ${NVOC_MINERS}/KXccminer/configure
          ${NVOC_MINERS}/KXccminer/build.sh
          echo ""
          echo "Finished compiling Krnlx ccminer"
          ;;
        [5]* ) echo -e "$choice"
          echo "Compiling Nanashi ccminer"
          echo " This could take a while ..."
          cd ${NVOC_MINERS}/NAccminer
          ${NVOC_MINERS}/NAccminer/autogen.sh
          ${NVOC_MINERS}/NAccminer/configure
          ${NVOC_MINERS}/NAccminer/build.sh
          echo ""
          echo "Finished compiling Nanashi ccminer"
          ;;
        [6]* ) echo -e "$choice"
          echo "Compiling SPccminer"
          echo " This could take a while ..."
          cd ${NVOC_MINERS}/SPccminer
          ${NVOC_MINERS}/SPccminer/autogen.sh
          ${NVOC_MINERS}/SPccminer/configure
          ${NVOC_MINERS}/SPccminer/build.sh
          echo ""
          echo "Finished compiling tpruvot ccminer"
          ;;
        [7]* ) echo -e "$choice"
          echo "Compiling tpruvot ccminer"
          echo " This could take a while ..."
          cd ${NVOC_MINERS}/TPccminer
          ${NVOC_MINERS}/TPccminer/autogen.sh
          ${NVOC_MINERS}/TPccminer/configure
          ${NVOC_MINERS}/TPccminer/build.sh
          echo ""
          echo "Finished compiling tpruvot ccminer"
          ;;
        [8]* ) echo -e "$choice"
          echo "Compiling Vertminer"
          echo " This could take a while ..."
          cd ${NVOC_MINERS}/vertminer
          ${NVOC_MINERS}/vertminer/autogen.sh
          ${NVOC_MINERS}/vertminer/configure
          ${NVOC_MINERS}/vertminer/build.sh
          echo ""
          echo "Finished compiling vertminer"
          ;;
        [9]* ) echo -e "$choice"
          echo "Compiling ANXccminer"
          echo " This could take a while ..."
          cd ${NVOC_MINERS}/ANXccminer
          ${NVOC_MINERS}/ANXccminer/autogen.sh
          ${NVOC_MINERS}/ANXccminer/configure
          ${NVOC_MINERS}/ANXccminer/build.sh
          echo ""
          echo "Finished compiling ANXccminer"
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
