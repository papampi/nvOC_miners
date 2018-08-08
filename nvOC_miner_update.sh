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

ANXccminer_8_ver="1.0"
ANXccminer_8_tarball="ANXccminer.tar.xz"
ASccminer_8_ver="1.0"
ASccminer_8_tarball="ASccminer.tar.xz"
ethminer_8_ver="0.14.0"
ethminer_8_tarball="ethminer-0.14.0-Linux.tar.xz"
KTccminer_8_ver="8.20"
KTccminer_8_tarball="KTccminer.tar.xz"
KTccminer_cryptonight_8_ver="2.06"
KTccminer_cryptonight_8_tarball="KTccminer-cryptonight.tar.xz"
KXccminer_8_ver="0.1"
KXccminer_8_tarball="KXccminer.tar.xz"
MSFTccminer_8_ver="2.2.5"
MSFTccminer_8_tarball="MSFTccminer.tar.xz"
NAccminer_8_ver="2.2"
NAccminer_8_tarball="nanashi-ccminer-2.2-mod-r2.tar.xz"
SILENTminer_8_ver="1.10"
SILENTminer_8_tarball="SILENTminer.v1.1.0.tar.xz"
SPccminer_8_ver="1.8.2"
SPccminer_8_tarball="SPccminer.tar.xz"
SUPRminer_8_ver="1.5"
SUPRminer_8_tarball="SUPRminer-1.5.tar.xz"
TPccminer_8_ver="2.2.5"
TPccminer_8_tarball="TPccminer.tar.xz"
vertminer_8_ver="1.0.2"
vertminer_8_tarball="vertminer-nvidia-1.0-stable.2.tar.xz"
xmr_stak_8_ver="2.4.4"
xmr_stak_8_tarball="xmr-stak-2.4.4.tar.xz"
ZENEMYminer_8_ver="1.10"
ZENEMYminer_8_tarball="z-enemy-1.10-cuda80.tar.xz"

ethminer_9_ver="ethminer-0.15.0-Linux.tar.xz"
ethminer_9_tarball="0.15.0"
KTccminer_9_ver="8.22"
KTccminer_9_tarball="KTccminer-8.22.tar.xz"
KTccminer_cryptonight_9_ver="3.05"
KTccminer_cryptonight_9_tarball="KTccminer-cryptonight-3.05.tar.xz"
TPccminer_9_ver="2.3"
TPccminer_9_tarball="TPccminer-2.3.tar.xz"
xmr_stak_9_ver="2.4.7"
xmr_stak_9_tarball="xmr-stak-2.4.7.tar.xz"
ZENEMYminer_9_ver="1.14"
ZENEMYminer_9_tarball="z-enemy-1.14-cuda92.tar.xz"

bminer_ver="9.1.0"
bminer_tarball="bminer-v9.1.0.tar.xz"
claymore_ver="11.9"
claymore_tarball="Claymore-v11.9.tar.xz"
dstm_ver="0.6.1"
dstm_tarball="DSTM_0.6.1.tar.xz"
ewbf_ver="3_4"
ewbf_tarball="0.3.4b.tar.xz"
z_ewbf_ver="0.5"
z_ewbf_tarball="z_ewbf_v0.5.tar.xz"
cpuOPT_ver="3.8.8.1"
cpuOPT_tarball="cpuOPT.tar.xz"



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
  if [[ $CUDA_VER == "8" ]]
  then
    SU_CMD="git -C ${NVOC_MINERS}/$1 submodule update --init --force --depth 1 src_cuda_8"
    if ! ${SU_CMD}
    then
      echo "Update from shallow clone failed, fetching old commits..."
      git -C "${NVOC_MINERS}/$1/src_cuda_8" fetch --unshallow
      if ! ${SU_CMD}
      then
        echo "Update from default branch failed, fetching other branches..."
        git -C "${NVOC_MINERS}/$1/src_cuda_8" remote set-branches origin '*'
        git -C "${NVOC_MINERS}/$1/src_cuda_8" fetch
        if ! ${SU_CMD}
        then
          echo "Unable to update submodule, can't find target commit."
        fi
      fi
    fi
  elif [[ $CUDA_VER == "9.2" ]]
  then
    SU_CMD="git -C ${NVOC_MINERS}/$1 submodule update --init --force --depth 1 src_cuda_9"
    if ! ${SU_CMD}
    then
      echo "Update from shallow clone failed, fetching old commits..."
      git -C "${NVOC_MINERS}/$1/src_cuda_9" fetch --unshallow
      if ! ${SU_CMD}
      then
        echo "Update from default branch failed, fetching other branches..."
        git -C "${NVOC_MINERS}/$1/src_cuda_9" remote set-branches origin '*'
        git -C "${NVOC_MINERS}/$1/src_cuda_9" fetch
        if ! ${SU_CMD}
        then
          echo "Unable to update submodule, can't find target commit."
        fi
      fi
    fi
  fi
}


echo "Checking EWBF Equihash miner "
if ! grep -q "0.3.4b" ${NVOC_MINERS}/ewbf/3_4/version
then
  echo "Extracting EWBF Equihash miner"
  mkdir -p ${NVOC_MINERS}/ewbf/{3_4,3_3}
  tar -xvJf ${NVOC_MINERS}/ewbf/${ewbf_tarball} -C ${NVOC_MINERS}/ewbf/3_4/ --strip 1
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
  if [[ -L "${NVOC_MINERS}/ewbf/recommended" && -d "${NVOC_MINERS}/ewbf/recommended" ]]
  then
    rm ${NVOC_MINERS}/ewbf/recommended
  else
    rm -rf ${NVOC_MINERS}/ewbf/recommended
  fi
  ln -s ${NVOC_MINERS}/ewbf/3_4 "${NVOC_MINERS}/ewbf/latest"
  ln -s ${NVOC_MINERS}/ewbf/3_4 "${NVOC_MINERS}/ewbf/recommended"
  restart-if-needed
else
  echo "EWBF Equihash miner is already up-to-date"
fi

echo

echo "Checking EWBF ZHASH miner "
if ! grep -q "${z_ewbf_ver}" ${NVOC_MINERS}/z_ewbf/${z_ewbf_ver}/version
then
  echo "Extracting EWBF ZHASH miner"
  mkdir -p ${NVOC_MINERS}/z_ewbf/${z_ewbf_ver}/
  stop-if-needed "[z]_ewbf"
  tar -xvJf ${NVOC_MINERS}/z_ewbf/${z_ewbf_tarball} -C ${NVOC_MINERS}/z_ewbf/${z_ewbf_ver}/ --strip 1
  chmod a+x ${NVOC_MINERS}/z_ewbf/${z_ewbf_ver}/miner
  if [[ -L "${NVOC_MINERS}/z_ewbf/recommended" && -d "${NVOC_MINERS}/z_ewbf/recommended" ]]
  then
    rm ${NVOC_MINERS}/z_ewbf/recommended
  else
    rm -rf ${NVOC_MINERS}/z_ewbf/recommended
  fi
  if [[ -L "${NVOC_MINERS}/z_ewbf/latest" && -d "${NVOC_MINERS}/z_ewbf/latest" ]]
  then
    rm ${NVOC_MINERS}/z_ewbf/latest
  else
    rm -rf ${NVOC_MINERS}/z_ewbf/latest
  fi
  ln -s "${NVOC_MINERS}/z_ewbf/${z_ewbf_ver}/" "${NVOC_MINERS}/z_ewbf/recommended"
  ln -s "${NVOC_MINERS}/z_ewbf/${z_ewbf_ver}/" "${NVOC_MINERS}/z_ewbf/latest"
  restart-if-needed
else
  echo "EWBF ZHASH miner is already up-to-date"
fi

echo

echo "Checking Equihash DSTM zm miner ${dstm_ver}"
if ! grep -q "${dstm_ver}" ${NVOC_MINERS}/dstm/${dstm_ver}/version
then
  echo "Extracting DSTM zm miner"
  mkdir -p ${NVOC_MINERS}/dstm/${dstm_ver}/
  stop-if-needed "[z]m_miner"
  tar -xvJf ${NVOC_MINERS}/dstm/${dstm_tarball} -C ${NVOC_MINERS}/dstm/${dstm_ver}/ --strip 1
  chmod a+x ${NVOC_MINERS}/dstm/${dstm_ver}/zm_miner
  if [[ -L "${NVOC_MINERS}/dstm/recommended" && -d "${NVOC_MINERS}/dstm/recommended" ]]
  then
    rm ${NVOC_MINERS}/dstm/recommended
  else
    rm -rf ${NVOC_MINERS}/dstm/recommended
  fi
  if [[ -L "${NVOC_MINERS}/dstm/latest" && -d "${NVOC_MINERS}/dstm/latest" ]]
  then
    rm ${NVOC_MINERS}/dstm/latest
  else
    rm -rf ${NVOC_MINERS}/dstm/latest
  fi
  ln -s "${NVOC_MINERS}/dstm/${dstm_ver}/" "${NVOC_MINERS}/dstm/recommended"
  ln -s "${NVOC_MINERS}/dstm/${dstm_ver}/" "${NVOC_MINERS}/dstm/latest"

  restart-if-needed
else
  echo "DSTM zm miner is already up-to-date"
fi

echo
echo

echo "Checking Z-ENEMY miner"
if ! grep -q "${ZENEMYminer_8_ver}" ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_8_ver}/version
then
  echo "Extracting Z-ENEMY miner ${ZENEMYminer_8_ver} and making changes for CUDA-8"
  mkdir -p ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_8_ver}/
  tar -xvJf ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_8_tarball} -C ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_8_ver}/ --strip 1
  chmod a+x  ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_8_ver}/ccminer
  stop-if-needed "[Z]ENEMYminer"
  echo "Z-ENEMY miner for CUDA-8 updated"
  echo "Use ${ZENEMYminer_8_ver} or recommended for ZENEMYminer_VERSION in bash"
  if [[ $CUDA_VER == "8" ]]
  then
    if [[ -L "${NVOC_MINERS}/ZENEMYminer/recommended" && -d "${NVOC_MINERS}/ZENEMYminer/recommended" ]]
    then
      rm ${NVOC_MINERS}/ZENEMYminer/recommended
    else
      rm -rf ${NVOC_MINERS}/ZENEMYminer/recommended
    fi
    ln -s "${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_8_ver}" "${NVOC_MINERS}/ZENEMYminer/recommended"
  fi
  restart-if-needed
else
  echo "Z-ENEMY miner for CUDA-8 is already up-to-date"
  echo "Use ZENEMYminer_VERSION ${ZENEMYminer_8_ver} or recommended in bash"
fi

if ! grep -q "${ZENEMYminer_9_ver}" ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_9_ver}/version
then
  echo "Extracting Z-ENEMY miner and making changes for CUDA-9.2"
  mkdir -p ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_9_ver}/
  tar -xvJf ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_9_tarball} -C ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_9_ver}/ --strip 1
  chmod a+x  ${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_9_ver}/ccminer
  stop-if-needed "[Z]ENEMYminer"
  echo "Z-ENEMY miner for CUDA-9.2 updated"
  echo "Use latest or recommended or ${ZENEMYminer_9_ver} for ZENEMYminer_VERSION in bash"
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
    ln -s "${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_9_ver}" "${NVOC_MINERS}/ZENEMYminer/recommended"
    ln -s "${NVOC_MINERS}/ZENEMYminer/${ZENEMYminer_9_ver}" "${NVOC_MINERS}/ZENEMYminer/latest"
  fi
  restart-if-needed
else
  echo "Z-ENEMY miner for CUDA-9.2 is already up-to-date"
  echo "Use ZENEMYminer_VERSION latest or recommended or ${ZENEMYminer_9_ver} in bash"
fi

echo
echo

echo "Checking xmr_stak 2.4.4"
if ! grep -q "2.4.4" ${NVOC_MINERS}/xmr_stak/2.4.4/version
then
  echo "Extracting xmr-stak"
  mkdir -p ${NVOC_MINERS}/xmr_stak/2.4.4/
  stop-if-needed "[x]mr-stak"
  tar -xvJf ${NVOC_MINERS}/xmr_stak/xmr-stak-2.4.4.tar.xz -C ${NVOC_MINERS}/xmr_stak/2.4.4/ --strip 1
  chmod a+x ${NVOC_MINERS}/xmr_stak/2.4.4/xmr_stak_miner
  if [[ -L "${NVOC_MINERS}/xmr_stak/recommended" && -d "${NVOC_MINERS}/xmr_stak/recommended" ]]
  then
    rm ${NVOC_MINERS}/xmr_stak/recommended
  else
    rm -rf ${NVOC_MINERS}/xmr_stak/recommended
  fi
  if [[ -L "${NVOC_MINERS}/xmr_stak/latest" && -d "${NVOC_MINERS}/xmr_stak/latest" ]]
  then
    rm ${NVOC_MINERS}/xmr_stak/latest
  else
    rm -rf ${NVOC_MINERS}/xmr_stak/latest
  fi
  ln -s "${NVOC_MINERS}/xmr_stak/2.4.4" "${NVOC_MINERS}/xmr_stak/recommended"
  ln -s "${NVOC_MINERS}/xmr_stak/2.4.4" "${NVOC_MINERS}/xmr_stak/latest"

  restart-if-needed
else
  echo "xmr-stak is already up-to-date"
fi

echo

echo "Checking Silent Miner ${SILENTminer_8_ver}"
if ! grep -q "${SILENTminer_8_ver}" ${NVOC_MINERS}/SILENTminer/${SILENTminer_8_ver}/version
then
  echo "Extracting Silent Miner"
  mkdir -p ${NVOC_MINERS}/SILENTminer/${SILENTminer_8_ver}
  stop-if-needed "[S]ILENTminer"
  tar -xvJf ${NVOC_MINERS}/SILENTminer/${SILENTminer_8_tarball} -C ${NVOC_MINERS}/SILENTminer/${SILENTminer_8_ver}/ --strip 1
  chmod a+x ${NVOC_MINERS}/SILENTminer/${SILENTminer_8_ver}/ccminer
  if [[ -L "${NVOC_MINERS}/SILENTminer/recommended" && -d "${NVOC_MINERS}/SILENTminer/recommended" ]]
  then
    rm ${NVOC_MINERS}/SILENTminer/recommended
  else
    rm -rf ${NVOC_MINERS}/SILENTminer/recommended
  fi
  if [[ -L "${NVOC_MINERS}/SILENTminer/latest" && -d "${NVOC_MINERS}/SILENTminer/latest" ]]
  then
    rm ${NVOC_MINERS}/SILENTminer/latest
  else
    rm -rf ${NVOC_MINERS}/SILENTminer/latest
  fi
  ln -s "${NVOC_MINERS}/SILENTminer/${SILENTminer_8_ver}" "${NVOC_MINERS}/SILENTminer/recommended"
  ln -s "${NVOC_MINERS}/SILENTminer/${SILENTminer_8_ver}" "${NVOC_MINERS}/SILENTminer/latest"
  restart-if-needed
else
  echo "Silent Miner is already up-to-date"
fi

echo

echo "Checking Claymore v${claymore_ver}"
if ! grep -q "${claymore_ver}" ${NVOC_MINERS}/claymore/${claymore_ver}/version
then
  echo "Extracting Claymore"
  mkdir -p ${NVOC_MINERS}/claymore/${claymore_ver}/
  stop-if-needed "[e]thdcrminer64"
  tar -xvJf ${NVOC_MINERS}/claymore/${claymore_tarball} -C ${NVOC_MINERS}/claymore/${claymore_ver}/ --strip 1
  chmod a+x ${NVOC_MINERS}/claymore/${claymore_ver}//ethdcrminer64
  if [[ -L "${NVOC_MINERS}/claymore/recommended" && -d "${NVOC_MINERS}/claymore/recommended" ]]
  then
    rm ${NVOC_MINERS}/claymore/recommended
  else
    rm -rf ${NVOC_MINERS}/claymore/recommended
  fi
  if [[ -L "${NVOC_MINERS}/claymore/latest" && -d "${NVOC_MINERS}/claymore/latest" ]]
  then
    rm ${NVOC_MINERS}/claymore/latest
  else
    rm -rf ${NVOC_MINERS}/claymore/latest
  fi
  ln -s "${NVOC_MINERS}/claymore/${claymore_ver}/" "${NVOC_MINERS}/claymore/recommended"
  ln -s "${NVOC_MINERS}/claymore/${claymore_ver}/" "${NVOC_MINERS}/claymore/latest"
  restart-if-needed
else
  echo "Claymore is already up-to-date"
fi

echo

echo "Checking SP Mod ccminer-${SPccminer_8_ver}"
if ! grep -q "${SPccminer_8_ver}" ${NVOC_MINERS}/SPccminer/${SPccminer_8_ver}/version
then
  echo "Extracting SPccminer"
  mkdir -p ${NVOC_MINERS}/SPccminer/${SPccminer_8_ver}/
  stop-if-needed "[S]Pccminer"
  tar -xvJf ${NVOC_MINERS}/SPccminer/${SPccminer_8_tarball} -C ${NVOC_MINERS}/SPccminer/${SPccminer_8_ver}/ --strip 1
  chmod a+x ${NVOC_MINERS}/SPccminer/${SPccminer_8_ver}/ccminer
  if [[ -L "${NVOC_MINERS}/SPccminer/recommended" && -d "${NVOC_MINERS}/SPccminer/recommended" ]]
  then
    rm ${NVOC_MINERS}/SPccminer/recommended
  else
    rm -rf ${NVOC_MINERS}/SPccminer/recommended
  fi
  if [[ -L "${NVOC_MINERS}/SPccminer/latest" && -d "${NVOC_MINERS}/SPccminer/latest" ]]
  then
    rm ${NVOC_MINERS}/SPccminer/latest
  else
    rm -rf ${NVOC_MINERS}/SPccminer/latest
  fi
  ln -s "${NVOC_MINERS}/SPccminer/${SPccminer_8_ver}" "${NVOC_MINERS}/SPccminer/recommended"
  ln -s "${NVOC_MINERS}/SPccminer/${SPccminer_8_ver}" "${NVOC_MINERS}/SPccminer/latest"
  restart-if-needed
else
  echo "SPccminer is already up-to-date"
fi

echo

echo "Checking alexis ccminer"
if ! grep -q "${ASccminer_8_ver}" ${NVOC_MINERS}/ASccminer/${ASccminer_8_ver}/version
then
  echo "Extracting ASccminer"
  mkdir -p ${NVOC_MINERS}/ASccminer/${ASccminer_8_ver}/
  stop-if-needed "[A]Sccminer"
  tar -xvJf ${NVOC_MINERS}/ASccminer/${ASccminer_8_tarball} -C ${NVOC_MINERS}/ASccminer/${ASccminer_8_ver}/ --strip 1
  chmod a+x ${NVOC_MINERS}/ASccminer/${ASccminer_8_ver}/ccminer
  if [[ -L "${NVOC_MINERS}/ASccminer/recommended" && -d "${NVOC_MINERS}/ASccminer/recommended" ]]
  then
    rm ${NVOC_MINERS}/ASccminer/recommended
  else
    rm -rf ${NVOC_MINERS}/ASccminer/recommended
  fi
  if [[ -L "${NVOC_MINERS}/ASccminer/latest" && -d "${NVOC_MINERS}/ASccminer/latest" ]]
  then
    rm ${NVOC_MINERS}/ASccminer/latest
  else
    rm -rf ${NVOC_MINERS}/ASccminer/latest
  fi
  ln -s "${NVOC_MINERS}/ASccminer/${ASccminer_8_ver}" "${NVOC_MINERS}/ASccminer/recommended"
  ln -s "${NVOC_MINERS}/ASccminer/${ASccminer_8_ver}" "${NVOC_MINERS}/ASccminer/latest"
  restart-if-needed
else
  echo "ASccminer is already up-to-date"
fi

echo

echo "Checking Krnlx ccminer"
if ! grep -q "${KXccminer_8_ver}" ${NVOC_MINERS}/KXccminer/${KXccminer_8_ver}/version
then
  echo "Extracting KXccminer"
  mkdir -p ${NVOC_MINERS}/KXccminer/${KXccminer_8_ver}/
  stop-if-needed "[K]Xccminer"
  tar -xvJf ${NVOC_MINERS}/KXccminer/${KXccminer_8_tarball} -C ${NVOC_MINERS}/KXccminer/${KXccminer_8_ver}/ --strip 1
  chmod a+x ${NVOC_MINERS}/KXccminer/${KXccminer_8_ver}/ccminer
  if [[ -L "${NVOC_MINERS}/KXccminer/recommended" && -d "${NVOC_MINERS}/KXccminer/recommended" ]]
  then
    rm ${NVOC_MINERS}/KXccminer/recommended
  else
    rm -rf ${NVOC_MINERS}/KXccminer/recommended
  fi
  if [[ -L "${NVOC_MINERS}/KXccminer/latest" && -d "${NVOC_MINERS}/KXccminer/latest" ]]
  then
    rm ${NVOC_MINERS}/KXccminer/latest
  else
    rm -rf ${NVOC_MINERS}/KXccminer/latest
  fi
  ln -s "${NVOC_MINERS}/KXccminer/${KXccminer_8_ver}" "${NVOC_MINERS}/KXccminer/recommended"
  ln -s "${NVOC_MINERS}/KXccminer/${KXccminer_8_ver}" "${NVOC_MINERS}/KXccminer/latest"
  restart-if-needed
else
  echo "KXccminer is already up-to-date"
fi

echo
echo

echo "Checking tpruvot ccminer"
if [[ $CUDA_VER == "8" ]]
then
  if ! grep -q "${TPccminer_8_ver}" ${NVOC_MINERS}/TPccminer/${TPccminer_8_ver}/version
  then
    echo "Extracting tpruvot ccminer ${TPccminer_8_ver} and making changes for CUDA-8"
    mkdir -p ${NVOC_MINERS}/TPccminer/${TPccminer_8_ver}/
    tar -xvJf ${NVOC_MINERS}/TPccminer/${TPccminer_8_tarball} -C ${NVOC_MINERS}/TPccminer/${TPccminer_8_ver}/ --strip 1
    chmod a+x  ${NVOC_MINERS}/TPccminer/${TPccminer_8_ver}/ccminer
    stop-if-needed "[T]Pccminer"
    echo "tpruvot ccminer for CUDA-8 updated"
    echo "Use ${TPccminer_8_ver} or recommended for TPccminer_VERSION in 1bash"
    if [[ -L "${NVOC_MINERS}/TPccminer/recommended" && -d "${NVOC_MINERS}/TPccminer/recommended" ]]
    then
      rm ${NVOC_MINERS}/TPccminer/recommended
    else
      rm -rf ${NVOC_MINERS}/TPccminer/recommended
    fi
    ln -s "${NVOC_MINERS}/TPccminer/${TPccminer_8_ver}" "${NVOC_MINERS}/TPccminer/recommended"
    restart-if-needed
  else
    echo "tpruvot ccminer for CUDA-8 is already up-to-date"
    echo "Use TPccminer_VERSION ${TPccminer_8_ver} or recommended in 1bash"
  fi
elif [[ $CUDA_VER == "9.2" ]]
then
  if ! grep -q "${TPccminer_9_ver}" ${NVOC_MINERS}/TPccminer/${TPccminer_9_ver}/version
  then
    echo "Extracting tpruvot ccminer and making changes for CUDA-9.2"
    mkdir -p ${NVOC_MINERS}/TPccminer/${TPccminer_9_ver}/
    tar -xvJf ${NVOC_MINERS}/TPccminer/${TPccminer_9_tarball} -C ${NVOC_MINERS}/TPccminer/${TPccminer_9_ver}/ --strip 1
    chmod a+x  ${NVOC_MINERS}/TPccminer/${TPccminer_9_ver}/ccminer
    stop-if-needed "[T]Pccminer"
    echo "tpruvot ccminer for CUDA-9.2 updated"
    echo "Use latest or recommended or ${TPccminer_9_ver} for TPccminer_VERSION in 1bash"
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
    ln -s "${NVOC_MINERS}/TPccminer/${TPccminer_9_ver}" "${NVOC_MINERS}/TPccminer/recommended"
    ln -s "${NVOC_MINERS}/TPccminer/${TPccminer_9_ver}" "${NVOC_MINERS}/TPccminer/latest"
  fi
  restart-if-needed
else
  echo "tpruvot ccminer for CUDA-9.2 is already up-to-date"
  echo "Use TPccminer_VERSION latest or recommended or ${TPccminer_9_ver} in 1bash"
fi

echo
echo

echo "Checking Klaust ccminer"
if ! grep -q "${KTccminer_8_ver}" ${NVOC_MINERS}/KTccminer/${KTccminer_8_ver}/version
then
  echo "Extracting Klaust ccminer ${KTccminer_8_ver} and making changes for CUDA-8"
  mkdir -p ${NVOC_MINERS}/KTccminer/${KTccminer_8_ver}/
  tar -xvJf ${NVOC_MINERS}/KTccminer/${KTccminer_8_tarball} -C ${NVOC_MINERS}/KTccminer/${KTccminer_8_ver}/ --strip 1
  chmod a+x  ${NVOC_MINERS}/KTccminer/${KTccminer_8_ver}/ccminer
  stop-if-needed "[K]Tccminer"
  echo "Klaust ccminer for CUDA-8 updated"
  echo "Use ${KTccminer_8_ver} or recommended for KTccminer_VERSION in 1bash"
  if [[ $CUDA_VER == "8" ]]
  then
    if [[ -L "${NVOC_MINERS}/KTccminer/recommended" && -d "${NVOC_MINERS}/KTccminer/recommended" ]]
    then
      rm ${NVOC_MINERS}/KTccminer/recommended
    else
      rm -rf ${NVOC_MINERS}/KTccminer/recommended
    fi
    ln -s "${NVOC_MINERS}/KTccminer/${KTccminer_8_ver}" "${NVOC_MINERS}/KTccminer/recommended"
  fi
  restart-if-needed
else
  echo "Klaust ccminer for CUDA-8 is already up-to-date"
  echo "Use KTccminer_VERSION ${KTccminer_8_ver} or recommended in 1bash"
fi

if ! grep -q "${KTccminer_9_ver}" ${NVOC_MINERS}/KTccminer/${KTccminer_9_ver}/version
then
  echo "Extracting Klaust ccminer and making changes for CUDA-9.2"
  mkdir -p ${NVOC_MINERS}/KTccminer/${KTccminer_9_ver}/
  tar -xvJf ${NVOC_MINERS}/KTccminer/${KTccminer_9_tarball} -C ${NVOC_MINERS}/KTccminer/${KTccminer_9_ver}/ --strip 1
  chmod a+x  ${NVOC_MINERS}/KTccminer/${KTccminer_9_ver}/ccminer
  stop-if-needed "[K]Tccminer"
  echo "Klaust ccminer for CUDA-9.2 updated"
  echo "Use latest or recommended or ${KTccminer_9_ver} for KTccminer_VERSION in 1bash"
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
    ln -s "${NVOC_MINERS}/KTccminer/${KTccminer_9_ver}" "${NVOC_MINERS}/KTccminer/recommended"
    ln -s "${NVOC_MINERS}/KTccminer/${KTccminer_9_ver}" "${NVOC_MINERS}/KTccminer/latest"
  fi
  restart-if-needed
else
  echo "Klaust ccminer for CUDA-9.2 is already up-to-date"
  echo "Use KTccminer_VERSION latest or recommended or ${KTccminer_9_ver} in 1bash"
fi

echo
echo

echo "Checking Vertminer ${vertminer_8_ver}"
if ! grep -q "${vertminer_8_ver}" ${NVOC_MINERS}/vertminer/${vertminer_8_ver}/version
then
  echo "Extracting vertminer"
  mkdir -p ${NVOC_MINERS}/vertminer/${vertminer_8_ver}/
  stop-if-needed "[v]ertminer"
  tar -xvJf ${NVOC_MINERS}/vertminer/${vertminer_8_tarball} -C ${NVOC_MINERS}/vertminer/${vertminer_8_ver}/ --strip 1
  chmod a+x ${NVOC_MINERS}/vertminer/${vertminer_8_ver}/vertminer
  if [[ -L "${NVOC_MINERS}/vertminer/recommended" && -d "${NVOC_MINERS}/vertminer/recommended" ]]
  then
    rm ${NVOC_MINERS}/vertminer/recommended
  else
    rm -rf ${NVOC_MINERS}/vertminer/recommended
  fi
  if [[ -L "${NVOC_MINERS}/vertminer/latest" && -d "${NVOC_MINERS}/vertminer/latest" ]]
  then
    rm ${NVOC_MINERS}/vertminer/latest
  else
    rm -rf ${NVOC_MINERS}/vertminer/latest
  fi
  ln -s "${NVOC_MINERS}/vertminer/${vertminer_8_ver}" "${NVOC_MINERS}/vertminer/recommended"
  ln -s "${NVOC_MINERS}/vertminer/${vertminer_8_ver}" "${NVOC_MINERS}/vertminer/latest"
  restart-if-needed
else
  echo "Vertminer is already up-to-date"
fi

echo

echo "Checking nanashi-ccminer "
if ! grep -q "${NAccminer_8_ver}" ${NVOC_MINERS}/NAccminer/${NAccminer_8_ver}/version
then
  echo "Extracting nanashi ccminer"
  mkdir -p ${NVOC_MINERS}/NAccminer/${NAccminer_8_ver}/
  stop-if-needed "[N]Accminer"
  tar -xvJf ${NVOC_MINERS}/NAccminer/${NAccminer_8_tarball} -C ${NVOC_MINERS}/NAccminer/${NAccminer_8_ver}/ --strip 1
  chmod a+x ${NVOC_MINERS}/NAccminer/${NAccminer_8_ver}/ccminer
  if [[ -L "${NVOC_MINERS}/NAccminer/recommended" && -d "${NVOC_MINERS}/NAccminer/recommended" ]]
  then
    rm ${NVOC_MINERS}/NAccminer/recommended
  else
    rm -rf ${NVOC_MINERS}/NAccminer/recommended
  fi
  if [[ -L "${NVOC_MINERS}/NAccminer/latest" && -d "${NVOC_MINERS}/NAccminer/latest" ]]
  then
    rm ${NVOC_MINERS}/NAccminer/latest
  else
    rm -rf ${NVOC_MINERS}/NAccminer/latest
  fi
  ln -s "${NVOC_MINERS}/NAccminer/${NAccminer_8_ver}" "${NVOC_MINERS}/NAccminer/latest"
  ln -s "${NVOC_MINERS}/NAccminer/${NAccminer_8_ver}" "${NVOC_MINERS}/NAccminer/latest"
  restart-if-needed

else
  echo "nanashi-ccminer is already up-to-date"
fi

echo
echo

echo "Checking Ethminer"
if ! grep -q "${ethminer_8_ver}" ${NVOC_MINERS}/ethminer/${ethminer_8_ver}/version
then
  echo "Extracting Ethminer ${ethminer_8_ver} and making changes for CUDA-8"
  mkdir -p ${NVOC_MINERS}/ethminer/${ethminer_8_ver}/
  tar -xvJf ${NVOC_MINERS}/ethminer/${ethminer_8_tarball} -C ${NVOC_MINERS}/ethminer/${ethminer_8_ver}/ --strip 1
  chmod a+x  ${NVOC_MINERS}/ethminer/${ethminer_8_ver}/ccminer
  stop-if-needed "[e]thminer"
  echo "Ethminer for CUDA-8 updated"
  echo "Use ${ethminer_8_ver} or recommended for ethminer_VERSION in 1bash"
  if [[ $CUDA_VER == "8" ]]
  then
    if [[ -L "${NVOC_MINERS}/ethminer/recommended" && -d "${NVOC_MINERS}/ethminer/recommended" ]]
    then
      rm ${NVOC_MINERS}/ethminer/recommended
    else
      rm -rf ${NVOC_MINERS}/ethminer/recommended
    fi
    ln -s "${NVOC_MINERS}/ethminer/${ethminer_8_ver}" "${NVOC_MINERS}/ethminer/recommended"
  fi
  restart-if-needed
else
  echo "Ethminer for CUDA-8 is already up-to-date"
  echo "Use ethminer_VERSION ${ethminer_8_ver} or recommended in 1bash"
fi

if ! grep -q "${ethminer_9_ver}" ${NVOC_MINERS}/ethminer/${ethminer_9_ver}/version
then
  echo "Extracting Ethminer and making changes for CUDA-9.2"
  mkdir -p ${NVOC_MINERS}/ethminer/${ethminer_9_ver}/
  tar -xvJf ${NVOC_MINERS}/ethminer/${ethminer_9_tarball} -C ${NVOC_MINERS}/ethminer/${ethminer_9_ver}/ --strip 1
  chmod a+x  ${NVOC_MINERS}/ethminer/${ethminer_9_ver}/ccminer
  stop-if-needed "[e]thminer"
  echo "Ethminer for CUDA-9.2 updated"
  echo "Use latest or recommended or ${ethminer_9_ver} for ethminer_VERSION in 1bash"
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
    ln -s "${NVOC_MINERS}/ethminer/${ethminer_9_ver}" "${NVOC_MINERS}/ethminer/recommended"
    ln -s "${NVOC_MINERS}/ethminer/${ethminer_9_ver}" "${NVOC_MINERS}/ethminer/latest"
  fi
  restart-if-needed
else
  echo "Ethminer for CUDA-9.2 is already up-to-date"
  echo "Use ethminer_VERSION latest or recommended or ${ethminer_9_ver} in 1bash"
fi

echo
echo

echo "Checking KTccminer_cryptonight"
if ! grep -q "${KTccminer_cryptonight_8_ver}" ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_8_ver}/version
then
  echo "Extracting KTccminer_cryptonight ${KTccminer_cryptonight_8_ver} and making changes for CUDA-8"
  mkdir -p ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_8_ver}/
  tar -xvJf ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_8_tarball} -C ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_8_ver}/ --strip 1
  chmod a+x  ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_8_ver}/ccminer
  stop-if-needed "[K]Tccminer_cryptonight"
  echo "KTccminer_cryptonight for CUDA-8 updated"
  echo "Use ${KTccminer_cryptonight_8_ver} or recommended for KTccminer_cryptonight_VERSION in 1bash"
  if [[ $CUDA_VER == "8" ]]
  then
    if [[ -L "${NVOC_MINERS}/KTccminer_cryptonight/recommended" && -d "${NVOC_MINERS}/KTccminer_cryptonight/recommended" ]]
    then
      rm ${NVOC_MINERS}/KTccminer_cryptonight/recommended
    else
      rm -rf ${NVOC_MINERS}/KTccminer_cryptonight/recommended
    fi
    ln -s "${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_8_ver}" "${NVOC_MINERS}/KTccminer_cryptonight/recommended"
  fi
  restart-if-needed
else
  echo "KTccminer_cryptonight for CUDA-8 is already up-to-date"
  echo "Use KTccminer_cryptonight_VERSION ${KTccminer_cryptonight_8_ver} or recommended in 1bash"
fi

if ! grep -q "${KTccminer_cryptonight_9_ver}" ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_9_ver}/version
then
  echo "Extracting KTccminer_cryptonight and making changes for CUDA-9.2"
  mkdir -p ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_9_ver}/
  tar -xvJf ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_9_tarball} -C ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_9_ver}/ --strip 1
  chmod a+x  ${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_9_ver}/ccminer
  stop-if-needed "[K]Tccminer_cryptonight"
  echo "KTccminer_cryptonight for CUDA-9.2 updated"
  echo "Use latest or recommended or ${KTccminer_cryptonight_9_ver} for KTccminer_cryptonight_VERSION in 1bash"
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
    ln -s "${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_9_ver}" "${NVOC_MINERS}/KTccminer_cryptonight/recommended"
    ln -s "${NVOC_MINERS}/KTccminer_cryptonight/${KTccminer_cryptonight_9_ver}" "${NVOC_MINERS}/KTccminer_cryptonight/latest"
  fi
  restart-if-needed
else
  echo "KTccminer_cryptonight for CUDA-9.2 is already up-to-date"
  echo "Use KTccminer_cryptonight_VERSION latest or recommended or ${KTccminer_cryptonight_9_ver} in 1bash"
fi

echo
echo

echo "Checking Equihash Bminer ${bminer_ver}"
if ! grep -q "v${bminer_ver}" ${NVOC_MINERS}/bminer/${bminer_ver}/version
then
  echo "Extracting Bminer"
  mkdir -p ${NVOC_MINERS}/bminer/${bminer_ver}/
  stop-if-needed "[b]miner"
  tar -xvJf ${NVOC_MINERS}/bminer/${bminer_tarball} -C ${NVOC_MINERS}/bminer/${bminer_ver}/ --strip 1
  chmod a+x ${NVOC_MINERS}/bminer/${bminer_ver}/bminer
  if [[ -L "${NVOC_MINERS}/bminer/latest" && -d "${NVOC_MINERS}/bminer/latest" ]]
  then
    rm ${NVOC_MINERS}/bminer/latest
  else
    rm -rf ${NVOC_MINERS}/bminer/latest
  fi
  if [[ -L "${NVOC_MINERS}/bminer/recommended" && -d "${NVOC_MINERS}/bminer/recommended" ]]
  then
    rm ${NVOC_MINERS}/bminer/recommended
  else
    rm -rf ${NVOC_MINERS}/bminer/recommended
  fi
  ln -s "${NVOC_MINERS}/bminer/${bminer_ver}" "${NVOC_MINERS}/bminer/recommended"
  ln -s "${NVOC_MINERS}/bminer/${bminer_ver}" "${NVOC_MINERS}/bminer/latest"
  restart-if-needed
else
  echo "Bminer is already up-to-date"
fi

echo

echo "Checking ANXccminer ${ANXccminer_8_ver}"
if ! grep -q "${ANXccminer_8_ver}" ${NVOC_MINERS}/ANXccminer/${ANXccminer_8_ver}/version
then
  echo "Extracting ANXccminer"
  mkdir -p ${NVOC_MINERS}/ANXccminer/${ANXccminer_8_ver}/
  stop-if-needed "[A]NXccminer"
  tar -xvJf ${NVOC_MINERS}/ANXccminer/${ANXccminer_8_tarball} -C ${NVOC_MINERS}/ANXccminer/${ANXccminer_8_ver}/ --strip 1
  chmod a+x ${NVOC_MINERS}/ANXccminer/${ANXccminer_8_ver}/ccminer
  if [[ -L "${NVOC_MINERS}/ANXccminer/latest" && -d "${NVOC_MINERS}/ANXccminer/latest" ]]
  then
    rm ${NVOC_MINERS}/ANXccminer/latest
  else
    rm -rf ${NVOC_MINERS}/ANXccminer/latest
  fi
  if [[ -L "${NVOC_MINERS}/ANXccminer/recommended" && -d "${NVOC_MINERS}/ANXccminer/recommended" ]]
  then
    rm ${NVOC_MINERS}/ANXccminer/recommended
  else
    rm -rf ${NVOC_MINERS}/ANXccminer/recommended
  fi
  ln -s "${NVOC_MINERS}/ANXccminer/${ANXccminer_8_ver}" "${NVOC_MINERS}/ANXccminer/recommended"
  ln -s "${NVOC_MINERS}/ANXccminer/${ANXccminer_8_ver}" "${NVOC_MINERS}/ANXccminer/latest"
  restart-if-needed
else
  echo "ANXccminer is already at up-to-date"
fi

echo

echo "Checking MSFT Tpruvot ccminer-${MSFTccminer_8_ver} (RVN)"
if ! grep -q "${MSFTccminer_8_ver}" ${NVOC_MINERS}/MSFTccminer/${MSFTccminer_8_ver}/version
then
  echo "Extracting MSFT Tpruvot ccminer"
  mkdir -p ${NVOC_MINERS}/MSFTccminer/${MSFTccminer_8_ver}/
  stop-if-needed "[M]SFTccminer"
  tar -xvJf ${NVOC_MINERS}/MSFTccminer/${MSFTccminer_8_tarball} -C ${NVOC_MINERS}/MSFTccminer/${MSFTccminer_8_ver}/ --strip 1
  chmod a+x ${NVOC_MINERS}/MSFTccminer/${MSFTccminer_8_ver}/ccminer
  if [[ -L "${NVOC_MINERS}/MSFTccminer/latest" && -d "${NVOC_MINERS}/MSFTccminer/latest" ]]
  then
    rm ${NVOC_MINERS}/MSFTccminer/latest
  else
    rm -rf ${NVOC_MINERS}/MSFTccminer/latest
  fi
  if [[ -L "${NVOC_MINERS}/MSFTccminer/recommended" && -d "${NVOC_MINERS}/MSFTccminer/recommended" ]]
  then
    rm ${NVOC_MINERS}/MSFTccminer/recommended
  else
    rm -rf ${NVOC_MINERS}/MSFTccminer/recommended
  fi
  ln -s "${NVOC_MINERS}/MSFTccminer/${MSFTccminer_8_ver}" "${NVOC_MINERS}/MSFTccminer/recommended"
  ln -s "${NVOC_MINERS}/MSFTccminer/${MSFTccminer_8_ver}" "${NVOC_MINERS}/MSFTccminer/latest"
  restart-if-needed
else
  echo "MSFTccminer is already up-to-date"
fi

echo

echo "Checking SUPRminer ${SUPRminer_8_ver}"
if ! grep -q "${SUPRminer_8_ver}" ${NVOC_MINERS}/SUPRminer/${SUPRminer_8_ver}/version
then
  echo "Extracting SUPRminer"
  mkdir -p ${NVOC_MINERS}/SUPRminer/${SUPRminer_8_ver}/
  stop-if-needed "[S]UPRminer"
  tar -xvJf ${NVOC_MINERS}/SUPRminer/${SUPRminer_8_tarball} -C ${NVOC_MINERS}/SUPRminer/${SUPRminer_8_ver}/ --strip 1
  chmod a+x ${NVOC_MINERS}/SUPRminer/${SUPRminer_8_ver}/ccminer
  if [[ -L "${NVOC_MINERS}/SUPRminer/latest" && -d "${NVOC_MINERS}/SUPRminer/latest" ]]
  then
    rm ${NVOC_MINERS}/SUPRminer/latest
  else
    rm -rf ${NVOC_MINERS}/SUPRminer/latest
  fi
  if [[ -L "${NVOC_MINERS}/SUPRminer/recommended" && -d "${NVOC_MINERS}/SUPRminer/recommended" ]]
  then
    rm ${NVOC_MINERS}/SUPRminer/recommended
  else
    rm -rf ${NVOC_MINERS}/SUPRminer/recommended
  fi
  ln -s "${NVOC_MINERS}/SUPRminer/${SUPRminer_8_ver}" "${NVOC_MINERS}/SUPRminer/recommended"
  ln -s "${NVOC_MINERS}/SUPRminer/${SUPRminer_8_ver}" "${NVOC_MINERS}/SUPRminer/latest"
  restart-if-needed
else
  echo "SUPRminer is already up-to-date"
fi

echo

echo "Checking cpuminer-opt "
if ! grep -q "${cpuOPT_ver}" ${NVOC_MINERS}/cpuOPT/${cpuOPT_ver}/version
then
  echo "Extracting cpuminer"
  mkdir -p ${NVOC_MINERS}/cpuOPT/${cpuOPT_ver}/
  stop-if-needed "[c]puminer"
  tar -xvJf ${NVOC_MINERS}/cpuOPT/${cpuOPT_tarball} -C ${NVOC_MINERS}/cpuOPT/${cpuOPT_ver}/ --strip 1
  chmod a+x ${NVOC_MINERS}/cpuOPT/${cpuOPT_ver}/cpuminer
  if [[ -L "${NVOC_MINERS}/cpuOPT/latest" && -d "${NVOC_MINERS}/cpuOPT/latest" ]]
  then
    rm ${NVOC_MINERS}/cpuOPT/latest
  else
    rm -rf ${NVOC_MINERS}/cpuOPT/latest
  fi
  if [[ -L "${NVOC_MINERS}/cpuOPT/recommended" && -d "${NVOC_MINERS}/cpuOPT/recommended" ]]
  then
    rm ${NVOC_MINERS}/cpuOPT/recommended
  else
    rm -rf ${NVOC_MINERS}/cpuOPT/recommended
  fi
  ln -s "${NVOC_MINERS}/cpuOPT/${cpuOPT_ver}" "${NVOC_MINERS}/cpuOPT/recommended"
  ln -s "${NVOC_MINERS}/cpuOPT/${cpuOPT_ver}" "${NVOC_MINERS}/cpuOPT/latest"
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
