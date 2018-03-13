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
  echo "Extracting Tpruvot 2.2.4"
  mkdir -p ${NVOC_MINERS}/TPccminer/
  cd ${NVOC_MINERS}/TPccminer
  rar x -y -ap=TPccminer TPccminer.rar
  chmod a+x ${NVOC_MINERS}/TPccminer/ccminer
else
  echo "Tpccminer-2.2.4 already downloaded"
fi

echo""

echo "Checking KlausT ccminer 8.20"
if [ ! $( cat ${NVOC_MINERS}/KTccminer/version | grep 8.20) ]
then
  echo "Extracting Klaust ccminer 8.20"
  mkdir -p ${NVOC_MINERS}/KTccminer/
  cd ${NVOC_MINERS}/KTccminer
  rar x -y -ap=KTccminer KTccminer.rar
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
  cd ${NVOC_MINERS}/vertminer
  rar x -y -ap=vertminer-nvidia-1.0-stable.2 vertminer-nvidia-1.0-stable.2.rar
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
  cd ${NVOC_MINERS}/NAccminer
  rar x -y -ap=nanashi-ccminer-2.2-mod-r2 nanashi-ccminer-2.2-mod-r2.rar
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
  cd ${NVOC_MINERS}/KTccminer-cryptonight
  rar x -y -ap=KTccminer-cryptonight KTccminer-cryptonight.rar
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

function compile-ASccminer {
          echo "Compiling ASccminer"
          echo "This could take a while ..."
          git submodule update ${NVOC_MINERS}/ASccminer
          cd ${NVOC_MINERS}/ASccminer/src
          ${NVOC_MINERS}/ASccminer/src/autogen.sh
          ${NVOC_MINERS}/ASccminer/src/configure
          ${NVOC_MINERS}/ASccminer/src/build.sh
          cp ${NVOC_MINERS}/ASccminer/src/ccminer ${NVOC_MINERS}/ASccminer/ccminer
          echo "Finished compiling ASccminer"
}

function compile-KTccminer {
          echo "Compiling KlausT ccminer"
          echo " This could take a while ..."
          git submodule update ${NVOC_MINERS}/KTccminer
          cd ${NVOC_MINERS}/KTccminer/src
          ${NVOC_MINERS}/KTccminer/src/autogen.sh
          ${NVOC_MINERS}/KTccminer/src/configure
          ${NVOC_MINERS}/KTccminer/src/build.sh
          cp ${NVOC_MINERS}/KTccminer/src/ccminer ${NVOC_MINERS}/KTccminer/ccminer
          echo ""
          echo "Finished compiling KlausT ccminer"
}

function compile-KTccminer-cryptonight {
          echo "Compiling KlausT ccminer cryptonight"
          echo " This could take a while ..."
          git submodule update ${NVOC_MINERS}/KTccminer-cryptonight
          cd ${NVOC_MINERS}/KTccminer-cryptonight/src
          ${NVOC_MINERS}/KTccminer-cryptonight/src/autogen.sh
          ${NVOC_MINERS}/KTccminer-cryptonight/src/configure
          ${NVOC_MINERS}/KTccminer-cryptonight/src/build.sh
          cp ${NVOC_MINERS}/KTccminer-cryptonight/src/ccminer ${NVOC_MINERS}/KTccminer-cryptonight/ccminer
          echo ""
          echo "Finished compiling KlausT ccminer cryptonight"
}

function compile-KXccminer {
          echo "Compiling krnlx ccminer"
          echo " This could take a while ..."
          git submodule update ${NVOC_MINERS}/KXccminer
          cd ${NVOC_MINERS}/KXccminer/src
          ${NVOC_MINERS}/KXccminer/src/autogen.sh
          ${NVOC_MINERS}/KXccminer/src/configure
          ${NVOC_MINERS}/KXccminer/src/build.sh
          cp ${NVOC_MINERS}/KXccminer/src/ccminer ${NVOC_MINERS}/KXccminer/ccminer
          echo ""
          echo "Finished compiling Krnlx ccminer"
}

function compile-NAccminer {
          echo "Compiling Nanashi ccminer"
          echo " This could take a while ..."
          git submodule update ${NVOC_MINERS}/NAccminer
          cd ${NVOC_MINERS}/NAccminer/src
          ${NVOC_MINERS}/NAccminer/src/autogen.sh
          ${NVOC_MINERS}/NAccminer/src/configure
          ${NVOC_MINERS}/NAccminer/src/build.sh
          cp ${NVOC_MINERS}/NAccminer/src/ccminer ${NVOC_MINERS}/NAccminer/ccminer
          echo ""
          echo "Finished compiling Nanashi ccminer"
}

function compile-SPccminer {
          echo "Compiling SPccminer"
          echo " This could take a while ..."
          git submodule update ${NVOC_MINERS}/SPccminer
          cd ${NVOC_MINERS}/SPccminer/src
          ${NVOC_MINERS}/SPccminer/src/autogen.sh
          ${NVOC_MINERS}/SPccminer/src/configure
          ${NVOC_MINERS}/SPccminer/src/build.sh
          cp ${NVOC_MINERS}/SPccminer/src/ccminer ${NVOC_MINERS}/SPccminer/ccminer
          echo ""
          echo "Finished compiling tpruvot ccminer"
}

function compile-TPccminer {
          echo "Compiling tpruvot ccminer"
          echo " This could take a while ..."
          git submodule update ${NVOC_MINERS}/TPccminer
          cd ${NVOC_MINERS}/TPccminer/src
          ${NVOC_MINERS}/TPccminer/src/autogen.sh
          ${NVOC_MINERS}/TPccminer/src/configure
          ${NVOC_MINERS}/TPccminer/src/build.sh
          cp ${NVOC_MINERS}/TPccminer/src/ccminer ${NVOC_MINERS}/TPccminer/ccminer
          echo ""
          echo "Finished compiling tpruvot ccminer"
}

function compile-vertminer {
          echo "Compiling Vertminer"
          echo " This could take a while ..."
          git submodule update ${NVOC_MINERS}/vertminer
          cd ${NVOC_MINERS}/vertminer/src
          ${NVOC_MINERS}/vertminer/src/autogen.sh
          ${NVOC_MINERS}/vertminer/src/configure
          ${NVOC_MINERS}/vertminer/src/build.sh
          cp ${NVOC_MINERS}/vertminer/src/vertminer ${NVOC_MINERS}/vertminer/vertminer
          echo ""
          echo "Finished compiling vertminer"
}

function compile-ANXccminer {
          echo "Compiling ANXccminer"
          echo " This could take a while ..."
          git submodule update ${NVOC_MINERS}/ANXccminer
          cd ${NVOC_MINERS}/ANXccminer/src
          ${NVOC_MINERS}/ANXccminer/src/autogen.sh
          ${NVOC_MINERS}/ANXccminer/src/configure
          ${NVOC_MINERS}/ANXccminer/src/build.sh
          cp ${NVOC_MINERS}/ANXccminer/src/ccminer ${NVOC_MINERS}/ANXccminer/ccminer
          echo ""
          echo "Finished compiling ANXccminer"
}

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
  git submodule init
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
          compile-ASccminer
          echo ""
          echo ""
          compile-KTccminer
          echo ""
          echo ""
          compile-KTccminer-cryptonight
          echo ""
          echo ""
          compile-KXccminer
          echo ""
          echo ""
          compile-NAccminer
          echo ""
          echo ""
          compile-SPccminer
          echo ""
          echo ""
          compile-TPccminer
          echo ""
          echo ""
          compile-vertminer
          echo ""
          echo ""
          compile-ANXccminer
          ;;
        [1]* ) echo -e "$choice"
          compile-ASccminer
          ;;
        [2]* ) echo -e "$choice"
          compile-KTccminer
          ;;
        [3]* ) echo -e "$choice\n"
          compile-KTccminer-cryptonight
          ;;
        [4]* ) echo -e "$choice"
          compile-KXccminer
          ;;
        [5]* ) echo -e "$choice"
          compile-NAccminer
          ;;
        [6]* ) echo -e "$choice"
          compile-SPccminer
          ;;
        [7]* ) echo -e "$choice"
          compile-TPccminer
          ;;
        [8]* ) echo -e "$choice"
          compile-vertminer
          ;;
        [9]* ) echo -e "$choice"
          compile-ANXccminer
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
