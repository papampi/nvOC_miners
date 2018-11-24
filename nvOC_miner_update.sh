#!/bin/bash

echo "nvOC Community Edition miners updater"
echo "Updating miners, Will check and restart miner if needed"

echo
export NVOC_MINERS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CUDA_VER="9.2"
if  nvcc --version | grep -v grep | grep -q "8.0"
then
  CUDA_VER="8.0"
fi

## Miner versions and tarballs

ANXccminer_ver_8="1.0"
ANXccminer_compiled_tarball_ver_8="ANXccminer.tar.xz"
ANXccminer_src_hash_ver_8="cd6fab68823e247bb84dd1fa0448d5f75ec4917d"

ASccminer_ver_8="1.0"
ASccminer_compiled_tarball_ver_8="ASccminer.tar.xz"
ASccminer_src_hash_ver_8="baf6c9e4e36c9cc1b67698ee2977d445f598c573"

BMINER_ver="10.5.0"
BMINER_compiled_tarball="bminer-v10.5.0.tar.xz"

CLAYMORE_ver="11.9"
CLAYMORE_compiled_tarball="Claymore-v11.9.tar.xz"

CryptoDredge_ver="0.10.0"
CryptoDredge_compiled_tarball="CryptoDredge_0.10.0.tar.xz"

DSTM_ver="0.6.2"
DSTM_compiled_tarball="DSTM_0.6.2.tar.xz"

ETHMINER_ver_8="0.14.0"
ETHMINER_compiled_tarball_ver_8="ethminer-0.14.0-Linux.tar.xz"
ETHMINER_src_hash_ver_8="24c65cf166bbb3332d60e2baef859ceb604e5d49"

ETHMINER_ver_9="0.16.0"
ETHMINER_compiled_tarball_ver_9="ethminer-0.16.0.tar.xz"
ETHMINER_src_hash_ver_9="11d7e3c4c087f6c669013e360af84f6d617c02f4"

EWBF_ver="3.4"
EWBF_compiled_tarball="0.3.4b.tar.xz"

Z_EWBF_ver="0.6"
Z_EWBF_compiled_tarball="z_ewbf_v0.6.tar.xz"

KTccminer_ver_8="8.20"
KTccminer_compiled_tarball_ver_8="KTccminer.tar.xz"
KTccminer_src_hash_ver_8="c5ab73837c8024f1e6b8fe7ad46e6881fb8366e6"

KTccminer_ver_9="8.22"
KTccminer_compiled_tarball_ver_9="KTccminer-8.22.tar.xz"
KTccminer_src_hash_ver_9="2e457923f3125fbaedf5d8ba1f7d0fafc85b0ba8"

KTccminer_cryptonight_ver_8="2.06"
KTccminer_cryptonight_compiled_tarball_ver_8="KTccminer-cryptonight.tar.xz"
KTccminer_cryptonight_src_hash_ver_8="bedaf007d4619fc4157aeafb59b44850f08d93f1"

KTccminer_cryptonight_ver_9="3.05"
KTccminer_cryptonight_compiled_tarball_ver_9="KTccminer-cryptonight-3.05.tar.xz"
KTccminer_cryptonight_src_hash_ver_9="7061f3c78e52a03f7ff5d0743900312de5bb24fc"

KXccminer_ver_8="0.1"
KXccminer_compiled_tarball_ver_8="KXccminer.tar.xz"
KXccminer_src_hash_ver_8="7d41d49b92db27b9ab80270adaa92f6b06d1ef78"

LOLMINER_ver="0.43"
LOLMINER_compiled_tarball="lolMiner_v043_Lin64.tar.xz"

MSFTccminer_ver_8="2.2.5"
MSFTccminer_compiled_tarball_ver_8="MSFTccminer.tar.xz"
MSFTccminer_src_hash_ver_8="78dad7dd659eae72a07d2448de62b1946c1f2b41"

NAccminer_ver_8="2.2"
NAccminer_compiled_tarball_ver_8="nanashi-ccminer-2.2-mod-r2.tar.xz"
NAccminer_src_hash_ver_8="8affcb9cd09edd917d33c1ed450f23400f571bdb"

PhoenixMiner_ver="3.5d"
PhoenixMiner_compiled_tarball="PhoenixMiner_3.5d_Linux.tar.xz"

SILENTminer_ver_8="1.10"
SILENTminer_compiled_tarball_ver_8="SILENTminer.v1.1.0.tar.xz"

SPccminer_ver_8="1.8.2"
SPccminer_compiled_tarball_ver_8="SPccminer.tar.xz"
SPccminer_src_hash_ver_8="9e86bdd24ed7911b698f1d0ef61a4028fcbd13c5"

SUPRminer_ver_8="1.5"
SUPRminer_compiled_tarball_ver_8="SUPRminer-1.5.tar.xz"
SUPRminer_src_hash_ver_8="c800f1a803e1b2074ed2a7c15023c096d0772048"

TPccminer_ver_8="2.2.5"
TPccminer_compiled_tarball_ver_8="TPccminer.tar.xz"
TPccminer_src_hash_ver_8="a81ab0f7a557a12a21d716dd03537bc8633fd176"

TPccminer_ver_9="2.3"
TPccminer_compiled_tarball_ver_9="TPccminer-2.3.tar.xz"
TPccminer_src_hash_ver_9="370684f7435d1256cbabef4410a57ed5bc705fdc"

T_Rex_ver="0.8.0"
T_Rex_compiled_tarball="t-rex-0.8.0-linux-cuda9.2.tar.xz"

VERTMINER_ver_8="1.0.2"
VERTMINER_compiled_tarball_ver_8="vertminer-nvidia-1.0-stable.2.tar.xz"
VERTMINER_src_hash_ver_8="48b170a5828256600ca71e66d4c114af4e114236"

XMR_Stak_ver_8="2.4.4"
XMR_Stak_compiled_tarball_ver_8="xmr-stak-2.4.4.tar.xz"
XMR_Stak_src_hash_ver_8="c0ab1734332d6472225d8ac7394f6fcba71aabc9"

XMR_Stak_ver_9="2.5.2"
XMR_Stak_compiled_tarball_ver_9="xmr-stak-2.5.2.tar.xz"
XMR_Stak_src_hash_ver_9="752fd1e7e228cc488d77d771b4615a8eb9fa9c86"

ZENEMYminer_ver_8="1.10"
ZENEMYminer_compiled_tarball_ver_8="z-enemy-1.10-cuda80.tar.xz"

ZENEMYminer_ver_9="1.24"
ZENEMYminer_compiled_tarball_ver_9="z-enemy-1.24v3-cuda92.tar.xz"

cpuOPT_ver="3.8.8.1"
cpuOPT_compiled_tarball="cpuOPT.tar.xz"
cpuOPT_src_ver="bfd1c002f98f2d63f2174618838afc28cf4ffffe"

function stop-if-needed {
  if ps ax | grep miner | grep -v grep | grep -q "$1"
  then
    echo "Stopping miner"
    pkill -ef 5watchdog
    pkill -ef screenrc
    NEED_RESTART="YES"
  fi
}

function restart-if-needed {
  if [[ $NEED_RESTART == YES ]]
  then
    echo "Restarting nvOC..."
    pkill -ef 3main
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
  if [[ -L "$1/$3" && -d "$1/$3" ]]
  then
    rm "$1/$3"
  else
    rm -rf "$1/$3"
  fi
  ln -s "$1/$2" "$1/$3"
}

function pluggable-installer {
  pm="$1"
  pm_path=$(dirname "$1")
  pm_output="${pm_path}/nvoc-miner.json"

  if [[ -f $pm && -f $pm_output && $(md5sum $pm | cut -d ' ' -f1) == $(md5sum $pm_output | cut -d ' ' -f1) ]]
  then
    echo "$(jq -r .friendlyname ${pm_output}) $(jq -r .version ${pm_output}) for $(jq -r .install.recommanded ${pm_output}) is already installed"
    return
  fi

  echo "Extracting $(jq -r .friendlyname ${pm}) $(jq -r .version ${pm}) for $(jq -r .install.recommanded ${pm})"
  mkdir -p "${pm_path}/"
  tar -xvJf "${pm_path}/$(jq -r install.tarball ${pm})" -C "${pm_path}" --strip 1
  chmod a+x "${pm_path}/$(jq -r install.executable ${pm})"
  stop-if-needed "${pm_path}"
  if [[ $CUDA_VER == $(jq -r install.recommanded ${pm}) ]]
  then
    update-symlink "${pm_path}" recommended    
  fi
  if [[ $(jq -r install.latest ${pm}) == true ]]
  then
    update-symlink "${pm_path}" latest    
  fi
  cp -f "$pm" "$pm_output"
  restart-if-needed

  echo "$(jq -r .friendlyname ${pm}) for $(jq -r install.recommanded ${pm}) updated"
}

function pluggable-compiler {
  pm="$1"
  pm_path=$(dirname "$1")
  pm_src="$(jq -r .compile.src_path ${pm})"
  pm_src_hash="$(jq -r .compile.src_commit_hash ${pm})"

  if [[ $pm_src == false ]]
  then
    echo "${pm}: nothing to compile for $(jq -r .friendlyname ${pm})"
    return
  fi

  echo "Initializing sources submodule"
  if ! git submodule init "$1/$2"
  then
    git -C "${pm_path}" submodule add ${pm_src_repo} "${pm_src}"
  fi

  get-sources "${pm_path}" "${pm_src}" $pm_src_hash

  if [[ ! -d $pm_src ]]
  then
    echo "${pm}: can't compile $(jq -r .friendlyname ${pm}), no sources available in '${pm_src}'"
    return
  fi

  pushd "${pm_path}/${pm_src}"

  echo "Compiling $(jq -r .friendlyname ${pm})"
  echo " this will take a while ..."

  eval $(jq -r .compile.command ${pm})

  # TODO: detect compilation failure

  stop-if-needed "${pm_path}"
  cp $(jq -r .compile.output ${pm}) "${pm_path}/"
  echo
  echo "Finished compiling $(jq -r .friendlyname ${pm})"
  restart-if-needed

  popd
}

uver8="_ver_8"
uver9="_ver_9"
uver="_ver"
ucompiled8="_compiled_tarball_ver_8"
ucompiled9="_compiled_tarball_ver_9"
ucompiled="_compiled_tarball"

if [[ -d ${NVOC_MINERS}/helpers ]]
then
  shipped_miners=$(find ${NVOC_MINERS}/helpers/miners/*/ -name .nvoc-miner.json -print | cut -d/ -f8 | sort -u )
else
  shipped_miners=
fi
for miner in $shipped_miners
do
  for _v in $uver8 $uver9 $uver
  do
    vminer=$miner$_v
    if [[ -f ${NVOC_MINERS}/helpers/miners/${miner}/${!vminer}/.nvoc-miner.json ]]
    then
      echo "Checking ${miner} version ${!vminer}"
      mkdir -p ${NVOC_MINERS}/${miner}/${!vminer}/
      cp ${NVOC_MINERS}/helpers/miners/${miner}/${!vminer}/.nvoc-miner.json ${NVOC_MINERS}/${miner}/${!vminer}/.nvoc-miner.json
    fi
  done
done

for pm in $(find "${NVOC_MINERS}"/*/ -name .nvoc-miner.json  -not -path "${NVOC_MINERS}/helpers/*" -print)
do
  pluggable-installer "$pm"
done

builtin_miners="T_Rex PhoenixMiner LOLMINER EWBF Z_EWBF DSTM ETHMINER CLAYMORE BMINER XMR_Stak cpuOPT ASccminer ANXccminer CryptoDredge KTccminer KTccminer_cryptonight KXccminer MSFTccminer NAccminer SILENTminer SPccminer SUPRminer TPccminer VERTMINER ZENEMYminer"
for miner in $builtin_miners
do
  executable="ccminer"
  if [[ $miner == EWBF || $miner == Z_EWBF || $miner == DSTM ]]
  then
    executable="miner"
  elif [[ $miner == ETHMINER ]]
  then
    executable="ethminer"
  elif [[ $miner == CLAYMORE ]]
  then
    executable="ethdcrminer64"
  elif [[ $miner == BMINER ]]
  then
    executable="bminer"
  elif [[ $miner == XMR_Stak ]]
  then
    executable="xmr-stak"
  elif [[ $miner == cpuOPT ]]
  then
    executable="cpuminer"
  elif [[ $miner == LOLMINER ]]
  then
    executable="lolMiner"
  elif [[ $miner == PhoenixMiner ]]
  then
    executable="PhoenixMiner"
  fi

  v8miner=$miner$uver8
  v9miner=$miner$uver9
  vminer=$miner$uver
  x8compiled_tarball=$miner$ucompiled8
  x9compiled_tarball=$miner$ucompiled9
  xcompiled_tarball=$miner$ucompiled

  if [[ ${!v8miner} != "" ]]
  then
    echo "Checking ${miner} (cuda 8) version ${!v8miner}"
    if [[ ! -d ${NVOC_MINERS}/${miner}/${!v8miner} || -z "$(ls -A ${NVOC_MINERS}/${miner}/recommended)" ]]
    then
      stop-if-needed "${miner}"
      mkdir -p ${NVOC_MINERS}/${miner}/${!v8miner}/
      tar -xvJf ${NVOC_MINERS}/${miner}/${!x8compiled_tarball} -C ${NVOC_MINERS}/$miner/${!v8miner}/ --strip 1
      chmod a+x ${NVOC_MINERS}/$miner/${!v8miner}/$executable
      update-symlink ${NVOC_MINERS}/${miner} ${!v8miner} recommended
      echo "${miner} updated to version ${!v8miner}"
      restart-if-needed
    else
      echo "${miner} already is on version ${!v8miner}"
    fi
  fi

  if [[ ${!v9miner} != "" ]]
  then
    echo "Checking ${miner} (cuda 9.2) version ${!v9miner}"
    if [[ ! -d ${NVOC_MINERS}/${miner}/${!v9miner} || -z "$(ls -A ${NVOC_MINERS}/${miner}/latest)" ]]
    then
      stop-if-needed "${miner}"
      mkdir -p ${NVOC_MINERS}/${miner}/${!v9miner}/
      tar -xvJf ${NVOC_MINERS}/${miner}/${!x9compiled_tarball} -C ${NVOC_MINERS}/$miner/${!v9miner}/ --strip 1
      chmod a+x ${NVOC_MINERS}/$miner/${!v9miner}/$executable
      if [[ $CUDA_VER == "9.2" ]]
      then
        update-symlink ${NVOC_MINERS}/${miner} ${!v9miner} recommended
      fi
      update-symlink ${NVOC_MINERS}/${miner} ${!v9miner} latest
      echo "${miner} updated to version ${!v9miner}"
      restart-if-needed
    else
      echo "${miner} already is on version ${!v9miner}"
    fi
  fi

  if [[ ${!vminer} != "" ]]
  then
    echo "Checking ${miner} version ${!vminer}"
    if [[ ! -d ${NVOC_MINERS}/${miner}/${!vminer} || -z "$(ls -A ${NVOC_MINERS}/${miner}/latest)" ]]
    then
      stop-if-needed "${miner}"
      mkdir -p ${NVOC_MINERS}/${miner}/${!vminer}/
      tar -xvJf ${NVOC_MINERS}/${miner}/${!xcompiled_tarball} -C ${NVOC_MINERS}/$miner/${!vminer}/ --strip 1
      chmod a+x ${NVOC_MINERS}/$miner/${!vminer}/$executable
      update-symlink ${NVOC_MINERS}/${miner} ${!vminer} recommended
      update-symlink ${NVOC_MINERS}/${miner} ${!vminer} latest
      echo "${miner} updated to version ${!vminer}"
      restart-if-needed
    else
      echo "${miner} already is on version ${!vminer}"
    fi
  fi
  
  echo && echo
done

echo
echo
echo "Extracting and checking miners finished"
echo
echo


function compile-ANXccminer {
  echo "Compiling ANXccminer"
  echo " This could take a while ..."
  get-sources ${NVOC_MINERS}/ANXccminer src $ANXccminer_src_hash_ver_8
  pushd ${NVOC_MINERS}/ANXccminer/src
  bash ${NVOC_MINERS}/ANXccminer/src/autogen.sh
  bash ${NVOC_MINERS}/ANXccminer/src/configure --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/ANXccminer/src/build.sh
  stop-if-needed "[A]NXccminer"
  cp ${NVOC_MINERS}/ANXccminer/src/ccminer ${NVOC_MINERS}/ANXccminer/ccminer
  popd
  echo
  echo "Finished compiling ANXccminer"
  restart-if-needed
}


function compile-ASccminer {
  echo "Compiling Alexis ccminer"
  echo " This could take a while ..."
  get-sources ${NVOC_MINERS}/ASccminer src $ASccminer_src_hash_ver_8
  pushd ${NVOC_MINERS}/ASccminer/src
  bash ${NVOC_MINERS}/ASccminer/src/autogen.sh
  bash ${NVOC_MINERS}/ASccminer/src/configure --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/ASccminer/src/build.sh
  stop-if-needed "[A]Sccminer"
  cp ${NVOC_MINERS}/ASccminer/src/ccminer ${NVOC_MINERS}/ASccminer/ccminer
  popd
  echo
  echo "Finished compiling Alexis ccminer"
  restart-if-needed
}


function compile-KTccminer {
  echo "Compiling klaust ccminer"
  echo " This could take a while ..."
  if [[ $CUDA_VER == "8.0" ]]
  then
    get-sources ${NVOC_MINERS}/KTccminer src $KTccminer_src_hash_ver_8
  else
    get-sources ${NVOC_MINERS}/KTccminer src $KTccminer_src_hash_ver_9
  fi
  pushd ${NVOC_MINERS}/KTccminer/src
  bash ${NVOC_MINERS}/KTccminer/src/autogen.sh
  bash ${NVOC_MINERS}/KTccminer/src/configure --with-cuda=/usr/local/cuda-$CUDA_VER
  bash ${NVOC_MINERS}/KTccminer/src/build.sh
  stop-if-needed "[K]Tccminer"
  cp ${NVOC_MINERS}/KTccminer/src/ccminer ${NVOC_MINERS}/KTccminer/ccminer
  popd
  echo
  echo "Finished compiling klaust ccminer"
  restart-if-needed
}


function compile-KTccminer_cryptonight {
  echo "Compiling klaust ccminer cryptonight"
  echo " This could take a while ..."
  if [[ $CUDA_VER == "8.0" ]]
  then
    get-sources ${NVOC_MINERS}/KTccminer_cryptonight src $KTccminer_cryptonight_src_hash_ver_8
  else
    get-sources ${NVOC_MINERS}/KTccminer_cryptonight src $KTccminer_cryptonight_src_hash_ver_9
  fi
  pushd ${NVOC_MINERS}/KTccminer_cryptonight/src
  bash ${NVOC_MINERS}/KTccminer_cryptonight/src/autogen.sh
  bash ${NVOC_MINERS}/KTccminer_cryptonight/src/configure "CFLAGS=-O3" "CXXFLAGS=-O3" --with-cuda=/usr/local/cuda-$CUDA_VER
  make -j4
  stop-if-needed "[K]Tccminer_cryptonight"
  cp ${NVOC_MINERS}/KTccminer_cryptonight/src/ccminer ${NVOC_MINERS}/KTccminer_cryptonight/ccminer
  popd
  echo
  echo "Finished compiling klaust cryptonight ccminer"
  restart-if-needed
}


function compile-KXccminer {
  echo "Compiling ccminer krnlx"
  echo " This could take a while ..."
  get-sources ${NVOC_MINERS}/KXccminer src $KXccminer_src_hash_ver_8
  pushd ${NVOC_MINERS}/KXccminer/src
  bash ${NVOC_MINERS}/KXccminer/src/autogen.sh
  bash ${NVOC_MINERS}/KXccminer/src/configure --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/KXccminer/src/build.sh
  stop-if-needed "[K]Xccminer"
  cp ${NVOC_MINERS}/KXccminer/src/ccminer ${NVOC_MINERS}/KXccminer/ccminer
  popd
  echo
  echo "Finished compiling ccminer krnlx"
  restart-if-needed
}


function compile-MSFTccminer {
  echo "Compiling MSFTccminer"
  echo " This could take a while ..."
  get-sources ${NVOC_MINERS}/MSFTccminer src $MSFTccminer_src_hash_ver_8
  pushd ${NVOC_MINERS}/MSFTccminer/src
  bash ${NVOC_MINERS}/MSFTccminer/src/autogen.sh
  bash ${NVOC_MINERS}/MSFTccminer/src/configure --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/MSFTccminer/src/build.sh
  stop-if-needed "[M]SFTccminer"
  cp ${NVOC_MINERS}/MSFTccminer/src/ccminer ${NVOC_MINERS}/MSFTccminer/ccminer
  popd
  echo
  echo "Finished compiling MSFTccminer"
  restart-if-needed
}


function compile-NAccminer {
  echo "Compiling Nanashi ccminer"
  echo " This could take a while ..."
  get-sources ${NVOC_MINERS}/NAccminer src $NAccminer_src_hash_ver_8
  pushd ${NVOC_MINERS}/NAccminer/src
  bash ${NVOC_MINERS}/NAccminer/src/autogen.sh
  bash ${NVOC_MINERS}/NAccminer/src/configure --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/NAccminer/src/build.sh
  stop-if-needed "[N]Accminer"
  cp ${NVOC_MINERS}/NAccminer/src/ccminer ${NVOC_MINERS}/NAccminer/ccminer
  popd
  echo
  echo "Finished compiling Nanashi ccminer "
  restart-if-needed
}


function compile-SPccminer {
  echo "Compiling ccminer SP-Mod"
  echo " This could take a while ..."
  get-sources ${NVOC_MINERS}/SPccminer src $SPccminer_src_hash_ver_8
  pushd ${NVOC_MINERS}/SPccminer/src
  bash ${NVOC_MINERS}/SPccminer/src/autogen.sh
  bash ${NVOC_MINERS}/SPccminer/src/configure --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/SPccminer/src/build.sh
  stop-if-needed "[N]Accminer"
  cp ${NVOC_MINERS}/SPccminer/src/ccminer ${NVOC_MINERS}/SPccminer/ccminer
  popd
  echo
  echo "Finished compiling ccminer SP-Mod"
  restart-if-needed
}


function compile-SUPRminer {
  echo "Compiling SUPRminer"
  echo " This could take a while ..."
  get-sources ${NVOC_MINERS}/SUPRminer src $SUPRminer_src_hash_ver_8
  pushd ${NVOC_MINERS}/SUPRminer/src
  bash ${NVOC_MINERS}/SUPRminer/src/autogen.sh
  bash ${NVOC_MINERS}/SUPRminer/src/configure --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/SUPRminer/src/build.sh
  stop-if-needed "[S]UPRccminer"
  cp ${NVOC_MINERS}/SUPRminer/src/ccminer ${NVOC_MINERS}/SUPRminer/ccminer
  popd
  echo
  echo "Finished compiling SUPRminer"
  restart-if-needed
}


function compile-TPccminer {
  echo "Compiling tpruvot ccminer"
  echo " This could take a while ..."
  if [[ $CUDA_VER == "8.0" ]]
  then
    get-sources ${NVOC_MINERS}/TPccminer src $TPccminer_src_hash_ver_8
  else
    get-sources ${NVOC_MINERS}/TPccminer src $TPccminer_src_hash_ver_9
  fi
  pushd ${NVOC_MINERS}/TPccminer/src
  bash ${NVOC_MINERS}/TPccminer/src/autogen.sh
  bash ${NVOC_MINERS}/TPccminer/src/configure --with-cuda=/usr/local/cuda-$CUDA_VER
  bash ${NVOC_MINERS}/TPccminer/src/build.sh
  stop-if-needed "[T]Pccminer"
  cp ${NVOC_MINERS}/TPccminer/src/ccminer ${NVOC_MINERS}/TPccminer/ccminer
  popd
  echo
  echo "Finished compiling tpruvot ccminer"
  restart-if-needed
}


function compile-VERTMINER {
  echo "Compiling VERTMINER"
  echo " This could take a while ..."
  get-sources ${NVOC_MINERS}/VERTMINER src $VERTMINER_src_hash_ver_8
  pushd ${NVOC_MINERS}/VERTMINER/src
  bash ${NVOC_MINERS}/VERTMINER/src/autogen.sh
  bash ${NVOC_MINERS}/VERTMINER/src/configure --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/VERTMINER/src/build.sh
  stop-if-needed "[v]ertminer"
  cp ${NVOC_MINERS}/VERTMINER/src/vertminer ${NVOC_MINERS}/VERTMINER/vertminer
  popd
  echo
  echo "Finished compiling VERTMINER"
  restart-if-needed
}

# Cuda versions compile need checkup!!!!
function compile-XMR_Stak {
  echo "Compiling  xmr-stak"
  echo " This could take a while ..."
  if [[ $CUDA_VER == "8.0" ]]
  then
    get-sources ${NVOC_MINERS}/XMR_Stak src $XMR_Stak_src_hash_ver_8
  else
    get-sources ${NVOC_MINERS}/XMR_Stak src $XMR_Stak_src_hash_ver_9
  fi
  pushd ${NVOC_MINERS}/XMR_Stak/src
  mkdir ${NVOC_MINERS}/XMR_Stak/src/build
  pushd ${NVOC_MINERS}/XMR_Stak/src/build
  cmake ..
  make
  popd
  stop-if-needed "[xmr]-stak"
  cp ${NVOC_MINERS}/XMR_Stak/src/build/bin/xmr-stak ${NVOC_MINERS}/XMR_Stak/src/build/bin/*.so ${NVOC_MINERS}/XMR_Stak/
  popd
  echo
  echo "Finished compiling xmr-stak"
  restart-if-needed
}


function compile-cpuminer {
  echo "Compiling cpuminer"
  echo " This could take a while ..."
  get-sources cpuOPT
  pushd ${NVOC_MINERS}/cpuOPT/src
  bash ${NVOC_MINERS}/cpuOPT/src/build.sh
  stop-if-needed "[c]puminer"
  cp ${NVOC_MINERS}/cpuOPT/src/cpuminer ${NVOC_MINERS}/cpuOPT/${cpuOPT_ver}/cpuminer
  popd
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
  sleep 2
  echo -n "Do you want to re-compile your miners (y/N)?  "
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
  wget -nv --no-check-certificate http://www.openssl.org/source/openssl-1.0.1e.tar.gz
  tar -xvzf openssl-1.0.1e.tar.gz
  cp /usr/local/include/openssl/bn.h ~/Downloads/openssl-1.0.1e/bn.h.backup
  sudo cp ~/Downloads/openssl-1.0.1e/crypto/bn/bn.h /usr/local/include/openssl/
  sleep 1
  echo
  echo "bn.h openssl fixed for compiling miners"
  echo
  cd ${NVOC_MINERS}
fi

if apt list --installed | grep -q "libcurl3/" 
then 
  sudo apt -y install cmake 
  sudo apt -y autoremove  
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
echo "8 - VERTMINER"
echo "9 - ANXccminer"
echo "C - cpuminer"
echo "R - MSFTccminer (RVN)"
echo "U - SUPRminer"
echo "X - XMR_Stak"
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
      compile-VERTMINER
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
      compile-XMR_Stak
      echo
      echo
      compile-cpuminer
      echo
      echo
      for pm in $(find "${NVOC_MINERS}"/*/ -name nvoc-miner.json -print)
      do
        pluggable-compiler "$pm"
        echo && echo
      done
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
      compile-VERTMINER
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
      compile-XMR_Stak
      ;;
    [Ee]* ) echo "exited by user"; break;;
    * ) echo -e "$choice"
      pm=$(find "${NVOC_MINERS}/$choice" -name nvoc-miner.json -print)
      if [[ -f $pm ]]
      then
        pluggable-compiler "$pm"
      else
        echo "Are you kidding me???"
      fi
      ;;
  esac
 
  if ! apt list --installed | grep -q "libcurl3/" 
  then 
    sudo apt -y install libcurl3
    sudo apt -y autoremove  
  fi
  
done
