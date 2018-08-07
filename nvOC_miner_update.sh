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

# Need dual source update for new miners with cuda 9 support
function get-sources {
  SU_CMD="git -C ${NVOC_MINERS}/$1 submodule update --init --force --depth 1 src"
  if ! ${SU_CMD}
  then
    echo "Update from shallow clone failed, fetching old commits..."
    git -C "${NVOC_MINERS}/$1/src" fetch --unshallow
    if ! ${SU_CMD}
    then
      echo "Update from default branch failed, fetching other branches..."
      git -C "${NVOC_MINERS}/$1/src" remote set-branches origin '*'
      git -C "${NVOC_MINERS}/$1/src" fetch
      if ! ${SU_CMD}
      then
        echo "Unable to update submodule, can't find target commit."
      fi
    fi
  fi
}



echo "Checking EWBF Equihash miner "
if ! grep -q "0.3.4b" ${NVOC_MINERS}/ewbf/latest/version
then
  echo "Extracting EWBF Equihash miner"
  mkdir -p ${NVOC_MINERS}/ewbf/{3_4,3_3}
  tar -xvJf ${NVOC_MINERS}/ewbf/0.3.4b.tar.xz -C ${NVOC_MINERS}/ewbf/3_4/ --strip 1
  tar -xvJf ${NVOC_MINERS}/ewbf/0.3.3b.tar.xz -C ${NVOC_MINERS}/ewbf/3_3/ --strip 1
  chmod a+x ${NVOC_MINERS}/ewbf/3_4/miner
  chmod a+x ${NVOC_MINERS}/ewbf/3_3/miner
  stop-if-needed "[e]wbf"
  if [[ -L "${NVOC_MINERS}/ewbf/latest" && -d "${NVOC_MINERS}/ewbf/latest" ]]
  then
    rm ${NVOC_MINERS}/ewbf/latest
  else
    rm -rf ${NVOC_MINERS}/ewbf/latest
  fi
  ln -s ${NVOC_MINERS}/ewbf/3_4 "${NVOC_MINERS}/ewbf/latest"
  restart-if-needed
else
  echo "EWBF Equihash miner is already up-to-date"
fi

echo

echo "Checking EWBF ZHASH miner "
if ! grep -q "v0.5" ${NVOC_MINERS}/z_ewbf/latest/version
then
  echo "Extracting EWBF ZHASH miner"
  mkdir -p ${NVOC_MINERS}/z_ewbf/latest/
  stop-if-needed "[z]_ewbf"
  tar -xvJf ${NVOC_MINERS}/z_ewbf/z_ewbf_v0.5.tar.xz -C ${NVOC_MINERS}/z_ewbf/latest/ --strip 1
  chmod a+x ${NVOC_MINERS}/z_ewbf/latest/miner
  restart-if-needed
else
  echo "EWBF ZHASH miner is already up-to-date"
fi

echo

echo "Checking Equihash DSTM zm miner 0.6.1"
if ! grep -q "0.6.1" ${NVOC_MINERS}/dstm/latest/version
then
  echo "Extracting DSTM zm miner"
  mkdir -p ${NVOC_MINERS}/dstm/latest/
  stop-if-needed "[z]m_miner"
  tar -xvJf ${NVOC_MINERS}/dstm/DSTM_0.6.1.tar.xz -C ${NVOC_MINERS}/dstm/latest/ --strip 1
  chmod a+x ${NVOC_MINERS}/dstm/latest/zm_miner
  restart-if-needed
else
  echo "DSTM zm miner is already up-to-date"
fi

echo
echo

echo "Checking Z-ENEMY miner"
if ! grep -q "1.10" ${NVOC_MINERS}/ZENEMYminer/1.10/version
then
  echo "Extracting Z-ENEMY miner 1.10 and making changes for CUDA-8"
  mkdir -p ${NVOC_MINERS}/ZENEMYminer/1.10/
  tar -xvJf ${NVOC_MINERS}/ZENEMYminer/z-enemy-1.10-cuda80.tar.xz -C ${NVOC_MINERS}/ZENEMYminer/1.10/ --strip 1
  chmod a+x  ${NVOC_MINERS}/ZENEMYminer/1.10/ccminer
  stop-if-needed "[Z]ENEMYminer"
  echo "Z-ENEMY miner for CUDA-8 updated"
  echo "Use 1.10 or recommended for ZENEMYminer_VERSION in bash"
  if [[ $CUDA_VER == "8" ]]
  then
    if [[ -L "${NVOC_MINERS}/ZENEMYminer/recommended" && -d "${NVOC_MINERS}/ZENEMYminer/recommended" ]]
    then
      rm ${NVOC_MINERS}/ZENEMYminer/recommended
    else
      rm -rf ${NVOC_MINERS}/ZENEMYminer/recommended
    fi
    ln -s "${NVOC_MINERS}/ZENEMYminer/1.10" "${NVOC_MINERS}/ZENEMYminer/recommended"
  fi
  restart-if-needed
else
  echo "Z-ENEMY miner for CUDA-8 is already up-to-date"
  echo "Use ZENEMYminer_VERSION 1.10 or recommended in bash"
fi

if ! grep -q "1.14" ${NVOC_MINERS}/ZENEMYminer/1.14/version
then
  echo "Extracting Z-ENEMY miner and making changes for CUDA-9.2"
  mkdir -p ${NVOC_MINERS}/ZENEMYminer/1.14/
  tar -xvJf ${NVOC_MINERS}/ZENEMYminer/z-enemy-1.14-cuda92.tar.xz -C ${NVOC_MINERS}/ZENEMYminer/1.14/ --strip 1
  chmod a+x  ${NVOC_MINERS}/ZENEMYminer/1.14/ccminer
  stop-if-needed "[Z]ENEMYminer"
  echo "Z-ENEMY miner for CUDA-9.2 updated"
  echo "Use latest or recommended or 1.14 for ZENEMYminer_VERSION in bash"
  if [[ $CUDA_VER == "9.2" ]]
  then
    if [[ -L "${NVOC_MINERS}/ZENEMYminer/latest" && -d "${NVOC_MINERS}/ZENEMYminer/latest" ]]
    then
      rm ${NVOC_MINERS}/ZENEMYminer/latest
    else
      rm -rf ${NVOC_MINERS}/ZENEMYminer/latest
    fi
    if [[ -L "${NVOC_MINERS}/ZENEMYminer/recommended" && -d "${NVOC_MINERS}/ZENEMYminer/recommended" ]]
    then
      rm ${NVOC_MINERS}/ZENEMYminer/recommended
    else
      rm -rf ${NVOC_MINERS}/ZENEMYminer/recommended
    fi
    ln -s "${NVOC_MINERS}/ZENEMYminer/1.14" "${NVOC_MINERS}/ZENEMYminer/recommended"
    ln -s "${NVOC_MINERS}/ZENEMYminer/1.14" "${NVOC_MINERS}/ZENEMYminer/latest"
  fi
  restart-if-needed
else
  echo "Z-ENEMY miner for CUDA-9.2 is already up-to-date"
  echo "Use ZENEMYminer_VERSION latest or recommended or 1.14 in bash"
fi

echo
echo

echo "Checking xmr-stak 2.4.4"
if ! grep -q "2.4.4" ${NVOC_MINERS}/xmr-stak/version
then
  echo "Extracting xmr-stak"
  mkdir -p ${NVOC_MINERS}/xmr-stak
  stop-if-needed "[x]mr-stak"
  tar -xvJf ${NVOC_MINERS}/xmr-stak/xmr-stak-2.4.4.tar.xz -C ${NVOC_MINERS}/xmr-stak/ --strip 1
  chmod a+x ${NVOC_MINERS}/xmr-stak/xmr-stak_miner
  restart-if-needed
else
  echo "xmr-stak is already up-to-date"
fi

echo

echo "Checking Silent Miner 1.1.0"
if ! grep -q "1.1.0" ${NVOC_MINERS}/SILENTminer/version
then
  echo "Extracting Silent Miner"
  mkdir -p ${NVOC_MINERS}/SILENTminer
  stop-if-needed "[S]ILENTminer"
  tar -xvJf ${NVOC_MINERS}/SILENTminer/SILENTminer.v1.1.0.tar.xz -C ${NVOC_MINERS}/SILENTminer/ --strip 1
  chmod a+x ${NVOC_MINERS}/SILENTminer/ccminer
  restart-if-needed
else
  echo "Silent Miner is already up-to-date"
fi

echo

echo "Checking Claymore v11.9"
if ! grep -q "11.9" ${NVOC_MINERS}/claymore/latest/version
then
  echo "Extracting Claymore"
  mkdir -p ${NVOC_MINERS}/claymore/latest/
  stop-if-needed "[e]thdcrminer64"
  tar -xvJf ${NVOC_MINERS}/claymore/Claymore-v11.9.tar.xz -C ${NVOC_MINERS}/claymore/latest/ --strip 1
  chmod a+x ${NVOC_MINERS}/claymore/latest/ethdcrminer64
  restart-if-needed
else
  echo "Claymore is already up-to-date"
fi

echo

echo "Checking SP Mod ccminer-1.8.2"
if ! grep -q "1.8.2" ${NVOC_MINERS}/SPccminer/version
then
  echo "Extracting SPccminer"
  mkdir -p ${NVOC_MINERS}/SPccminer/
  stop-if-needed "[S]Pccminer"
  tar -xvJf ${NVOC_MINERS}/SPccminer/SPccminer.tar.xz -C ${NVOC_MINERS}/SPccminer/ --strip 1
  chmod a+x ${NVOC_MINERS}/SPccminer/ccminer
  restart-if-needed
else
  echo "SPccminer is already up-to-date"
fi

echo

echo "Checking alexis ccminer"
if ! grep -q "1.0" ${NVOC_MINERS}/ASccminer/version
then
  echo "Extracting ASccminer"
  mkdir -p ${NVOC_MINERS}/ASccminer/
  stop-if-needed "[A]Sccminer"
  tar -xvJf ${NVOC_MINERS}/ASccminer/ASccminer.tar.xz -C ${NVOC_MINERS}/ASccminer/ --strip 1
  chmod a+x ${NVOC_MINERS}/ASccminer/ccminer
  restart-if-needed
else
  echo "ASccminer is already up-to-date"
fi

echo

echo "Checking Krnlx ccminer"
if ! grep -q "skunk-krnlx" ${NVOC_MINERS}/KXccminer/version
then
  echo "Extracting KXccminer"
  mkdir -p ${NVOC_MINERS}/KXccminer/
  stop-if-needed "[K]Xccminer"
  tar -xvJf ${NVOC_MINERS}/KXccminer/KXccminer.tar.xz -C ${NVOC_MINERS}/KXccminer/ --strip 1
  chmod a+x ${NVOC_MINERS}/KXccminer/ccminer
  restart-if-needed
else
  echo "KXccminer is already up-to-date"
fi

echo
echo

echo "Checking tpruvot ccminer"
if ! grep -q "2.2.5" ${NVOC_MINERS}/TPccminer/2.2.5/version
then
  echo "Extracting tpruvot ccminer 2.2.5 and making changes for CUDA-8"
  mkdir -p ${NVOC_MINERS}/TPccminer/2.2.5/
  tar -xvJf ${NVOC_MINERS}/TPccminer/TPccminer.tar.xz -C ${NVOC_MINERS}/TPccminer/2.2.5/ --strip 1
  chmod a+x  ${NVOC_MINERS}/TPccminer/2.2.5/ccminer
  stop-if-needed "[T]Pccminer"
  echo "tpruvot ccminer for CUDA-8 updated"
  echo "Use 2.2.5 or recommended for TPccminer_VERSION in 1bash"
  if [[ $CUDA_VER == "8" ]]
  then
    if [[ -L "${NVOC_MINERS}/TPccminer/recommended" && -d "${NVOC_MINERS}/TPccminer/recommended" ]]
    then
      rm ${NVOC_MINERS}/TPccminer/recommended
    else
      rm -rf ${NVOC_MINERS}/TPccminer/recommended
    fi
    ln -s "${NVOC_MINERS}/TPccminer/2.2.5" "${NVOC_MINERS}/TPccminer/recommended"
  fi
  restart-if-needed
else
  echo "tpruvot ccminer for CUDA-8 is already up-to-date"
  echo "Use TPccminer_VERSION 2.2.5 or recommended in 1bash"
fi

if ! grep -q "2.3" ${NVOC_MINERS}/TPccminer/2.3/version
then
  echo "Extracting tpruvot ccminer and making changes for CUDA-9.2"
  mkdir -p ${NVOC_MINERS}/TPccminer/2.3/
  tar -xvJf ${NVOC_MINERS}/TPccminer/TPccminer-2.3.tar.xz -C ${NVOC_MINERS}/TPccminer/2.3/ --strip 1
  chmod a+x  ${NVOC_MINERS}/TPccminer/2.3/ccminer
  stop-if-needed "[T]Pccminer"
  echo "tpruvot ccminer for CUDA-9.2 updated"
  echo "Use latest or recommended or 2.3 for TPccminer_VERSION in 1bash"
  if [[ $CUDA_VER == "9.2" ]]
  then
    if [[ -L "${NVOC_MINERS}/TPccminer/latest" && -d "${NVOC_MINERS}/TPccminer/latest" ]]
    then
      rm ${NVOC_MINERS}/TPccminer/latest
    else
      rm -rf ${NVOC_MINERS}/TPccminer/latest
    fi
    if [[ -L "${NVOC_MINERS}/TPccminer/recommended" && -d "${NVOC_MINERS}/TPccminer/recommended" ]]
    then
      rm ${NVOC_MINERS}/TPccminer/recommended
    else
      rm -rf ${NVOC_MINERS}/TPccminer/recommended
    fi
    ln -s "${NVOC_MINERS}/TPccminer/2.3" "${NVOC_MINERS}/TPccminer/recommended"
    ln -s "${NVOC_MINERS}/TPccminer/2.3" "${NVOC_MINERS}/TPccminer/latest"
  fi
  restart-if-needed
else
  echo "tpruvot ccminer for CUDA-9.2 is already up-to-date"
  echo "Use TPccminer_VERSION latest or recommended or 2.3 in 1bash"
fi

echo
echo

echo "Checking Klaust ccminer"
if ! grep -q "8.20" ${NVOC_MINERS}/KTccminer/8.20/version
then
  echo "Extracting Klaust ccminer 8.20 and making changes for CUDA-8"
  mkdir -p ${NVOC_MINERS}/KTccminer/8.20/
  tar -xvJf ${NVOC_MINERS}/KTccminer/KTccminer.tar.xz -C ${NVOC_MINERS}/KTccminer/8.20/ --strip 1
  chmod a+x  ${NVOC_MINERS}/KTccminer/8.20/ccminer
  stop-if-needed "[K]Tccminer"
  echo "Klaust ccminer for CUDA-8 updated"
  echo "Use 8.20 or recommended for KTccminer_VERSION in 1bash"
  if [[ $CUDA_VER == "8" ]]
  then
    if [[ -L "${NVOC_MINERS}/KTccminer/recommended" && -d "${NVOC_MINERS}/KTccminer/recommended" ]]
    then
      rm ${NVOC_MINERS}/KTccminer/recommended
    else
      rm -rf ${NVOC_MINERS}/KTccminer/recommended
    fi
    ln -s "${NVOC_MINERS}/KTccminer/8.20" "${NVOC_MINERS}/KTccminer/recommended"
  fi
  restart-if-needed
else
  echo "Klaust ccminer for CUDA-8 is already up-to-date"
  echo "Use KTccminer_VERSION 8.20 or recommended in 1bash"
fi

if ! grep -q "8.22" ${NVOC_MINERS}/KTccminer/8.22/version
then
  echo "Extracting Klaust ccminer and making changes for CUDA-9.2"
  mkdir -p ${NVOC_MINERS}/KTccminer/8.22/
  tar -xvJf ${NVOC_MINERS}/KTccminer/KTccminer-8.22.tar.xz -C ${NVOC_MINERS}/KTccminer/8.22/ --strip 1
  chmod a+x  ${NVOC_MINERS}/KTccminer/8.22/ccminer
  stop-if-needed "[K]Tccminer"
  echo "Klaust ccminer for CUDA-9.2 updated"
  echo "Use latest or recommended or 8.22 for KTccminer_VERSION in 1bash"
  if [[ $CUDA_VER == "9.2" ]]
  then
    if [[ -L "${NVOC_MINERS}/KTccminer/latest" && -d "${NVOC_MINERS}/KTccminer/latest" ]]
    then
      rm ${NVOC_MINERS}/KTccminer/latest
    else
      rm -rf ${NVOC_MINERS}/KTccminer/latest
    fi
    if [[ -L "${NVOC_MINERS}/KTccminer/recommended" && -d "${NVOC_MINERS}/KTccminer/recommended" ]]
    then
      rm ${NVOC_MINERS}/KTccminer/recommended
    else
      rm -rf ${NVOC_MINERS}/KTccminer/recommended
    fi
    ln -s "${NVOC_MINERS}/KTccminer/8.22" "${NVOC_MINERS}/KTccminer/recommended"
    ln -s "${NVOC_MINERS}/KTccminer/8.22" "${NVOC_MINERS}/KTccminer/latest"
  fi
  restart-if-needed
else
  echo "Klaust ccminer for CUDA-9.2 is already up-to-date"
  echo "Use KTccminer_VERSION latest or recommended or 8.22 in 1bash"
fi

echo
echo

echo "Checking Vertminer v1.0-stable.2 Release"
if ! grep -q "1.0.2" ${NVOC_MINERS}/vertminer/version
then
  echo "Extracting vertminer"
  mkdir -p ${NVOC_MINERS}/vertminer/
  stop-if-needed "[v]ertminer"
  tar -xvJf ${NVOC_MINERS}/vertminer/vertminer-nvidia-1.0-stable.2.tar.xz -C ${NVOC_MINERS}/vertminer/ --strip 1
  chmod a+x ${NVOC_MINERS}/vertminer/vertminer
  if [[ -e ${NVOC_MINERS}/vertminer/ccminer ]]
  then
    rm ${NVOC_MINERS}/vertminer/ccminer
  fi
  ln -s vertminer ${NVOC_MINERS}/vertminer/ccminer
  restart-if-needed
else
  echo "Vertminer is already up-to-date"
fi

echo

echo "Checking nanashi-ccminer-2.2-mod-r2"
if ! grep -q "2.2-mod-r2" ${NVOC_MINERS}/NAccminer/version
then
  echo "Extracting nanashi ccminer"
  mkdir -p ${NVOC_MINERS}/NAccminer/
  stop-if-needed "[N]Accminer"
  tar -xvJf ${NVOC_MINERS}/NAccminer/nanashi-ccminer-2.2-mod-r2.tar.xz -C ${NVOC_MINERS}/NAccminer/ --strip 1
  chmod a+x ${NVOC_MINERS}/NAccminer/ccminer
  restart-if-needed
else
  echo "nanashi-ccminer is already up-to-date"
fi

echo
echo

echo "Checking Ethminer"
if ! grep -q "0.14.0" ${NVOC_MINERS}/ethminer/0.14.0/version
then
  echo "Extracting Ethminer 0.14.0 and making changes for CUDA-8"
  mkdir -p ${NVOC_MINERS}/ethminer/0.14.0/
  tar -xvJf ${NVOC_MINERS}/ethminer/ethminer-0.14.0-Linux.tar.xz -C ${NVOC_MINERS}/ethminer/0.14.0/ --strip 1
  chmod a+x  ${NVOC_MINERS}/ethminer/0.14.0/ccminer
  stop-if-needed "[e]thminer"
  echo "Ethminer for CUDA-8 updated"
  echo "Use 0.14.0 or recommended for ethminer_VERSION in 1bash"
  if [[ $CUDA_VER == "8" ]]
  then
    if [[ -L "${NVOC_MINERS}/ethminer/recommended" && -d "${NVOC_MINERS}/ethminer/recommended" ]]
    then
      rm ${NVOC_MINERS}/ethminer/recommended
    else
      rm -rf ${NVOC_MINERS}/ethminer/recommended
    fi
    ln -s "${NVOC_MINERS}/ethminer/0.14.0" "${NVOC_MINERS}/ethminer/recommended"
  fi
  restart-if-needed
else
  echo "Ethminer for CUDA-8 is already up-to-date"
  echo "Use ethminer_VERSION 0.14.0 or recommended in 1bash"
fi

if ! grep -q "0.15.0" ${NVOC_MINERS}/ethminer/0.15.0/version
then
  echo "Extracting Ethminer and making changes for CUDA-9.2"
  mkdir -p ${NVOC_MINERS}/ethminer/0.15.0/
  tar -xvJf ${NVOC_MINERS}/ethminer/ethminer-0.15.0.tar.xz -C ${NVOC_MINERS}/ethminer/0.15.0/ --strip 1
  chmod a+x  ${NVOC_MINERS}/ethminer/0.15.0/ccminer
  stop-if-needed "[e]thminer"
  echo "Ethminer for CUDA-9.2 updated"
  echo "Use latest or recommended or 0.15.0 for ethminer_VERSION in 1bash"
  if [[ $CUDA_VER == "9.2" ]]
  then
    if [[ -L "${NVOC_MINERS}/ethminer/latest" && -d "${NVOC_MINERS}/ethminer/latest" ]]
    then
      rm ${NVOC_MINERS}/ethminer/latest
    else
      rm -rf ${NVOC_MINERS}/ethminer/latest
    fi
    if [[ -L "${NVOC_MINERS}/ethminer/recommended" && -d "${NVOC_MINERS}/ethminer/recommended" ]]
    then
      rm ${NVOC_MINERS}/ethminer/recommended
    else
      rm -rf ${NVOC_MINERS}/ethminer/recommended
    fi
    ln -s "${NVOC_MINERS}/ethminer/0.15.0" "${NVOC_MINERS}/ethminer/recommended"
    ln -s "${NVOC_MINERS}/ethminer/0.15.0" "${NVOC_MINERS}/ethminer/latest"
  fi
  restart-if-needed
else
  echo "Ethminer for CUDA-9.2 is already up-to-date"
  echo "Use ethminer_VERSION latest or recommended or 0.15.0 in 1bash"
fi

echo
echo

echo "Checking KTccminer_cryptonight"
if ! grep -q "2.06" ${NVOC_MINERS}/KTccminer_cryptonight/2.06/version
then
  echo "Extracting KTccminer_cryptonight 2.06 and making changes for CUDA-8"
  mkdir -p ${NVOC_MINERS}/KTccminer_cryptonight/2.06/
  tar -xvJf ${NVOC_MINERS}/KTccminer_cryptonight/KTccminer_cryptonight.tar.xz -C ${NVOC_MINERS}/KTccminer_cryptonight/2.06/ --strip 1
  chmod a+x  ${NVOC_MINERS}/KTccminer_cryptonight/2.06/ccminer
  stop-if-needed "[K]Tccminer_cryptonight"
  echo "KTccminer_cryptonight for CUDA-8 updated"
  echo "Use 2.06 or recommended for KTccminer_cryptonight_VERSION in 1bash"
  if [[ $CUDA_VER == "8" ]]
  then
    if [[ -L "${NVOC_MINERS}/KTccminer_cryptonight/recommended" && -d "${NVOC_MINERS}/KTccminer_cryptonight/recommended" ]]
    then
      rm ${NVOC_MINERS}/KTccminer_cryptonight/recommended
    else
      rm -rf ${NVOC_MINERS}/KTccminer_cryptonight/recommended
    fi
    ln -s "${NVOC_MINERS}/KTccminer_cryptonight/2.06" "${NVOC_MINERS}/KTccminer_cryptonight/recommended"
  fi
  restart-if-needed
else
  echo "KTccminer_cryptonight for CUDA-8 is already up-to-date"
  echo "Use KTccminer_cryptonight_VERSION 2.06 or recommended in 1bash"
fi

if ! grep -q "3.05" ${NVOC_MINERS}/KTccminer_cryptonight/3.05/version
then
  echo "Extracting KTccminer_cryptonight and making changes for CUDA-9.2"
  mkdir -p ${NVOC_MINERS}/KTccminer_cryptonight/3.05/
  tar -xvJf ${NVOC_MINERS}/KTccminer_cryptonight/KTccminer_cryptonight-3.05.tar.xz -C ${NVOC_MINERS}/KTccminer_cryptonight/3.05/ --strip 1
  chmod a+x  ${NVOC_MINERS}/KTccminer_cryptonight/3.05/ccminer
  stop-if-needed "[K]Tccminer_cryptonight"
  echo "KTccminer_cryptonight for CUDA-9.2 updated"
  echo "Use latest or recommended or 3.05 for KTccminer_cryptonight_VERSION in 1bash"
  if [[ $CUDA_VER == "9.2" ]]
  then
    if [[ -L "${NVOC_MINERS}/KTccminer_cryptonight/latest" && -d "${NVOC_MINERS}/KTccminer_cryptonight/latest" ]]
    then
      rm ${NVOC_MINERS}/KTccminer_cryptonight/latest
    else
      rm -rf ${NVOC_MINERS}/KTccminer_cryptonight/latest
    fi
    if [[ -L "${NVOC_MINERS}/KTccminer_cryptonight/recommended" && -d "${NVOC_MINERS}/KTccminer_cryptonight/recommended" ]]
    then
      rm ${NVOC_MINERS}/KTccminer_cryptonight/recommended
    else
      rm -rf ${NVOC_MINERS}/KTccminer_cryptonight/recommended
    fi
    ln -s "${NVOC_MINERS}/KTccminer_cryptonight/3.05" "${NVOC_MINERS}/KTccminer_cryptonight/recommended"
    ln -s "${NVOC_MINERS}/KTccminer_cryptonight/3.05" "${NVOC_MINERS}/KTccminer_cryptonight/latest"
  fi
  restart-if-needed
else
  echo "KTccminer_cryptonight for CUDA-9.2 is already up-to-date"
  echo "Use KTccminer_cryptonight_VERSION latest or recommended or 3.05 in 1bash"
fi

echo
echo

echo "Checking Equihash Bminer 9.1.0"
if ! grep -q "v9.1.0" ${NVOC_MINERS}/bminer/latest/version
then
  echo "Extracting Bminer"
  mkdir -p ${NVOC_MINERS}/bminer/latest/
  stop-if-needed "[b]miner"
  tar -xvJf ${NVOC_MINERS}/bminer/bminer-v9.1.0.tar.xz -C ${NVOC_MINERS}/bminer/latest/ --strip 1
  chmod a+x ${NVOC_MINERS}/bminer/latest/bminer
  restart-if-needed
else
  echo "Bminer is already up-to-date"
fi

echo

echo "Checking ANXccminer (git@cd6fab68823e247bb84dd1fa0448d5f75ec4917d)"
if ! grep -q "cd6fab68823e247bb84dd1fa0448d5f75ec4917d" ${NVOC_MINERS}/ANXccminer/version
then
  echo "Extracting ANXccminer"
  mkdir -p ${NVOC_MINERS}/ANXccminer/
  stop-if-needed "[A]NXccminer"
  tar -xvJf ${NVOC_MINERS}/ANXccminer/ANXccminer.tar.xz -C ${NVOC_MINERS}/ANXccminer/ --strip 1
  chmod a+x ${NVOC_MINERS}/ANXccminer/ccminer
  restart-if-needed
else
  echo "ANXccminer is already at up-to-date"
fi

echo

echo "Checking MSFT Tpruvot ccminer-2.2.5 (RVN)"
if ! grep -q "2.2.5-rvn" ${NVOC_MINERS}/MSFTccminer/version
then
  echo "Extracting MSFT Tpruvot ccminer"
  mkdir -p ${NVOC_MINERS}/MSFTccminer/
  stop-if-needed "[M]SFTccminer"
  tar -xvJf ${NVOC_MINERS}/MSFTccminer/MSFTccminer.tar.xz -C ${NVOC_MINERS}/MSFTccminer/ --strip 1
  chmod a+x ${NVOC_MINERS}/MSFTccminer/ccminer
  restart-if-needed
else
  echo "MSFTccminer is already up-to-date"
fi

echo

echo "Checking SUPRminer 1.5"
if ! grep -q "1.5" ${NVOC_MINERS}/SUPRminer/version
then
  echo "Extracting SUPRminer"
  mkdir -p ${NVOC_MINERS}/SUPRminer/
  stop-if-needed "[S]UPRminer"
  tar -xvJf ${NVOC_MINERS}/SUPRminer/SUPRminer-1.5.tar.xz -C ${NVOC_MINERS}/SUPRminer/ --strip 1
  chmod a+x ${NVOC_MINERS}/SUPRminer/ccminer
  restart-if-needed
else
  echo "SUPRminer is already up-to-date"
fi

echo

echo "Checking cpuminer-opt "
if ! grep -q "3.8.8.1" ${NVOC_MINERS}/cpuOPT/version
then
  echo "Extracting cpuminer"
  mkdir -p ${NVOC_MINERS}/cpuOPT/
  stop-if-needed "[c]puminer"
  tar -xvJf ${NVOC_MINERS}/cpuOPT/cpuOPT.tar.xz -C ${NVOC_MINERS}/cpuOPT/ --strip 1
  chmod a+x ${NVOC_MINERS}/cpuOPT/cpuminer
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

function compile-TPccminer {
  echo "Compiling tpruvot ccminer"
  echo " This could take a while ..."
  get-sources TPccminer
  cd ${NVOC_MINERS}/TPccminer/src
  bash ${NVOC_MINERS}/TPccminer/src/autogen.sh
  bash ${NVOC_MINERS}/TPccminer/src/configure
  bash ${NVOC_MINERS}/TPccminer/src/build.sh
  stop-if-needed "[T]Pccminer"
  cp ${NVOC_MINERS}/TPccminer/src/ccminer ${NVOC_MINERS}/TPccminer/ccminer
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
