#!/bin/bash

echo "Updating miners for nvOC V0019-2.1"
echo "Will check and restart miner if needed"

echo
export NVOC_MINERS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CUDA_VER="8.0"
if  nvcc --version | grep -v grep | grep -q "9.2"
then
  CUDA_VER="9.2"
fi

## Miner versions and tarballs

ANXccminer_ver_8="1.0"
ANXccminer_compiled_tarball_ver_8="ANXccminer.tar.xz"
ANXccminer_release_tarball_ver_8="phi-1.0.tar.gz"
ANXccminer_release_tarball_url_ver_8="https://github.com/anorganix/ccminer-phi/archive/ccminer/phi-1.0.tar.gz"

ASccminer_ver_8="1.0"
ASccminer_compiled_tarball_ver_8="ASccminer.tar.xz"
ASccminer_release_tarball_ver_8="v1.0.tar.gz"
ASccminer_release_tarball_url_ver_8="https://github.com/alexis78/ccminer/archive/v1.0.tar.gz"

bminer_ver="9.1.0"
bminer_tarball="bminer-v9.1.0.tar.xz"

claymore_ver="11.9"
claymore_tarball="Claymore-v11.9.tar.xz"

dstm_ver="0.6.1"
dstm_tarball="DSTM_0.6.1.tar.xz"

ethminer_ver_8="0.14.0"
ethminer_compiled_tarball_ver_8="ethminer-0.14.0-Linux.tar.xz"
ethminer_release_tarball_ver_8="ethminer-0.14.0-Linux.tar.gz"
ethminer_release_tarball_url_ver_8="https://github.com/ethereum-mining/ethminer/releases/download/v0.14.0/ethminer-0.14.0-Linux.tar.gz"

ethminer_ver_9="0.15.0"
ethminer_compiled_tarball_ver_9="ethminer-0.15.0-Linux.tar.xz"
ethminer_release_tarball_ver_9="ethminer-0.15.0-Linux.tar.gz"
ethminer_release_tarball_url_ver_9="https://github.com/ethereum-mining/ethminer/releases/download/v0.15.0/ethminer-0.15.0-Linux.tar.gz"

ewbf_ver="3.4"
ewbf_tarball="0.3.4b.tar.xz"

z_ewbf_ver="0.5"
z_ewbf_tarball="z_ewbf_v0.5.tar.xz"

KTccminer_ver_8="8.20"
KTccminer_compiled_tarball_ver_8="KTccminer.tar.xz"
KTccminer_release_tarball_ver_8="8.20.tar.gz"
KTccminer_release_tarball_url_ver_8="https://github.com/KlausT/ccminer/archive/8.20.tar.gz"

KTccminer_ver_9="8.22"
KTccminer_compiled_tarball_ver_9="KTccminer-8.22.tar.xz"
KTccminer_release_tarball_ver_9="8.22.tar.gz"
KTccminer_release_tarball_url_ver_9="https://github.com/KlausT/ccminer/archive/8.22.tar.gz"

KTccminer_cryptonight_ver_8="2.06"
KTccminer_cryptonight_compiled_tarball_ver_8="KTccminer-cryptonight.tar.xz"
KTccminer_cryptonight_release_tarball_ver_8="ccminer-cryptonight-206-x64-cuda8.zip"
KTccminer_cryptonight_release_tarball_url_ver_8="https://github.com/KlausT/ccminer-cryptonight/releases/download/2.06/ccminer-cryptonight-206-x64-cuda8.zip"

KTccminer_cryptonight_ver_9="3.05"
KTccminer_cryptonight_compiled_tarball_ver_9="KTccminer-cryptonight-3.05.tar.xz"
KTccminer_cryptonight_release_tarball_ver_9="ccminer-cryptonight-305-x64-cuda92.zip"
KTccminer_cryptonight_release_tarball_url_ver_9="https://github.com/KlausT/ccminer-cryptonight/releases/download/3.05/ccminer-cryptonight-305-x64-cuda92.zip"

KXccminer_ver_8="0.1"
KXccminer_tarball_ver_8="KXccminer.tar.xz"
KXccminer_compiled_tarball_ver_8="KXccminer.tar.xz"
KXccminer_release_tarball_ver_8="0.1.tar.gz"
KXccminer_release_tarball_url_ver_8="https://github.com/krnlx/ccminer-xevan/archive/0.1.tar.gz"

MSFTccminer_ver_8="2.2.5"
MSFTccminer_compiled_tarball_ver_8="MSFTccminer.tar.xz"
MSFTccminer_release_tarball_ver_8="2.2.5-rvn.tar.gz"
MSFTccminer_release_tarball_url_ver_8="https://github.com/MSFTserver/ccminer/archive/2.2.5-rvn.tar.gz"

NAccminer_ver_8="2.2"
NAccminer_compiled_tarball_ver_8="nanashi-ccminer-2.2-mod-r2.tar.xz"
NAccminer_release_tarball_ver_8="v2.2-mod-r2.tar.gz"
NAccminer_release_tarball_url_ver_8="https://github.com/Nanashi-Meiyo-Meijin/ccminer_v2.2_mod_r2/archive/v2.2-mod-r2.tar.gz"

SILENTminer_ver_8="1.10"
SILENTminer_tarball_ver_8="SILENTminer.v1.1.0.tar.xz"

SPccminer_ver_8="1.8.2"
SPccminer_compiled_tarball_ver_8="SPccminer.tar.xz"
SPccminer_release_tarball_ver_8="1.5.81.tar.gz"
SPccminer_release_tarball_url_ver_8="https://github.com/sp-hash/ccminer/archive/1.5.81.tar.gz"

SUPRminer_ver_8="1.5"
SUPRminer_compiled_tarball_ver_8="SUPRminer-1.5.tar.xz"
SUPRminer_release_tarball_ver_8="1.5.tar.gz"
SUPRminer_release_tarball_url_ver_8="https://github.com/ocminer/suprminer/archive/1.5.tar.gz"

TPccminer_ver_8="2.2.5"
TPccminer_compiled_tarball_ver_8="TPccminer.tar.xz"
TPccminer_release_tarball_ver_8="2.2.5-tpruvot.tar.gz"
TPccminer_release_tarball_url_ver_8="https://github.com/tpruvot/ccminer/archive/2.2.5-tpruvot.tar.gz"

TPccminer_ver_9="2.3"
TPccminer_compiled_tarball_ver_9="TPccminer-2.3.tar.xz"
TPccminer_release_tarball_ver_9="2.3-tpruvot.tar.gz"
TPccminer_release_tarball_url_ver_9="https://github.com/tpruvot/ccminer/archive/2.3-tpruvot.tar.gz"

vertminer_ver_8="1.0.2"
vertminer_compiled_tarball_ver_8="vertminer-nvidia-1.0-stable.2.tar.xz"
vertminer_release_tarball_ver_8="v1.0-stable.2.tar.gz"
vertminer_release_tarball_url_ver_8="https://github.com/vertcoin-project/vertminer-nvidia/archive/v1.0-stable.2.tar.gz"

xmr_stak_ver_8="2.4.4"
xmr_stak_compiled_tarball_ver_8="xmr-stak-2.4.4.tar.xz"
xmr_stak_release_tarball_ver_8="2.4.4.tar.gz"
xmr_stak_release_tarball_url_ver_8="https://github.com/fireice-uk/xmr-stak/archive/2.4.4.tar.gz"

xmr_stak_ver_9="2.4.7"
xmr_stak_compiled_tarball_ver_9="xmr-stak-2.4.7.tar.xz"
xmr_stak_release_tarball_ver_9="2.4.7.tar.gz"
xmr_stak_release_tarball_url_ver_9="https://github.com/fireice-uk/xmr-stak/archive/2.4.7.tar.gz"


ZENEMYminer_ver_8="1.10"
ZENEMYminer_tarball_ver_8="z-enemy-1.10-cuda80.tar.xz"

ZENEMYminer_ver_9="1.14"
ZENEMYminer_tarball_ver_9="z-enemy-1.14-cuda92.tar.xz"

cpuOPT_ver="3.8.8.1"
cpuOPT_tarball="cpuOPT.tar.xz"
cpuOPT_src_ver=""

function stop-if-needed {
  if ps ax | grep miner | grep -q "$1"
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

#function pluggable-installer {
## To do
#}

#function pluggable-compiler {
## To do
#}



pluggable_miners=$(find ${NVOC_MINERS}/helpers/miners/*/ -name .nvoc-miner.json -print | cut -d/ -f8 | sort -u )
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
      cp ${NVOC_MINERS}/helpers/miners/${miner}/${!v8miner}/.nvoc-miner.json ${NVOC_MINERS}/${miner}/${!v8miner}/.nvoc-miner.json
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
      cp ${NVOC_MINERS}/helpers/miners/${miner}/${!v9miner}/.nvoc-miner.json ${NVOC_MINERS}/${miner}/${!v9miner}/.nvoc-miner.json
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
      cp ${NVOC_MINERS}/helpers/miners/${miner}/${!vminer}/.nvoc-miner.json ${NVOC_MINERS}/${miner}/${!vminer}/.nvoc-miner.json
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




echo "Checking alexis ccminer (ASccminer)"
if [[ ! -d ${NVOC_MINERS}/ASccminer/${ASccminer_ver_8} ]]
then
  echo "Extracting ASccminer"
  mkdir -p ${NVOC_MINERS}/ASccminer/${ASccminer_ver_8}/
  stop-if-needed "[A]Sccminer"
  tar -xvJf ${NVOC_MINERS}/ASccminer/${ASccminer_compiled_tarball_ver_8} -C ${NVOC_MINERS}/ASccminer/${ASccminer_ver_8}/ --strip 1
  chmod a+x ${NVOC_MINERS}/ASccminer/${ASccminer_ver_8}/ccminer
  update-symlink ${NVOC_MINERS}/ASccminer/${ASccminer_ver_8} recommended
  update-symlink ${NVOC_MINERS}/ASccminer/${ASccminer_ver_8} latest
  restart-if-needed
else
  echo "ASccminer is already up-to-date"
fi

echo
echo

echo "Checking ANXccminer ${ANXccminer_ver_8}"
if [[ ! -d  ${NVOC_MINERS}/ANXccminer/${ANXccminer_ver_8} ]]
then
  echo "Extracting ANXccminer"
  mkdir -p ${NVOC_MINERS}/ANXccminer/${ANXccminer_ver_8}/
  stop-if-needed "[A]NXccminer"
  tar -xvJf ${NVOC_MINERS}/ANXccminer/${ANXccminer_compiled_tarball_ver_8} -C ${NVOC_MINERS}/ANXccminer/${ANXccminer_ver_8}/ --strip 1
  chmod a+x ${NVOC_MINERS}/ANXccminer/${ANXccminer_ver_8}/ccminer
  update-symlink ${NVOC_MINERS}/ANXccminer/${ANXccminer_ver_8} recommended
  update-symlink ${NVOC_MINERS}/ANXccminer/${ANXccminer_ver_8} latest
  restart-if-needed
else
  echo "ANXccminer is already at up-to-date"
fi

echo
echo

echo "Checking Bminer ${bminer_ver}"
if [[ ! -d ${NVOC_MINERS}/bminer/${bminer_ver} ]]
then
  echo "Extracting Bminer"
  mkdir -p ${NVOC_MINERS}/bminer/${bminer_ver}/
  stop-if-needed "[b]miner"
  tar -xvJf ${NVOC_MINERS}/bminer/${bminer_tarball} -C ${NVOC_MINERS}/bminer/${bminer_ver}/ --strip 1
  chmod a+x ${NVOC_MINERS}/bminer/${bminer_ver}/bminer
  update-symlink ${NVOC_MINERS}/bminer/${bminer_ver}/ recommended
  update-symlink ${NVOC_MINERS}/bminer/${bminer_ver}/ latest
  restart-if-needed
else
  echo "Bminer is already up-to-date"
fi

echo
echo

echo "Checking Claymore v${claymore_ver}"
if [[ ! -d ${NVOC_MINERS}/claymore/${claymore_ver} ]]
then
  echo "Extracting Claymore"
  mkdir -p ${NVOC_MINERS}/claymore/${claymore_ver}/
  stop-if-needed "[e]thdcrminer64"
  tar -xvJf ${NVOC_MINERS}/claymore/${claymore_tarball} -C ${NVOC_MINERS}/claymore/${claymore_ver}/ --strip 1
  chmod a+x ${NVOC_MINERS}/claymore/${claymore_ver}/ethdcrminer64
  update-symlink ${NVOC_MINERS}/claymore/${claymore_ver}/ recommended
  update-symlink ${NVOC_MINERS}/claymore/${claymore_ver}/ latest
  restart-if-needed
else
  echo "Claymore is already up-to-date"
fi

echo
echo

echo "Checking Equihash DSTM zm miner ${dstm_ver}"
if [[ ! -d ${NVOC_MINERS}/dstm/${dstm_ver} ]]
then
  echo "Extracting DSTM zm miner"
  mkdir -p ${NVOC_MINERS}/dstm/${dstm_ver}/
  stop-if-needed "[z]m_miner"
  tar -xvJf ${NVOC_MINERS}/dstm/${dstm_tarball} -C ${NVOC_MINERS}/dstm/${dstm_ver}/ --strip 1
  chmod a+x ${NVOC_MINERS}/dstm/${dstm_ver}/zm_miner
  update-symlink ${NVOC_MINERS}/dstm/${dstm_ver}/ recommended
  update-symlink ${NVOC_MINERS}/dstm/${dstm_ver}/ latest
  restart-if-needed
else
  echo "DSTM zm miner is already up-to-date"
fi

echo
echo

echo "Checking Ethminer"
if [[ ! -d ${NVOC_MINERS}/ethminer/${ethminer_ver_8} ]]
then
  echo "Extracting Ethminer ${ethminer_ver_8} and making changes for CUDA-8"
  mkdir -p ${NVOC_MINERS}/ethminer/${ethminer_ver_8}/
  tar -xvJf ${NVOC_MINERS}/ethminer/${ethminer_compiled_tarball_ver_8} -C ${NVOC_MINERS}/ethminer/${ethminer_ver_8}/ --strip 1
  chmod a+x  ${NVOC_MINERS}/ethminer/${ethminer_ver_8}/ccminer
  stop-if-needed "[e]thminer"
  echo "Ethminer for CUDA-8 updated"
  echo "Use ${ethminer_ver_8} or recommended for ethminer_VERSION in 1bash"
  if [[ $CUDA_VER == "8" ]]
  then
    update-symlink ${NVOC_MINERS}/ethminer/${ethminer_ver_8}/ recommended
  fi
  restart-if-needed
else
  echo "Ethminer for CUDA-8 is already up-to-date"
  echo "Use ethminer_VERSION ${ethminer_ver_8} or recommended in 1bash"
fi

if [[ ! -d ${NVOC_MINERS}/ethminer/${ethminer_ver_9} ]]
then
  echo "Extracting Ethminer and making changes for CUDA-9.2"
  mkdir -p ${NVOC_MINERS}/ethminer/${ethminer_ver_9}/
  tar -xvJf ${NVOC_MINERS}/ethminer/${ethminer_compiled_tarball_ver_9} -C ${NVOC_MINERS}/ethminer/${ethminer_ver_9}/ --strip 1
  chmod a+x  ${NVOC_MINERS}/ethminer/${ethminer_ver_9}/ccminer
  stop-if-needed "[e]thminer"
  echo "Ethminer for CUDA-9.2 updated"
  echo "Use latest or recommended or ${ethminer_ver_9} for ethminer_VERSION in 1bash"
  if [[ $CUDA_VER == "9.2" ]]
  then
    update-symlink ${NVOC_MINERS}/ethminer/${ethminer_ver_9}/ recommended
    update-symlink ${NVOC_MINERS}/ethminer/${ethminer_ver_9}/ latest
  fi
  restart-if-needed
else
  echo "Ethminer for CUDA-9.2 is already up-to-date"
  echo "Use ethminer_VERSION latest or recommended or ${ethminer_ver_9} in 1bash"
fi

echo
echo

echo "Checking EWBF Equihash miner "
if [[ ! -d ${NVOC_MINERS}/ewbf/${ewbf_ver} ]]
then
  echo "Extracting EWBF Equihash miner"
  mkdir -p ${NVOC_MINERS}/ewbf/{3.4,3.3}
  tar -xvJf ${NVOC_MINERS}/ewbf/${ewbf_tarball} -C ${NVOC_MINERS}/ewbf/${ewbf_ver}/ --strip 1
  tar -xvJf ${NVOC_MINERS}/ewbf/0.3.3b.tar.xz -C ${NVOC_MINERS}/ewbf/3.3/ --strip 1
  chmod a+x ${NVOC_MINERS}/ewbf/${ewbf_ver}/miner
  chmod a+x ${NVOC_MINERS}/ewbf/3.3/miner
  stop-if-needed "[e]wbf"
  update-symlink ${NVOC_MINERS}/ewbf/${ewbf_ver} latest
  update-symlink ${NVOC_MINERS}/ewbf/${ewbf_ver} recommended
  restart-if-needed
else
  echo "EWBF Equihash miner is already up-to-date"
fi

echo
echo

echo "Checking EWBF ZHASH miner "
if [[ ! -d ${NVOC_MINERS}/z_ewbf/${z_ewbf_ver} ]]
then
  echo "Extracting EWBF ZHASH miner"
  mkdir -p ${NVOC_MINERS}/z_ewbf/${z_ewbf_ver}/
  stop-if-needed "[z]_ewbf"
  tar -xvJf ${NVOC_MINERS}/z_ewbf/${z_ewbf_tarball} -C ${NVOC_MINERS}/z_ewbf/${z_ewbf_ver}/ --strip 1
  chmod a+x ${NVOC_MINERS}/z_ewbf/${z_ewbf_ver}/miner
  update-symlink ${NVOC_MINERS}/z_ewbf/${z_ewbf_ver} latest
  update-symlink ${NVOC_MINERS}/z_ewbf/${z_ewbf_ver} recommended
  restart-if-needed
else
  echo "EWBF ZHASH miner is already up-to-date"
fi

echo
echo

echo "Checking Klaust ccminer (KTccminer)"
if [[ ! -d ${NVOC_MINERS}/KTccminer/${KTccminer_ver_8} ]]
then
  echo "Extracting Klaust ccminer ${KTccminer_ver_8} and making changes for CUDA-8"
  mkdir -p ${NVOC_MINERS}/KTccminer/${KTccminer_ver_8}/
  tar -xvJf ${NVOC_MINERS}/KTccminer/${KTccminer_compiled_tarball_ver_8} -C ${NVOC_MINERS}/KTccminer/${KTccminer_ver_8}/ --strip 1
  chmod a+x  ${NVOC_MINERS}/KTccminer/${KTccminer_ver_8}/ccminer
  stop-if-needed "[K]Tccminer"
  echo "Klaust ccminer for CUDA-8 updated"
  echo "Use ${KTccminer_ver_8} or recommended for KTccminer_VERSION in 1bash"
  if [[ $CUDA_VER == "8" ]]
  then
    update-symlink ${NVOC_MINERS}/KTccminer/${KTccminer_ver_8} recommended
  fi
  restart-if-needed
else
  echo "Klaust ccminer for CUDA-8 is already up-to-date"
  echo "Use KTccminer_VERSION ${KTccminer_ver_8} or recommended in 1bash"
fi

if [[ ! -d ${NVOC_MINERS}/KTccminer/${KTccminer_ver_9} ]]
then
  echo "Extracting Klaust ccminer and making changes for CUDA-9.2"
  mkdir -p ${NVOC_MINERS}/KTccminer/${KTccminer_ver_9}/
  tar -xvJf ${NVOC_MINERS}/KTccminer/${KTccminer_compiled_tarball_ver_9} -C ${NVOC_MINERS}/KTccminer/${KTccminer_ver_9}/ --strip 1
  chmod a+x  ${NVOC_MINERS}/KTccminer/${KTccminer_ver_9}/ccminer
  stop-if-needed "[K]Tccminer"
  echo "Klaust ccminer for CUDA-9.2 updated"
  echo "Use latest or recommended or ${KTccminer_ver_9} for KTccminer_VERSION in 1bash"
  if [[ $CUDA_VER == "9.2" ]]
  then
    update-symlink ${NVOC_MINERS}/KTccminer/${KTccminer_ver_9} recommended
    update-symlink ${NVOC_MINERS}/KTccminer/${KTccminer_ver_9} latest
  fi
  restart-if-needed
else
  echo "Klaust ccminer for CUDA-9.2 is already up-to-date"
  echo "Use KTccminer_VERSION latest or recommended or ${KTccminer_ver_9} in 1bash"
fi

echo
echo

echo "Checking KTccminer_cryptonight"
if [[ ! -d ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_ver_8} ]]
then
  echo "Extracting KTccminer_cryptonight ${KTccminer_cryptonight_ver_8} and making changes for CUDA-8"
  mkdir -p ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_ver_8}/
  tar -xvJf ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_compiled_tarball_ver_8} -C ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_ver_8}/ --strip 1
  chmod a+x  ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_ver_8}/ccminer
  stop-if-needed "[K]Tccminer_cryptonight"
  echo "KTccminer_cryptonight for CUDA-8 updated"
  echo "Use ${KTccminer_cryptonight_ver_8} or recommended for KTccminer_cryptonight_VERSION in 1bash"
  if [[ $CUDA_VER == "8" ]]
  then
    update-symlink ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_ver_8} recommended
  fi
  restart-if-needed
else
  echo "KTccminer_cryptonight for CUDA-8 is already up-to-date"
  echo "Use KTccminer_cryptonight_VERSION ${KTccminer_cryptonight_ver_8} or recommended in 1bash"
fi

if [[ ! -d ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_ver_9} ]]
then
  echo "Extracting KTccminer_cryptonight and making changes for CUDA-9.2"
  mkdir -p ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_ver_9}/
  tar -xvJf ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_compiled_tarball_ver_9} -C ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_ver_9}/ --strip 1
  chmod a+x  ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_ver_9}/ccminer
  stop-if-needed "[K]Tccminer_cryptonight"
  echo "KTccminer_cryptonight for CUDA-9.2 updated"
  echo "Use latest or recommended or ${KTccminer_cryptonight_ver_9} for KTccminer_cryptonight_VERSION in 1bash"
  if [[ $CUDA_VER == "9.2" ]]
  then
    update-symlink ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_ver_9} recommended
    update-symlink ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_ver_9} latest
  fi
  restart-if-needed
else
  echo "KTccminer_cryptonight for CUDA-9.2 is already up-to-date"
  echo "Use KTccminer_cryptonight_VERSION latest or recommended or ${KTccminer_cryptonight_ver_9} in 1bash"
fi

echo
echo

echo "Checking Krnlx ccminer (KXccminer)"
if [[ ! -d ${NVOC_MINERS}/KXccminer/${KXccminer_ver_8} ]]
then
  echo "Extracting KXccminer"
  mkdir -p ${NVOC_MINERS}/KXccminer/${KXccminer_ver_8}/
  stop-if-needed "[K]Xccminer"
  tar -xvJf ${NVOC_MINERS}/KXccminer/${KXccminer_compiled_tarball_ver_8} -C ${NVOC_MINERS}/KXccminer/${KXccminer_ver_8}/ --strip 1
  chmod a+x ${NVOC_MINERS}/KXccminer/${KXccminer_ver_8}/ccminer
  update-symlink ${NVOC_MINERS}/KXccminer/${KXccminer_ver_8} recommended
  update-symlink ${NVOC_MINERS}/KXccminer/${KXccminer_ver_8} latest
  restart-if-needed
else
  echo "KXccminer is already up-to-date"
fi

echo
echo

echo "Checking MSFT ccminer-${MSFTccminer_ver_8}"
if [[ ! -d ${NVOC_MINERS}/MSFTccminer/${MSFTccminer_ver_8} ]]
then
  echo "Extracting MSFT Tpruvot ccminer"
  mkdir -p ${NVOC_MINERS}/MSFTccminer/${MSFTccminer_ver_8}/
  stop-if-needed "[M]SFTccminer"
  tar -xvJf ${NVOC_MINERS}/MSFTccminer/${MSFTccminer_compiled_tarball_ver_8} -C ${NVOC_MINERS}/MSFTccminer/${MSFTccminer_ver_8}/ --strip 1
  chmod a+x ${NVOC_MINERS}/MSFTccminer/${MSFTccminer_ver_8}/ccminer
  update-symlink ${NVOC_MINERS}/MSFTccminer/${MSFTccminer_ver_8} recommended
  update-symlink ${NVOC_MINERS}/MSFTccminer/${MSFTccminer_ver_8} latest
  restart-if-needed
else
  echo "MSFTccminer is already up-to-date"
fi

echo
echo

echo "Checking nanashi-ccminer (NAccminer)"
if [[ ! -d ${NVOC_MINERS}/NAccminer/${NAccminer_ver_8} ]]
then
  echo "Extracting nanashi ccminer"
  mkdir -p ${NVOC_MINERS}/NAccminer/${NAccminer_ver_8}/
  stop-if-needed "[N]Accminer"
  tar -xvJf ${NVOC_MINERS}/NAccminer/${NAccminer_compiled_tarball_ver_8} -C ${NVOC_MINERS}/NAccminer/${NAccminer_ver_8}/ --strip 1
  chmod a+x ${NVOC_MINERS}/NAccminer/${NAccminer_ver_8}/ccminer
  update-symlink ${NVOC_MINERS}/NAccminer/${NAccminer_ver_8} recommended
  update-symlink ${NVOC_MINERS}/NAccminer/${NAccminer_ver_8} latest
  restart-if-needed

else
  echo "nanashi-ccminer is already up-to-date"
fi

echo
echo

echo "Checking SILENTminer ${SILENTminer_ver_8}"
if [[ ! -d ${NVOC_MINERS}/SILENTminer/${SILENTminer_ver_8} ]]
then
  echo "Extracting Silent Miner"
  mkdir -p ${NVOC_MINERS}/SILENTminer/${SILENTminer_ver_8}
  stop-if-needed "[S]ILENTminer"
  tar -xvJf ${NVOC_MINERS}/SILENTminer/${SILENTminer_compiled_tarball_ver_8} -C ${NVOC_MINERS}/SILENTminer/${SILENTminer_ver_8}/ --strip 1
  chmod a+x ${NVOC_MINERS}/SILENTminer/${SILENTminer_ver_8}/ccminer
  update-symlink ${NVOC_MINERS}/SILENTminer/${SILENTminer_ver_8} recommended
  update-symlink ${NVOC_MINERS}/SILENTminer/${SILENTminer_ver_8} latest
  restart-if-needed
else
  echo "Silent Miner is already up-to-date"
fi

echo
echo

echo "Checking SP Mod ccminer ${SPccminer_ver_8}"
if [[ ! -d ${NVOC_MINERS}/SPccminer/${SPccminer_ver_8} ]]
then
  echo "Extracting SPccminer"
  mkdir -p ${NVOC_MINERS}/SPccminer/${SPccminer_ver_8}/
  stop-if-needed "[S]Pccminer"
  tar -xvJf ${NVOC_MINERS}/SPccminer/${SPccminer_compiled_tarball_ver_8} -C ${NVOC_MINERS}/SPccminer/${SPccminer_ver_8}/ --strip 1
  chmod a+x ${NVOC_MINERS}/SPccminer/${SPccminer_ver_8}/ccminer
  update-symlink ${NVOC_MINERS}/SPccminer/${SPccminer_ver_8} recommended
  update-symlink ${NVOC_MINERS}/SPccminer/${SPccminer_ver_8} latest
  restart-if-needed
else
  echo "SPccminer is already up-to-date"
fi

echo
echo

echo "Checking SUPRminer ${SUPRminer_ver_8}"
if [[ ! -d ${NVOC_MINERS}/SUPRminer/${SUPRminer_ver_8} ]]
then
  echo "Extracting SUPRminer"
  mkdir -p ${NVOC_MINERS}/SUPRminer/${SUPRminer_ver_8}/
  stop-if-needed "[S]UPRminer"
  tar -xvJf ${NVOC_MINERS}/SUPRminer/${SUPRminer_compiled_tarball_ver_8} -C ${NVOC_MINERS}/SUPRminer/${SUPRminer_ver_8}/ --strip 1
  chmod a+x ${NVOC_MINERS}/SUPRminer/${SUPRminer_ver_8}/ccminer
  update-symlink ${NVOC_MINERS}/SUPRminer/${SUPRminer_ver_8} recommended
  update-symlink ${NVOC_MINERS}/SUPRminer/${SUPRminer_ver_8} latest
  restart-if-needed
else
  echo "SUPRminer is already up-to-date"
fi

echo
echo

echo "Checking tpruvot ccminer (TPccminer)"
if [[ ! -d ${NVOC_MINERS}/TPccminer/${TPccminer_ver_8} ]]
then
  echo "Extracting tpruvot ccminer ${TPccminer_ver_8} and making changes for CUDA-8"
  mkdir -p ${NVOC_MINERS}/TPccminer/${TPccminer_ver_8}/
  tar -xvJf ${NVOC_MINERS}/TPccminer/${TPccminer_compiled_tarball_ver_8} -C ${NVOC_MINERS}/TPccminer/${TPccminer_ver_8}/ --strip 1
  chmod a+x  ${NVOC_MINERS}/TPccminer/${TPccminer_ver_8}/ccminer
  stop-if-needed "[T]Pccminer"
  echo "tpruvot ccminer for CUDA-8 updated"
  echo "Use ${TPccminer_ver_8} or recommended for TPccminer_VERSION in 1bash"
  if [[ $CUDA_VER == "8.0" ]]
  then
    update-symlink ${NVOC_MINERS}/TPccminer/${TPccminer_ver_8} recommended
  fi
  restart-if-needed
else
  echo "tpruvot ccminer for CUDA-8 is already up-to-date"
  echo "Use TPccminer_VERSION ${TPccminer_ver_8} or recommended in 1bash"
fi

if [[ ! -d ${NVOC_MINERS}/TPccminer/${TPccminer_ver_9} ]]
then
  echo "Extracting tpruvot ccminer and making changes for CUDA-9.2"
  mkdir -p ${NVOC_MINERS}/TPccminer/${TPccminer_ver_9}/
  tar -xvJf ${NVOC_MINERS}/TPccminer/${TPccminer_compiled_tarball_ver_9} -C ${NVOC_MINERS}/TPccminer/${TPccminer_ver_9}/ --strip 1
  chmod a+x  ${NVOC_MINERS}/TPccminer/${TPccminer_ver_9}/ccminer
  stop-if-needed "[T]Pccminer"
  echo "tpruvot ccminer for CUDA-9.2 updated"
  echo "Use latest or recommended or ${TPccminer_ver_9} for TPccminer_VERSION in 1bash"
  if [[ $CUDA_VER == "9.2" ]]
  then
    update-symlink ${NVOC_MINERS}/TPccminer/${TPccminer_ver_9} recommended
    update-symlink ${NVOC_MINERS}/TPccminer/${TPccminer_ver_9} latest
  fi
  restart-if-needed
else
  echo "tpruvot ccminer for CUDA-9.2 is already up-to-date"
  echo "Use TPccminer_VERSION latest or recommended or ${TPccminer_ver_9} in 1bash"
fi

echo
echo

echo "Checking Vertminer ${vertminer_ver_8}"
if [[ ! -d ${NVOC_MINERS}/vertminer/${vertminer_ver_8} ]]
then
  echo "Extracting vertminer"
  mkdir -p ${NVOC_MINERS}/vertminer/${vertminer_ver_8}/
  stop-if-needed "[v]ertminer"
  tar -xvJf ${NVOC_MINERS}/vertminer/${vertminer_compiled_tarball_ver_8} -C ${NVOC_MINERS}/vertminer/${vertminer_ver_8}/ --strip 1
  chmod a+x ${NVOC_MINERS}/vertminer/${vertminer_ver_8}/vertminer
  update-symlink ${NVOC_MINERS}/vertminer/${vertminer_ver_8} recommended
  update-symlink ${NVOC_MINERS}/vertminer/${vertminer_ver_8} latest
  restart-if-needed
else
  echo "Vertminer is already up-to-date"
fi

echo
echo

echo "Checking xmr_stak ${xmr_stak_ver_8}"
if [[ ! -d ${NVOC_MINERS}/xmr_stak/${xmr_stak_ver_8} ]]
then
  echo "Extracting xmr-stak"
  mkdir -p ${NVOC_MINERS}/xmr_stak/${xmr_stak_ver_8}/
  stop-if-needed "[x]mr-stak"
  tar -xvJf ${NVOC_MINERS}/xmr_stak/${xmr_stak_compiled_tarball_ver_8} -C ${NVOC_MINERS}/xmr_stak/${xmr_stak_ver_8}/ --strip 1
  chmod a+x ${NVOC_MINERS}/xmr_stak/${xmr_stak_ver_8}/xmr_stak_miner
  if [[ $CUDA_VER == "8.0" ]]
  then
    update-symlink ${NVOC_MINERS}/xmr_stak/${xmr_stak_ver_8} recommended
  fi
  restart-if-needed
else
  echo "xmr-stak is already up-to-date"
fi

echo "Checking xmr_stak ${xmr_stak_ver_9}"
if [[ ! -d ${NVOC_MINERS}/xmr_stak/${xmr_stak_ver_9} ]]
then
  echo "Extracting xmr-stak"
  mkdir -p ${NVOC_MINERS}/xmr_stak/${xmr_stak_ver_9}/
  stop-if-needed "[x]mr-stak"
  tar -xvJf ${NVOC_MINERS}/xmr_stak/${xmr_stak_compiled_tarball_ver_9} -C ${NVOC_MINERS}/xmr_stak/${xmr_stak_ver_9}/ --strip 1
  chmod a+x ${NVOC_MINERS}/xmr_stak/${xmr_stak_ver_8}/xmr_stak_miner
  if [[ $CUDA_VER == "9.2" ]]
  then
    update-symlink ${NVOC_MINERS}/xmr_stak/${xmr_stak_ver_9} recommended
    update-symlink ${NVOC_MINERS}/xmr_stak/${xmr_stak_ver_9} latest
  fi
  restart-if-needed
else
  echo "xmr-stak is already up-to-date"
fi
echo
echo


echo "Checking Z-ENEMY miner"
if [[ ! -d ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_ver_8} ]]
then
  echo "Extracting Z-ENEMY miner ${ZENEMYminer_ver_8} and making changes for CUDA-8"
  mkdir -p ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_ver_8}/
  tar -xvJf ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_tarball_ver_8} -C ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_ver_8}/ --strip 1
  chmod a+x  ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_ver_8}/ccminer
  stop-if-needed "[Z]ENEMYminer"
  echo "Z-ENEMY miner for CUDA-8 updated"
  echo "Use ${ZENEMYminer_ver_8} or recommended for ZENEMYminer_VERSION in 1bash"
  if [[ $CUDA_VER == "8.0" ]]
  then
    update-symlink ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_ver_8} recommended
  fi
  restart-if-needed
else
  echo "Z-ENEMY miner for CUDA-8 is already up-to-date"
  echo "Use ZENEMYminer_VERSION ${ZENEMYminer_ver_8} or recommended in 1bash"
fi

if [[ ! -d ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_ver_9} ]]
then
  echo "Extracting Z-ENEMY miner and making changes for CUDA-9.2"
  mkdir -p ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_ver_9}/
  tar -xvJf ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_tarball_ver_9} -C ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_ver_9}/ --strip 1
  chmod a+x  ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_ver_9}/ccminer
  stop-if-needed "[Z]ENEMYminer"
  echo "Z-ENEMY miner for CUDA-9.2 updated"
  echo "Use latest or recommended or ${ZENEMYminer_ver_9} for ZENEMYminer_VERSION in 1bash"
  if [[ $CUDA_VER == "9.2" ]]
  then
    update-symlink ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_ver_9} recommended
    update-symlink ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_ver_9} latest
  fi
  restart-if-needed
else
  echo "Z-ENEMY miner for CUDA-9.2 is already up-to-date"
  echo "Use ZENEMYminer_VERSION latest or recommended or ${ZENEMYminer_ver_9} in 1bash"
fi

echo
echo

echo "Checking cpuminer-opt "
if [[ ! -d ${NVOC_MINERS}/cpuOPT/${cpuOPT_ver} ]]
then
  echo "Extracting cpuminer"
  mkdir -p ${NVOC_MINERS}/cpuOPT/${cpuOPT_ver}/
  stop-if-needed "[c]puminer"
  tar -xvJf ${NVOC_MINERS}/cpuOPT/${cpuOPT_tarball} -C ${NVOC_MINERS}/cpuOPT/${cpuOPT_ver}/ --strip 1
  chmod a+x ${NVOC_MINERS}/cpuOPT/${cpuOPT_ver}/cpuminer
  update-symlink ${NVOC_MINERS}/cpuOPT/${cpuOPT_ver} recommended
  update-symlink ${NVOC_MINERS}/cpuOPT/${cpuOPT_ver} latest
  restart-if-needed
else
  echo "cpuminer is already up-to-date"
fi

echo
echo
echo "Extracting and checking new miners for nvOC-v0019-2.x finished"
echo
echo
sleep 2

function compile-TPccminer {
  echo "Compiling tpruvot ccminer"
  echo " This could take a while ..."
  if [[ $CUDA_VER == "8.0" ]]
  then
    if [[ ! -f ${NVOC_MINERS}/TPccminer/$TPccminer_release_tarball_ver_8 ]]
    then
      wget -N $TPccminer_release_tarball_url_ver_8 -P ${NVOC_MINERS}/TPccminer/
    fi
    # Make sure src folder is clean
    if [[ -d ${NVOC_MINERS}/TPccminer/src ]]
    then
      rm -rf ${NVOC_MINERS}/TPccminer/src
    fi
    mkdir -p ${NVOC_MINERS}/TPccminer/src/
    tar -xvzf ${NVOC_MINERS}/TPccminer/$TPccminer_release_tarball_ver_8 -C ${NVOC_MINERS}/TPccminer/src/ --strip 1
    cd ${NVOC_MINERS}/TPccminer/src/
    bash ${NVOC_MINERS}/TPccminer/src/autogen.sh
    bash ${NVOC_MINERS}/TPccminer/src/configure.sh --with-cuda=/usr/local/cuda-8.0
    bash ${NVOC_MINERS}/TPccminer/src/build.sh
    mkdir -p ${NVOC_MINERS}/TPccminer/$TPccminer_ver_8/
    stop-if-needed "[T]Pccminer"
    cp ${NVOC_MINERS}/TPccminer/src/ccminer ${NVOC_MINERS}/TPccminer/$TPccminer_ver_8/ccminer
    cd ${NVOC_MINERS}
    echo
    echo "Finished compiling tpruvot ccminer"
    restart-if-needed
  elif [[ $CUDA_VER == "9.2" ]]
  then
    if [[ ! -f ${NVOC_MINERS}/TPccminer/$TPccminer_release_tarball_ver_9 ]]
    then
      wget -N $TPccminer_release_tarball_url_ver_9 -P ${NVOC_MINERS}/TPccminer/
    fi
    # Make sure src folder is clean
    if [[ -d ${NVOC_MINERS}/TPccminer/src ]]
    then
      rm -rf ${NVOC_MINERS}/TPccminer/src
    fi
    mkdir -p ${NVOC_MINERS}/TPccminer/src/
    tar -xvzf ${NVOC_MINERS}/TPccminer/$TPccminer_release_tarball_ver_9 -C ${NVOC_MINERS}/TPccminer/src/ --strip 1
    cd ${NVOC_MINERS}/TPccminer/src/
    bash ${NVOC_MINERS}/TPccminer/src/autogen.sh
    bash ${NVOC_MINERS}/TPccminer/src/configure.sh --with-cuda=/usr/local/cuda-9.2
    bash ${NVOC_MINERS}/TPccminer/src/build.sh
    mkdir -p ${NVOC_MINERS}/TPccminer/"$TPccminer_ver_9"/
    stop-if-needed "[T]Pccminer"
    cp ${NVOC_MINERS}/TPccminer/src/ccminer ${NVOC_MINERS}/TPccminer/$TPccminer_ver_9/ccminer
    cd ${NVOC_MINERS}
    echo
    echo "Finished compiling tpruvot ccminer"
    restart-if-needed
  fi
}

function compile-ASccminer {
  echo "Compiling alexis ccminer"
  echo "This could take a while ..."
  if [[ ! -f ${NVOC_MINERS}/ASccminer/$ASccminer_release_tarball_ver_8 ]]
  then
    wget -N $ASccminer_release_tarball_url_ver_8 -P ${NVOC_MINERS}/ASccminer/
  fi
  # Make sure src folder is clean
  if [[ -d ${NVOC_MINERS}/ASccminer/src ]]
  then
    rm -rf ${NVOC_MINERS}/ASccminer/src
  fi
  mkdir -p ${NVOC_MINERS}/ASccminer/src/
  tar -xvzf ${NVOC_MINERS}/ASccminer/$ASccminer_release_tarball_ver_8 -C ${NVOC_MINERS}/ASccminer/src/ --strip 1
  cd ${NVOC_MINERS}/ASccminer/src/
  bash ${NVOC_MINERS}/ASccminer/src/autogen.sh
  bash ${NVOC_MINERS}/ASccminer/src/configure.sh --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/ASccminer/src/build.sh
  mkdir -p ${NVOC_MINERS}/ASccminer/$ASccminer_ver_8/
  stop-if-needed "[A]Sccminer"
  cp ${NVOC_MINERS}/ASccminer/src/ccminer ${NVOC_MINERS}/ASccminer/$ASccminer_ver_8/ccminer
  cd ${NVOC_MINERS}
  echo "Finished compiling alexis ccminer"
  restart-if-needed
}

function compile-KTccminer {
  echo "Compiling Klaust ccminer"
  echo " This could take a while ..."
  if [[ $CUDA_VER == "8.0" ]]
  then
    if [[ ! -f ${NVOC_MINERS}/KTccminer/$KTccminer_release_tarball_ver_8 ]]
    then
      wget -N $KTccminer_release_tarball_url_ver_8 -P ${NVOC_MINERS}/KTccminer/
    fi
    # Make sure src folder is clean
    if [[ -d ${NVOC_MINERS}/KTccminer/src ]]
    then
      rm -rf ${NVOC_MINERS}/KTccminer/src
    fi
    mkdir -p ${NVOC_MINERS}/KTccminer/src/
    tar -xvzf ${NVOC_MINERS}/KTccminer/$KTccminer_release_tarball_ver_8 -C ${NVOC_MINERS}/KTccminer/src/ --strip 1
    cd ${NVOC_MINERS}/KTccminer/src/
    bash ${NVOC_MINERS}/KTccminer/src/autogen.sh
    bash ${NVOC_MINERS}/KTccminer/src/configure.sh --with-cuda=/usr/local/cuda-8.0
    bash ${NVOC_MINERS}/KTccminer/src/build.sh
    mkdir -p ${NVOC_MINERS}/KTccminer/$KTccminer_ver_8/
    stop-if-needed "[K]Tccminer"
    cp ${NVOC_MINERS}/KTccminer/src/ccminer ${NVOC_MINERS}/KTccminer/$KTccminer_ver_8/ccminer
    cd ${NVOC_MINERS}
    echo
    echo "Finished compiling tpruvot ccminer"
    restart-if-needed
  elif [[ $CUDA_VER == "9.2" ]]
  then
    if [[ ! -f ${NVOC_MINERS}/KTccminer/$KTccminer_release_tarball_ver_9 ]]
    then
      wget -N $KTccminer_release_tarball_url_ver_9 -P ${NVOC_MINERS}/KTccminer/
    fi
    # Make sure src folder is clean
    if [[ -d ${NVOC_MINERS}/KTccminer/src ]]
    then
      rm -rf ${NVOC_MINERS}/KTccminer/src
    fi
    mkdir -p ${NVOC_MINERS}/KTccminer/src/
    tar -xvzf ${NVOC_MINERS}/KTccminer/$KTccminer_release_tarball_ver_9 -C ${NVOC_MINERS}/KTccminer/src/ --strip 1
    cd ${NVOC_MINERS}/KTccminer/src/
    bash ${NVOC_MINERS}/KTccminer/src/autogen.sh
    bash ${NVOC_MINERS}/KTccminer/src/configure.sh --with-cuda=/usr/local/cuda-9.2
    bash ${NVOC_MINERS}/KTccminer/src/build.sh
    mkdir -p ${NVOC_MINERS}/KTccminer/"$KTccminer_ver_9"/
    stop-if-needed "[K]Tccminer"
    cp ${NVOC_MINERS}/KTccminer/src/ccminer ${NVOC_MINERS}/KTccminer/$KTccminer_ver_9/ccminer
    cd ${NVOC_MINERS}
    echo
    echo "Finished compiling Klaust ccminer"
    restart-if-needed
  fi
}

function compile-KTccminer_cryptonight {
  echo "Compiling Klaust ccminer"
  echo " This could take a while ..."
  if [[ $CUDA_VER == "8.0" ]]
  then
    if [[ ! -f ${NVOC_MINERS}/KTccminer_cryptonight/$KTccminer_cryptonight_release_tarball_ver_8 ]]
    then
      wget -N $KTccminer_cryptonight_release_tarball_url_ver_8 -P ${NVOC_MINERS}/KTccminer_cryptonight/
    fi
    # Make sure src folder is clean
    if [[ -d ${NVOC_MINERS}/KTccminer_cryptonight/src ]]
    then
      rm -rf ${NVOC_MINERS}/KTccminer_cryptonight/src
    fi
    mkdir -p ${NVOC_MINERS}/KTccminer_cryptonight/src/
    tar -xvzf ${NVOC_MINERS}/KTccminer_cryptonight/$KTccminer_cryptonight_release_tarball_ver_8 -C ${NVOC_MINERS}/KTccminer_cryptonight/src/ --strip 1
    cd ${NVOC_MINERS}/KTccminer_cryptonight/src/
    bash ${NVOC_MINERS}/KTccminer_cryptonight/src/autogen.sh
    bash ${NVOC_MINERS}/KTccminer_cryptonight/src/configure.sh --with-cuda=/usr/local/cuda-8.0
    bash ${NVOC_MINERS}/KTccminer_cryptonight/src/build.sh
    mkdir -p ${NVOC_MINERS}/KTccminer_cryptonight/$KTccminer_cryptonight_ver_8/
    stop-if-needed "[KTccminer]_cryptonight"
    cp ${NVOC_MINERS}/KTccminer_cryptonight/src/ccminer ${NVOC_MINERS}/KTccminer_cryptonight/$KTccminer_cryptonight_ver_8/ccminer
    cd ${NVOC_MINERS}
    echo
    echo "Finished compiling Klaust ccminer  cryptonight"
    restart-if-needed
  elif [[ $CUDA_VER == "9.2" ]]
  then
    if [[ ! -f ${NVOC_MINERS}/KTccminer_cryptonight/$KTccminer_cryptonight_release_tarball_ver_9 ]]
    then
      wget -N $KTccminer_cryptonight_release_tarball_url_ver_9 -P ${NVOC_MINERS}/KTccminer_cryptonight/
    fi
    # Make sure src folder is clean
    if [[ -d ${NVOC_MINERS}/KTccminer_cryptonight/src ]]
    then
      rm -rf ${NVOC_MINERS}/KTccminer_cryptonight/src
    fi
    mkdir -p ${NVOC_MINERS}/KTccminer_cryptonight/src/
    tar -xvzf ${NVOC_MINERS}/KTccminer_cryptonight/$KTccminer_cryptonight_release_tarball_ver_9 -C ${NVOC_MINERS}/KTccminer_cryptonight/src/ --strip 1
    cd ${NVOC_MINERS}/KTccminer_cryptonight/src/
    bash ${NVOC_MINERS}/KTccminer_cryptonight/src/autogen.sh
    bash ${NVOC_MINERS}/KTccminer_cryptonight/src/configure.sh --with-cuda=/usr/local/cuda-9.2
    bash ${NVOC_MINERS}/KTccminer_cryptonight/src/build.sh
    mkdir -p ${NVOC_MINERS}/KTccminer_cryptonight/"$KTccminer_cryptonight_ver_9"/
    stop-if-needed "[KTccminer]_cryptonight"
    cp ${NVOC_MINERS}/KTccminer_cryptonight/src/ccminer ${NVOC_MINERS}/KTccminer_cryptonight/$KTccminer_cryptonight_ver_9/ccminer
    cd ${NVOC_MINERS}
    echo
    echo "Finished compiling Klaust ccminer cryptonight"
    restart-if-needed
  fi
}

function compile-KXccminer {
  echo "Compiling ccminer krnlx (KXccminer)"
  echo " This could take a while ..."
  if [[ ! -f ${NVOC_MINERS}/KXccminer/$KXccminer_release_tarball_ver_8 ]]
  then
    wget -N $KXccminer_release_tarball_url_ver_8 -P ${NVOC_MINERS}/KXccminer/
  fi
  # Make sure src folder is clean
  if [[ -d ${NVOC_MINERS}/KXccminer/src ]]
  then
    rm -rf ${NVOC_MINERS}/KXccminer/src
  fi
  mkdir -p ${NVOC_MINERS}/KXccminer/src/
  tar -xvzf ${NVOC_MINERS}/KXccminer/$KXccminer_release_tarball_ver_8 -C ${NVOC_MINERS}/KXccminer/src/ --strip 1
  cd ${NVOC_MINERS}/KXccminer/src/
  bash ${NVOC_MINERS}/KXccminer/src/autogen.sh
  bash ${NVOC_MINERS}/KXccminer/src/configure.sh --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/KXccminer/src/build.sh
  mkdir -p ${NVOC_MINERS}/KXccminer/$KXccminer_ver_8/
  stop-if-needed "[K]Xccminer"
  cp ${NVOC_MINERS}/KXccminer/src/ccminer ${NVOC_MINERS}/KXccminer/$KXccminer_ver_8/ccminer
  cd ${NVOC_MINERS}
  echo
  echo "Finished compiling KXccminer"
  restart-if-needed
}


function compile-NAccminer {
  echo "Compiling Nanashi ccminer (NAccminer)"
  echo " This could take a while ..."
  if [[ ! -f ${NVOC_MINERS}/NAccminer/$NAccminer_release_tarball_ver_8 ]]
  then
    wget -N $NAccminer_release_tarball_url_ver_8 -P ${NVOC_MINERS}/NAccminer/
  fi
  # Make sure src folder is clean
  if [[ -d ${NVOC_MINERS}/NAccminer/src ]]
  then
    rm -rf ${NVOC_MINERS}/NAccminer/src
  fi
  mkdir -p ${NVOC_MINERS}/NAccminer/src/
  tar -xvzf ${NVOC_MINERS}/NAccminer/$NAccminer_release_tarball_ver_8 -C ${NVOC_MINERS}/NAccminer/src/ --strip 1
  cd ${NVOC_MINERS}/NAccminer/src/
  bash ${NVOC_MINERS}/NAccminer/src/autogen.sh
  bash ${NVOC_MINERS}/NAccminer/src/configure.sh --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/NAccminer/src/build.sh
  mkdir -p ${NVOC_MINERS}/NAccminer/$NAccminer_ver_8/
  stop-if-needed "[N]Accminer"
  cp ${NVOC_MINERS}/NAccminer/src/ccminer ${NVOC_MINERS}/NAccminer/$NAccminer_ver_8/ccminer
  cd ${NVOC_MINERS}
  echo
  echo "Finished compiling Nanashi ccminer"
  restart-if-needed
}

function compile-SPccminer {
  echo "Compiling ccminer sp-mod (SPccminer)"
  echo " This could take a while ..."
  if [[ ! -f ${NVOC_MINERS}/SPccminer/$SPccminer_release_tarball_ver_8 ]]
  then
    wget -N $SPccminer_release_tarball_url_ver_8 -P ${NVOC_MINERS}/SPccminer/
  fi
  # Make sure src folder is clean
  if [[ -d ${NVOC_MINERS}/SPccminer/src ]]
  then
    rm -rf ${NVOC_MINERS}/SPccminer/src
  fi
  mkdir -p ${NVOC_MINERS}/SPccminer/src/
  tar -xvzf ${NVOC_MINERS}/SPccminer/$SPccminer_release_tarball_ver_8 -C ${NVOC_MINERS}/SPccminer/src/ --strip 1
  cd ${NVOC_MINERS}/SPccminer/src/
  bash ${NVOC_MINERS}/SPccminer/src/autogen.sh
  bash ${NVOC_MINERS}/SPccminer/src/configure.sh --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/SPccminer/src/build.sh
  mkdir -p ${NVOC_MINERS}/SPccminer/$SPccminer_ver_8/
  stop-if-needed "[S]Pccminer"
  cp ${NVOC_MINERS}/SPccminer/src/ccminer ${NVOC_MINERS}/SPccminer/$SPccminer_ver_8/ccminer
  cd ${NVOC_MINERS}
  echo
  echo "Finished compiling ccminer sp-mod (SPccminer)"
  restart-if-needed
}

function compile-vertminer {
  echo "Compiling vertminer"
  echo " This could take a while ..."
  if [[ ! -f ${NVOC_MINERS}/vertminer/$vertminer_release_tarball_ver_8 ]]
  then
    wget -N $vertminer_release_tarball_url_ver_8 -P ${NVOC_MINERS}/vertminer/
  fi
  # Make sure src folder is clean
  if [[ -d ${NVOC_MINERS}/vertminer/src ]]
  then
    rm -rf ${NVOC_MINERS}/vertminer/src
  fi
  mkdir -p ${NVOC_MINERS}/vertminer/src/
  tar -xvzf ${NVOC_MINERS}/vertminer/$vertminer_release_tarball_ver_8 -C ${NVOC_MINERS}/vertminer/src/ --strip 1
  cd ${NVOC_MINERS}/vertminer/src/
  bash ${NVOC_MINERS}/vertminer/src/autogen.sh
  bash ${NVOC_MINERS}/vertminer/src/configure.sh --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/vertminer/src/build.sh
  mkdir -p ${NVOC_MINERS}/vertminer/$vertminer_ver_8/
  stop-if-needed "[v]ertminer"
  cp ${NVOC_MINERS}/vertminer/src/ccminer ${NVOC_MINERS}/vertminer/$vertminer_ver_8/ccminer
  cd ${NVOC_MINERS}
  echo
  echo "Finished compiling vertminer"
  restart-if-needed
}

function compile-ANXccminer {
  echo "Compiling ANXccminer"
  echo " This could take a while ..."
  if [[ ! -f ${NVOC_MINERS}/ANXccminer/$ANXccminer_release_tarball_ver_8 ]]
  then
    wget -N $ANXccminer_release_tarball_url_ver_8 -P ${NVOC_MINERS}/ANXccminer/
  fi
  # Make sure src folder is clean
  if [[ -d ${NVOC_MINERS}/ANXccminer/src ]]
  then
    rm -rf ${NVOC_MINERS}/ANXccminer/src
  fi
  mkdir -p ${NVOC_MINERS}/ANXccminer/src/
  tar -xvzf ${NVOC_MINERS}/ANXccminer/$ANXccminer_release_tarball_ver_8 -C ${NVOC_MINERS}/ANXccminer/src/ --strip 1
  cd ${NVOC_MINERS}/ANXccminer/src/
  bash ${NVOC_MINERS}/ANXccminer/src/autogen.sh
  bash ${NVOC_MINERS}/ANXccminer/src/configure.sh --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/ANXccminer/src/build.sh
  mkdir -p ${NVOC_MINERS}/ANXccminer/$ANXccminer_ver_8/
  stop-if-needed "[A]NXccminer"
  cp ${NVOC_MINERS}/ANXccminer/src/ccminer ${NVOC_MINERS}/ANXccminer/$ANXccminer_ver_8/ccminer
  cd ${NVOC_MINERS}
  echo
  echo "Finished compiling ANXccminer"
  restart-if-needed
}

function compile-MSFTccminer {
  echo "Compiling MSFTccminer"
  echo " This could take a while ..."
  if [[ ! -f ${NVOC_MINERS}/MSFTccminer/$MSFTccminer_release_tarball_ver_8 ]]
  then
    wget -N $MSFTccminer_release_tarball_url_ver_8 -P ${NVOC_MINERS}/MSFTccminer/
  fi
  # Make sure src folder is clean
  if [[ -d ${NVOC_MINERS}/MSFTccminer/src ]]
  then
    rm -rf ${NVOC_MINERS}/MSFTccminer/src
  fi
  mkdir -p ${NVOC_MINERS}/MSFTccminer/src/
  tar -xvzf ${NVOC_MINERS}/MSFTccminer/$MSFTccminer_release_tarball_ver_8 -C ${NVOC_MINERS}/MSFTccminer/src/ --strip 1
  cd ${NVOC_MINERS}/MSFTccminer/src/
  bash ${NVOC_MINERS}/MSFTccminer/src/autogen.sh
  bash ${NVOC_MINERS}/MSFTccminer/src/configure.sh --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/MSFTccminer/src/build.sh
  mkdir -p ${NVOC_MINERS}/MSFTccminer/$MSFTccminer_ver_8/
  stop-if-needed "[M]SFTccminer"
  cp ${NVOC_MINERS}/MSFTccminer/src/ccminer ${NVOC_MINERS}/MSFTccminer/$MSFTccminer_ver_8/ccminer
  cd ${NVOC_MINERS}
  echo
  echo "Finished compiling MSFTccminer"
  restart-if-needed
}

function compile-SUPRminer {
  echo "Compiling SUPRminer"
  echo " This could take a while ..."
  if [[ ! -f ${NVOC_MINERS}/SUPRminer/$SUPRminer_release_tarball_ver_8 ]]
  then
    wget -N $SUPRminer_release_tarball_url_ver_8 -P ${NVOC_MINERS}/SUPRminer/
  fi
  # Make sure src folder is clean
  if [[ -d ${NVOC_MINERS}/SUPRminer/src ]]
  then
    rm -rf ${NVOC_MINERS}/SUPRminer/src
  fi
  mkdir -p ${NVOC_MINERS}/SUPRminer/src/
  tar -xvzf ${NVOC_MINERS}/SUPRminer/$SUPRminer_release_tarball_ver_8 -C ${NVOC_MINERS}/SUPRminer/src/ --strip 1
  cd ${NVOC_MINERS}/SUPRminer/src/
  bash ${NVOC_MINERS}/SUPRminer/src/autogen.sh
  bash ${NVOC_MINERS}/SUPRminer/src/configure.sh --with-cuda=/usr/local/cuda-8.0
  bash ${NVOC_MINERS}/SUPRminer/src/build.sh
  mkdir -p ${NVOC_MINERS}/SUPRminer/$SUPRminer_ver_8/
  stop-if-needed "[S]UPRccminer"
  cp ${NVOC_MINERS}/SUPRminer/src/ccminer ${NVOC_MINERS}/SUPRminer/$SUPRminer_ver_8/ccminer
  cd ${NVOC_MINERS}
  echo
  echo "Finished compiling SUPRminer"
  restart-if-needed
}

function compile-xmr-stak {
  echo "Compiling xmr-stak ccminer"
  echo " This could take a while ..."
  if [[ $CUDA_VER == "8.0" ]]
  then
    if [[ ! -f ${NVOC_MINERS}/xmr_stak/$xmr_stak_release_tarball_ver_8 ]]
    then
      wget -N $xmr_stak_release_tarball_url_ver_8 -P ${NVOC_MINERS}/xmr_stak/
    fi
    # Make sure src folder is clean
    if [[ -d ${NVOC_MINERS}/xmr_stak/src ]]
    then
      rm -rf ${NVOC_MINERS}/xmr_stak/src
    fi
    mkdir -p ${NVOC_MINERS}/xmr_stak/src/
    tar -xvzf ${NVOC_MINERS}/xmr_stak/$xmr_stak_release_tarball_ver_8 -C ${NVOC_MINERS}/xmr_stak/src/ --strip 1
    cd ${NVOC_MINERS}/xmr_stak/src/
    bash ${NVOC_MINERS}/xmr_stak/src/autogen.sh
    bash ${NVOC_MINERS}/xmr_stak/src/configure.sh --with-cuda=/usr/local/cuda-8.0
    bash ${NVOC_MINERS}/xmr_stak/src/build.sh
    mkdir -p ${NVOC_MINERS}/xmr_stak/$xmr_stak_ver_8/
    stop-if-needed "[xmr]_stak"
    cp ${NVOC_MINERS}/xmr_stak/src/xmr-stak ${NVOC_MINERS}/xmr_stak/$xmr_stak_ver_8/xmr-stak
    cd ${NVOC_MINERS}
    echo
    echo "Finished compiling xmr-stak"
    restart-if-needed
  elif [[ $CUDA_VER == "9.2" ]]
  then
    if [[ ! -f ${NVOC_MINERS}/xmr_stak/$xmr_stak_release_tarball_ver_9 ]]
    then
      wget -N $xmr_stak_release_tarball_url_ver_9 -P ${NVOC_MINERS}/xmr_stak/
    fi
    # Make sure src folder is clean
    if [[ -d ${NVOC_MINERS}/xmr_stak/src ]]
    then
      rm -rf ${NVOC_MINERS}/xmr_stak/src
    fi
    mkdir -p ${NVOC_MINERS}/xmr_stak/src/
    tar -xvzf ${NVOC_MINERS}/xmr_stak/$xmr_stak_release_tarball_ver_9 -C ${NVOC_MINERS}/xmr_stak/src/ --strip 1
    cd ${NVOC_MINERS}/xmr_stak/src/
    bash ${NVOC_MINERS}/xmr_stak/src/autogen.sh
    bash ${NVOC_MINERS}/xmr_stak/src/configure.sh --with-cuda=/usr/local/cuda-9.2
    bash ${NVOC_MINERS}/xmr_stak/src/build.sh
    mkdir -p ${NVOC_MINERS}/xmr_stak/"$xmr_stak_ver_9"/
    stop-if-needed "[xmr]_stak"
    cp ${NVOC_MINERS}/xmr_stak/src/xmr-stak ${NVOC_MINERS}/xmr_stak/$xmr_stak_ver_9/xmr-stak
    cd ${NVOC_MINERS}
    echo
    echo "Finished compiling xmr-stak"
    restart-if-needed
  fi
}

function compile-cpuminer {
  echo "Compiling cpuminer"
  echo " This could take a while ..."
  get-sources cpuOPT
  cd ${NVOC_MINERS}/cpuOPT/src
  bash ${NVOC_MINERS}/cpuOPT/src/build.sh
  stop-if-needed "[c]puminer"
  cp ${NVOC_MINERS}/cpuOPT/src/cpuminer ${NVOC_MINERS}/cpuOPT/${cpuOPT_ver}/cpuminer
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
