#!/bin/bash

echo "Updating miners for nvOC V0019-2.1"
echo "Will check and restart miner if needed"

echo
export NVOC_MINERS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CUDA_VER="8"
if  nvcc --version | grep -v grep | grep -q "9.2"
then
  CUDA_VER="9.2"
fi

## Miner versions and tarballs

ANXccminer_ver_8="1.0"
ANXccminer_tarball_ver_8="ANXccminer.tar.xz"
ANXccminer_ver_8_src="cd6fab68823e247bb84dd1fa0448d5f75ec4917d"

ASccminer_ver_8="1.0"
ASccminer_tarball_ver_8="ASccminer.tar.xz"
ASccminer_ver_8_src="aafe2d19b6d9eb07d942d70ced3049e9aed1c241"

bminer_ver="9.1.0"
bminer_tarball="bminer-v9.1.0.tar.xz"

claymore_ver="11.9"
claymore_tarball="Claymore-v11.9.tar.xz"

dstm_ver="0.6.1"
dstm_tarball="DSTM_0.6.1.tar.xz"

ethminer_ver_8="0.14.0"
ethminer_tarball_ver_8="ethminer-0.14.0-Linux.tar.xz"
ethminer_ver_8_src="24c65cf166bbb3332d60e2baef859ceb604e5d49"

ethminer_ver_9="0.15.0"
ethminer_tarball_ver_9="ethminer-0.15.0-Linux.tar.xz"
ethminer_src_ver_9="11d7e3c4c087f6c669013e360af84f6d617c02f4"

ewbf_ver="3.4"
ewbf_tarball="0.3.4b.tar.xz"

z_ewbf_ver="0.5"
z_ewbf_tarball="z_ewbf_v0.5.tar.xz"

KTccminer_ver_8="8.20"
KTccminer_tarball_ver_8="KTccminer.tar.xz"
KTccminer_ver_8_src="c5ab73837c8024f1e6b8fe7ad46e6881fb8366e6"

KTccminer_ver_9="8.22"
KTccminer_tarball_ver_9="KTccminer-8.22.tar.xz"
KTccminer_src_ver_9="2e457923f3125fbaedf5d8ba1f7d0fafc85b0ba8"

KTccminer_cryptonight_ver_8="2.06"
KTccminer_cryptonight_tarball_ver_8="KTccminer-cryptonight.tar.xz"
KTccminer_cryptonight_ver_8_src="bedaf007d4619fc4157aeafb59b44850f08d93f1"

KTccminer_cryptonight_ver_9="3.05"
KTccminer_cryptonight_tarball_ver_9="KTccminer-cryptonight-3.05.tar.xz"
KTccminer_cryptonight_src_ver_9="7061f3c78e52a03f7ff5d0743900312de5bb24fc"

KXccminer_ver_8="0.1"
KXccminer_tarball_ver_8="KXccminer.tar.xz"
KXccminer_ver_8_src="7d41d49b92db27b9ab80270adaa92f6b06d1ef78"

MSFTccminer_ver_8="2.2.5"
MSFTccminer_tarball_ver_8="MSFTccminer.tar.xz"
MSFTccminer_ver_8_src="78dad7dd659eae72a07d2448de62b1946c1f2b41"

NAccminer_ver_8="2.2"
NAccminer_tarball_ver_8="nanashi-ccminer-2.2-mod-r2.tar.xz"
NAccminer_ver_8_src="8affcb9cd09edd917d33c1ed450f23400f571bdb"

SILENTminer_ver_8="1.10"
SILENTminer_tarball_ver_8="SILENTminer.v1.1.0.tar.xz"

SPccminer_ver_8="1.8.2"
SPccminer_tarball_ver_8="SPccminer.tar.xz"
SPccminer_ver_8_src="9e86bdd24ed7911b698f1d0ef61a4028fcbd13c5"

SUPRminer_ver_8="1.5"
SUPRminer_tarball_ver_8="SUPRminer-1.5.tar.xz"
SUPRminer_ver_8_src="c800f1a803e1b2074ed2a7c15023c096d0772048"

TPccminer_ver_8="2.2.5"
TPccminer_tarball_ver_8="TPccminer.tar.xz"
TPccminer_ver_8_src="a81ab0f7a557a12a21d716dd03537bc8633fd176"

TPccminer_ver_9="2.3"
TPccminer_tarball_ver_9="TPccminer-2.3.tar.xz"
TPccminer_src_ver_9="370684f7435d1256cbabef4410a57ed5bc705fdc"

vertminer_ver_8="1.0.2"
vertminer_tarball_ver_8="vertminer-nvidia-1.0-stable.2.tar.xz"
vertminer_ver_8_src="48b170a5828256600ca71e66d4c114af4e114236"

xmr_stak_ver_8="2.4.4"
xmr_stak_tarball_ver_8="xmr-stak-2.4.4.tar.xz"
xmr_stak_ver_8_src="c0ab1734332d6472225d8ac7394f6fcba71aabc9"

xmr_stak_ver_9="2.4.7"
xmr_stak_tarball_ver_9="xmr-stak-2.4.7.tar.xz"
xmr_stak_src_ver_9="c5f0505de039545585811585f2c189828dfc3ec2"

ZENEMYminer_ver_8="1.10"
ZENEMYminer_tarball_ver_8="z-enemy-1.10-cuda80.tar.xz"

ZENEMYminer_ver_9="1.14"
ZENEMYminer_tarball_ver_9="z-enemy-1.14-cuda92.tar.xz"

cpuOPT_ver="3.8.8.1"
cpuOPT_tarball="cpuOPT.tar.xz"
cpuOPT_src_ver=""

function stop-if-needed {
  if ps ax | grep miner | grep -v |  grep -q "$1"
  then
    echo "Stopping miner"
    pkill -f 5watchdog
    pkill -e screen
    NEED_RESTART="YES"
  fi
}

function restart-if-needed {
  if [[ $NEED_RESTART == YES ]]
  then
    echo "Restarting nvOC..."
    pkill -f 3main
    NEED_RESTART="NO"
  fi
}

function get-sources {
  if [[ $3 == "" ]]
  then
    chckt_cmd="git -C $1 submodule update --init --force --depth 1 $2"
  else
    git -C $1 submodule update --init --force --depth 1 $2
    chckt_cmd="git -C $1/$2 checkout --force $3"
  fi

  if ! ${chckt_cmd}
  then
    echo "Checkout from shallow clone failed, fetching old commits..."
    git -C "$1/$2" fetch --unshallow
    if ! ${chckt_cmd}
    then
      echo "Checkout from default branch failed, fetching other branches..."
      git -C "$1/$2" remote set-branches origin '*'
      git -C "$1/$2" fetch
      if ! ${chckt_cmd}
      then
        echo "Unable to checkout submodule, can't find target commit."
      fi
    fi
  fi
}

function update-symlink {
  if [[ -L "$1/$2" && -d "$1/$2" ]]
  then
    rm "$1/$2"
  else
    rm -rf "$1/$2"
  fi
  ln -s "$1" "$1/$2"
}

function pluggable-installer {
## waiting for LuKePicci magic
}

function pluggable-compiler {
## waiting for LuKePicci magic
}


pluggable_miners=$(find ${NVOC}/helpers/miners/*/ -name .nvoc-miner.json -print | cut -d/ -f7 | sort -u )
for miner in $pluggable_miners
do
  v8miner=$miner$ucuda_8
  v9miner=$miner$ucuda_9
  vminer=$miner$ucuda

  if [[ ${!v8miner} != "" ]]
  then
    echo "Checking ${miner} version ${!v8miner}"
    if [[ ! -d ${NVOC_MINERS}/${miner}/${!v8miner} ]]
    then
      stop-if-needed "${miner}"
      mkdir -p ${NVOC_MINERS}/${miner}/${!v8miner}/
      cp ${NVOC}/helpers/miners/${miner}/${!v8miner}/.nvoc-miner.json ${NVOC_MINERS}/${miner}/${!v8miner}/.nvoc-miner.json
      pluggable-installer "${NVOC_MINERS}/${miner}/${!v8miner}/"
      ## This part can move to installer section
      if [[ CUDA_VER == "8.0" ]]
      then
        update-symlink ${NVOC_MINERS}/${miner}/${!v8miner} recommended
      fi
      ##
      echo "${miner} updated to version ${!v8miner}"
      restart-if-needed
    else
      echo "${miner} already is on version ${!v8miner}"
    fi
  fi
  if [[ ${!v9miner} != "" ]]
  then
    echo "Checking ${miner} version ${!v9miner}"
    if [[ ! -d ${NVOC_MINERS}/${miner}/${!v9miner} ]]
    then
      stop-if-needed "${miner}"
      mkdir -p ${NVOC_MINERS}/${miner}/${!v9miner}/
      cp ${NVOC}/helpers/miners/${miner}/${!v9miner}/.nvoc-miner.json ${NVOC_MINERS}/${miner}/${!v9miner}/.nvoc-miner.json
      pluggable-installer "${NVOC_MINERS}/${miner}/${!v9miner}/"
      ## This part can move to installer section
      if [[ CUDA_VER == "9.2" ]]
      then
        update-symlink ${NVOC_MINERS}/${miner}/${!v9miner} recommended
        update-symlink ${NVOC_MINERS}/${miner}/${!v9miner} latest
      fi
      ##
      echo "${miner} updated to version ${!v9miner}"
      restart-if-needed
    else
      echo "${miner} already is on version ${!v9miner}"
    fi
  fi
  if [[ ${!vminer} != "" ]]
  then
    echo "Checking ${miner} version ${!vminer}"
    if [[ ! -d ${NVOC_MINERS}/${miner}/${!vminer} ]]
    then
      stop-if-needed "${miner}"
      mkdir -p ${NVOC_MINERS}/${miner}/${!vminer}/
      cp ${NVOC}/helpers/miners/${miner}/${!vminer}/.nvoc-miner.json ${NVOC_MINERS}/${miner}/${!vminer}/.nvoc-miner.json
      pluggable-installer "${NVOC_MINERS}/${miner}/${!vminer}/"
      ## This part can move to installer section
      update-symlink ${NVOC_MINERS}/${miner}/${!v9miner} recommended
      update-symlink ${NVOC_MINERS}/${miner}/${!v9miner} latest
      ##
      echo "${miner} updated to version ${!vminer}"
      restart-if-needed
    fi
  else
    echo "${miner} already is on version ${!vminer}"
  fi
done


echo
echo
echo "Extracting and checking new miners for nvOC-v0019-2.x finished"
echo
echo
sleep 2



### Re work needed on compilation section...


function compile-TPccminer {
  echo "Compiling tpruvot ccminer"
  echo " This could take a while ..."
  if [[ $CUDA_VER == "8" ]]
  then
    get-sources TPccminer
    cd ${NVOC_MINERS}/TPccminer/src_cuda_8
    bash ${NVOC_MINERS}/TPccminer/src_cuda_8/autogen.sh
    bash ${NVOC_MINERS}/TPccminer/src_cuda_8/configure --with-cuda=/usr/local/cuda-8.0
    bash ${NVOC_MINERS}/TPccminer/src_cuda_8/build.sh
    stop-if-needed "[T]Pccminer"
    cp ${NVOC_MINERS}/TPccminer/src_cuda_8/ccminer ${NVOC_MINERS}/TPccminer/${TPccminer_ver}/ccminer
    cd ${NVOC_MINERS}
    echo
    echo "Finished compiling tpruvot ccminer"
    restart-if-needed
  elif [[ $CUDA_VER == "9.2" ]]
  then
    get-sources TPccminer
    cd ${NVOC_MINERS}/TPccminer/src_cuda_9
    bash ${NVOC_MINERS}/TPccminer/src_cuda_9/autogen.sh
    bash ${NVOC_MINERS}/TPccminer/src_cuda_9/configure --with-cuda=/usr/local/cuda-9.2
    bash ${NVOC_MINERS}/TPccminer/src_cuda_9/build.sh
    stop-if-needed "[T]Pccminer"
    cp ${NVOC_MINERS}/TPccminer/src_cuda_9/ccminer ${NVOC_MINERS}/TPccminer/${TPccminer_ver}/ccminer
    cd ${NVOC_MINERS}
    echo
    echo "Finished compiling tpruvot ccminer"
    restart-if-needed
  fi
}

function compile-ASccminer {
  echo "Compiling alexis ccminer"
  echo "This could take a while ..."
  get-sources ASccminer
  cd ${NVOC_MINERS}/ASccminer/src
  bash ${NVOC_MINERS}/ASccminer/src/autogen.sh
  bash ${NVOC_MINERS}/ASccminer/src/configure --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/ASccminer/src/build.sh
  stop-if-needed "[A]Sccminer"
  cp ${NVOC_MINERS}/ASccminer/src/ccminer ${NVOC_MINERS}/ASccminer/ccminer
  cd ${NVOC_MINERS}
  echo "Finished compiling alexis ccminer"
  restart-if-needed
}

function compile-KTccminer {
  echo "Compiling KlausT ccminer"
  echo " This could take a while ..."
  get-sources KTccminer
  if [[ $CUDA_VER == "8" ]]
  then
    cd ${NVOC_MINERS}/KTccminer/cuda-8_src
    bash ${NVOC_MINERS}/KTccminer/cuda-8_src/autogen.sh
    bash ${NVOC_MINERS}/KTccminer/cuda-8_src/configure --with-cuda=/usr/local/cuda-8.0
    bash ${NVOC_MINERS}/KTccminer/cuda-8_src/build.sh
    stop-if-needed "[K]Tccminer"
    cp ${NVOC_MINERS}/KTccminer/cuda-8_src/ccminer ${NVOC_MINERS}/KTccminer/ccminer
    cd ${NVOC_MINERS}
    echo
  elif [[ $CUDA_VER == "9.2" ]]
  then
    cd ${NVOC_MINERS}/KTccminer/src
    bash ${NVOC_MINERS}/KTccminer/src/autogen.sh
    bash ${NVOC_MINERS}/KTccminer/src/configure
    bash ${NVOC_MINERS}/KTccminer/src/build.sh
    stop-if-needed "[K]Tccminer"
    cp ${NVOC_MINERS}/KTccminer/src/ccminer ${NVOC_MINERS}/KTccminer/ccminer
    cd ${NVOC_MINERS}
  fi
  echo "Finished compiling KlausT ccminer with cuda $CUDA_VER"
  restart-if-needed
}

function compile-KTccminer_cryptonight {
  echo "Compiling KlausT ccminer cryptonight"
  echo " This could take a while ..."
  get-sources KTccminer_cryptonight
  cd ${NVOC_MINERS}/KTccminer_cryptonight/src
  bash ${NVOC_MINERS}/KTccminer_cryptonight/src/autogen.sh
  bash ${NVOC_MINERS}/KTccminer_cryptonight/src/configure
  bash ${NVOC_MINERS}/KTccminer_cryptonight/src/build.sh
  stop-if-needed "[K]Tccminer-cryptonight"
  cp ${NVOC_MINERS}/KTccminer_cryptonight/src/ccminer ${NVOC_MINERS}/KTccminer_cryptonight/ccminer
  cd ${NVOC_MINERS}
  echo
  echo "Finished compiling KlausT ccminer cryptonight"
  restart-if-needed
}

function compile-KXccminer {
  echo "Compiling krnlx ccminer"
  echo " This could take a while ..."
  get-sources KXccminer
  cd ${NVOC_MINERS}/KXccminer/src
  bash ${NVOC_MINERS}/KXccminer/src/autogen.sh
  bash ${NVOC_MINERS}/KXccminer/src/configure --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/KXccminer/src/build.sh
  stop-if-needed "[K]Xccminer"
  cp ${NVOC_MINERS}/KXccminer/src/ccminer ${NVOC_MINERS}/KXccminer/ccminer
  cd ${NVOC_MINERS}
  echo
  echo "Finished compiling Krnlx ccminer"
  restart-if-needed
}

function compile-NAccminer {
  echo "Compiling Nanashi ccminer"
  echo " This could take a while ..."
  get-sources NAccminer
  cd ${NVOC_MINERS}/NAccminer/src
  bash ${NVOC_MINERS}/NAccminer/src/autogen.sh
  bash ${NVOC_MINERS}/NAccminer/src/configure --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/NAccminer/src/build.sh
  stop-if-needed "[N]Accminer"
  cp ${NVOC_MINERS}/NAccminer/src/ccminer ${NVOC_MINERS}/NAccminer/ccminer
  cd ${NVOC_MINERS}
  echo
  echo "Finished compiling Nanashi ccminer"
  restart-if-needed
}

function compile-SPccminer {
  echo "Compiling SPccminer"
  echo " This could take a while ..."
  get-sources SPccminer
  cd ${NVOC_MINERS}/SPccminer/src
  bash ${NVOC_MINERS}/SPccminer/src/autogen.sh
  bash ${NVOC_MINERS}/SPccminer/src/configure --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/SPccminer/src/build.sh
  stop-if-needed "[S]Pccminer"
  cp ${NVOC_MINERS}/SPccminer/src/ccminer ${NVOC_MINERS}/SPccminer/ccminer
  cd ${NVOC_MINERS}
  echo
  echo "Finished compiling tpruvot ccminer"
  restart-if-needed
}

function compile-vertminer {
  echo "Compiling Vertminer"
  echo " This could take a while ..."
  get-sources vertminer
  cd ${NVOC_MINERS}/vertminer/src
  bash ${NVOC_MINERS}/vertminer/src/autogen.sh
  bash ${NVOC_MINERS}/vertminer/src/configure --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/vertminer/src/build.sh
  stop-if-needed "[v]ertminer"
  cp ${NVOC_MINERS}/vertminer/src/vertminer ${NVOC_MINERS}/vertminer/vertminer
  cd ${NVOC_MINERS}
  echo
  echo "Finished compiling vertminer"
  restart-if-needed
}

function compile-ANXccminer {
  echo "Compiling anorganix ccminer"
  echo " This could take a while ..."
  get-sources ANXccminer
  cd ${NVOC_MINERS}/ANXccminer/src
  bash ${NVOC_MINERS}/ANXccminer/src/autogen.sh
  bash ${NVOC_MINERS}/ANXccminer/src/configure --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/ANXccminer/src/build.sh
  stop-if-needed "[A]NXccminer"
  cp ${NVOC_MINERS}/ANXccminer/src/ccminer ${NVOC_MINERS}/ANXccminer/ccminer
  cd ${NVOC_MINERS}
  echo
  echo "Finished compiling anorganix ccminer"
  restart-if-needed
}

function compile-MSFTccminer {
  echo "Compiling MSFTccminer"
  echo " This could take a while ..."
  get-sources MSFTccminer
  cd ${NVOC_MINERS}/MSFTccminer/src
  bash ${NVOC_MINERS}/MSFTccminer/src/autogen.sh
  bash ${NVOC_MINERS}/MSFTccminer/src/configure --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/MSFTccminer/src/build.sh
  stop-if-needed "[M]SFTccminer"
  cp ${NVOC_MINERS}/MSFTccminer/src/ccminer ${NVOC_MINERS}/MSFTccminer/ccminer
  cd ${NVOC_MINERS}
  echo
  echo "Finished compiling MSFTccminer"
  restart-if-needed
}

function compile-SUPRminer {
  echo "Compiling SUPRminer"
  echo " This could take a while ..."
  get-sources SUPRminer
  cd ${NVOC_MINERS}/SUPRminer/src
  bash ${NVOC_MINERS}/SUPRminer/src/autogen.sh
  bash ${NVOC_MINERS}/SUPRminer/src/configure --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/SUPRminer/src/build.sh
  stop-if-needed "[S]UPRminer"
  cp ${NVOC_MINERS}/SUPRminer/src/ccminer ${NVOC_MINERS}/SUPRminer/ccminer
  cd ${NVOC_MINERS}
  echo
  echo "Finished compiling SUPRminer"
  restart-if-needed
}

function compile-xmr-stak {
  echo "Compiling xmr-stak"
  echo " This could take a while ..."
  get-sources xmr-stak
  mkdir ${NVOC_MINERS}/xmr-stak/src/build
  cd ${NVOC_MINERS}/xmr-stak/src/build
  cmake ..
  make install
  stop-if-needed "[x]mr-stak"
  cp ${NVOC_MINERS}/xmr-stak/src/build/bin/xmr-stak ${NVOC_MINERS}/xmr-stak/src/build/bin/*.so ${NVOC_MINERS}/xmr-stak/xmr-stak_miner
  cd ${NVOC_MINERS}
  echo
  echo "Finished compiling xmr-stak"
  restart-if-needed
}

function compile-cpuminer {
  echo "Compiling cpuminer"
  echo " This could take a while ..."
  get-sources cpuOPT
  cd ${NVOC_MINERS}/cpuOPT/src
  bash ${NVOC_MINERS}/cpuOPT/src/build.sh
  stop-if-needed "[c]puminer"
  cp ${NVOC_MINERS}/cpuOPT/src/cpuminer ${NVOC_MINERS}/cpuOPT/cpuminer
  cd ${NVOC_MINERS}
  echo
  echo "Finished compiling cpuminer"
  restart-if-needed
}

if [[ $1 == "--no-recompile" ]]; then
  echo "Done."
  echo "Recompilation skipped."
# complete unattended script execution
  exit 0
else
  echo -n "Do you want to re-compile your miners (y/N)?  "
  sleep 1
  read -n 1 ANSWER
  if [ ! "${ANSWER}" = "y" ] ; then
    echo
    echo "Done."
    exit 0
  fi
fi

echo
echo
echo "Checking if bn.h bignum error is fixed for compiling miners or not"
if [ -e  ~/Downloads/openssl-1.0.1e/bn.h.backup ]
then
  echo "bn.h openssl already fixed for compiling miners"
  echo
else
  cd ~/Downloads
  wget -nv http://www.openssl.org/source/openssl-1.0.1e.tar.gz
  tar -xvzf openssl-1.0.1e.tar.gz
  cp /usr/local/include/openssl/bn.h ~/Downloads/openssl-1.0.1e/bn.h.backup
  sudo cp ~/Downloads/openssl-1.0.1e/crypto/bn/bn.h /usr/local/include/openssl/
  sleep 1
  echo
  echo "bn.h openssl fixed for compiling miners"
  echo
  cd ${NVOC_MINERS}
fi

IFS=', '
echo "Select miners to compile (multiple comma separated values: 1,6,7)"
echo "1 - ASccminer"
echo "2 - KTccminer"
echo "3 - KTccminer_cryptonight"
echo "4 - KXccminer"
echo "5 - NAccminer"
echo "6 - SPccminer"
echo "7 - TPccminer"
echo "8 - vertminer"
echo "9 - ANXccminer"
echo "C - cpuminer"
echo "R - MSFTccminer (RVN)"
echo "U - SUPRminer"
echo "X - xmr-stak"
echo
read -p "Do your Choice: [A]LL [1] [2] [3] [4] [5] [6] [7] [8] [9] [C] [R] [U] [X] [E]xit: " -a array
for choice in "${array[@]}"; do
  case "$choice" in
    [Aa]* ) echo "ALL"
      compile-ASccminer
      echo
      echo
      compile-KTccminer
      echo
      echo
      compile-KTccminer_cryptonight
      echo
      echo
      compile-KXccminer
      echo
      echo
      compile-NAccminer
      echo
      echo
      compile-SPccminer
      echo
      echo
      compile-TPccminer
      echo
      echo
      compile-vertminer
      echo
      echo
      compile-ANXccminer
      echo
      echo
      compile-MSFTccminer
      echo
      echo
      compile-SUPRminer
      echo
      echo
      compile-xmr-stak
      echo
      echo
      compile-cpuminer
      ;;
    [1]* ) echo -e "$choice"
      compile-ASccminer
      ;;
    [2]* ) echo -e "$choice"
      compile-KTccminer
      ;;
    [3]* ) echo -e "$choice\n"
      compile-KTccminer_cryptonight
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
    [C]* ) echo -e "$choice"
      compile-cpuminer
      ;;
    [R]* ) echo -e "$choice"
      compile-MSFTccminer
      ;;
    [U]* ) echo -e "$choice"
      compile-SUPRminer
      ;;
    [X]* ) echo -e "$choice"
      compile-xmr-stak
      ;;
    [Ee]* ) echo "exited by user"; break;;
    * ) echo "Are you kidding me???";;
  esac
done
