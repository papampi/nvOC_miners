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

LOLMINER_ver="0.43"
LOLMINER_compiled_tarball="lolMiner_v043_Lin64.tar.xz"

PhoenixMiner_ver="3.5d"
PhoenixMiner_compiled_tarball="PhoenixMiner_3.5d_Linux.tar.xz"

TPccminer_ver_8="2.2.5"
TPccminer_compiled_tarball_ver_8="TPccminer.tar.xz"
TPccminer_src_hash_ver_8="a81ab0f7a557a12a21d716dd03537bc8633fd176"

TPccminer_ver_9="2.3"
TPccminer_compiled_tarball_ver_9="TPccminer-2.3.tar.xz"
TPccminer_src_hash_ver_9="370684f7435d1256cbabef4410a57ed5bc705fdc"

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
    git -C "$1" submodule update --init --force --depth 1 $2
    chckt_cmd="git -C $1/$2 checkout --force $3"
  fi

  echo "Checking out from branch tip..."
  if ! eval ${chckt_cmd}
  then
    echo "Checkout from shallow clone failed, fetching old commits..."
    git -C "$1/$2" fetch --unshallow
    if ! eval ${chckt_cmd}
    then
      echo "Checkout from default branch failed, fetching other branches..."
      git -C "$1/$2" remote set-branches origin '*'
      git -C "$1/$2" fetch
      if ! eval ${chckt_cmd}
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
  ln -s "$1/$3" "$1/$2"
}

function pluggable-installer {
  pm="$1"
  pm_path=$(dirname "$1")
  pm_output="${pm_path}/nvoc-miner.json"

  if [[ -f "$pm" && -f "$pm_output" && $(md5sum "$pm" | cut -d ' ' -f1) == $(md5sum "$pm_output" | cut -d ' ' -f1) ]]
  then
    echo "$(jq -r .friendlyname "${pm_output}") $(jq -r .version "${pm_output}") for $(jq -r .install.recommended "${pm_output}") is already installed"
    return
  fi

  echo "Extracting $(jq -r .friendlyname "${pm}") $(jq -r .version "${pm}") for $(jq -r .install.recommended "${pm}")"
  mkdir -p "${pm_path}/"
  tar -xvJf "${pm_path}/$(jq -r .install.tarball "${pm}")" -C "${pm_path}" --strip 1
  IFS=','
  for ex in $(jq -r .install.executable "${pm}")
  do
    chmod a+x "${pm_path}/$ex"
  done
  unset IFS
  stop-if-needed "${pm_path}"
  if [[ $CUDA_VER == $(jq -r .install.recommended "${pm}") ]]
  then
    update-symlink "${pm_path}" ../recommended    
  fi
  if [[ $(jq -r .install.latest "${pm}") == true ]]
  then
    update-symlink "${pm_path}" ../latest    
  fi
  cp -f "$pm" "$pm_output"
  restart-if-needed

  echo "$(jq -r .friendlyname "${pm}") for $(jq -r .install.recommended "${pm}") updated"
}

function pluggable-compiler {
  pm="$1"
  pm_path=$(dirname "$1")
  pm_src="$(jq -r .compile.src_path "${pm}")"
  pm_src_hash="$(jq -r .compile.src_commit_hash "${pm}")"

  if [[ $pm_src == false ]]
  then
    echo "${pm}: nothing to compile for $(jq -r .friendlyname "${pm}")"
    return
  fi

  echo "Initializing sources submodule"
  if ! git submodule init "${pm_path}/${pm_src}"
  then
    echo "Registering new submodule in '${pm_path}'"
    git -C "${pm_path}" submodule add ${pm_src_repo} "${pm_src}"
  fi

  get-sources "${pm_path}" "${pm_src}" $pm_src_hash

  if [[ ! -d "${pm_path}/${pm_src}" ]]
  then
    echo "${pm}: can't compile $(jq -r .friendlyname "${pm}"), no sources available in '${pm_src}'"
    return
  fi

  pushd "${pm_path}/${pm_src}"

  echo "Compiling $(jq -r .friendlyname "${pm}")"
  echo " this will take a while ..."

  eval $(jq -r .compile.command "${pm}")

  # TODO: detect compilation failure

  stop-if-needed "${pm_path}"
  cp $(jq -r .compile.output "${pm}") "${pm_path}/"
  echo
  echo "Finished compiling $(jq -r .friendlyname "${pm}")"
  restart-if-needed

  popd
}

uver8="_ver_8"
uver9="_ver_9"
uver="_ver"
ucompiled8="_compiled_tarball_ver_8"
ucompiled9="_compiled_tarball_ver_9"
ucompiled="_compiled_tarball"

if [[ -d ${NVOC_MINERS}/helpers/miners ]]
then
  pushd ${NVOC_MINERS}/helpers/miners
  shipped_miners=$(find ./*/ -name .nvoc-miner.json -print | cut -d/ -f2 | sort -u )
  popd
else
  shipped_miners=
fi
unset IFS
for miner in $shipped_miners
do
  for _v in $uver8 $uver9 $uver
  do
    vminer=$miner$_v
    if [[ -f ${NVOC_MINERS}/helpers/miners/${miner}/${!vminer}/.nvoc-miner.json ]]
    then
      echo "Checking ${miner} version ${!vminer}"
      mkdir -p ${NVOC_MINERS}/${miner}/${!vminer}/
      cp ${NVOC_MINERS}/helpers/miners/${miner}/${!vminer}/.nvoc-miner.json  ${NVOC_MINERS}/${miner}/${!vminer}/
    fi
  done
done

IFS=','
for pm in $(find "${NVOC_MINERS}"/*/ -name .nvoc-miner.json  -not -path "${NVOC_MINERS}/helpers/*" -printf "%h/%f,")
do
  pluggable-installer "$pm"
done
unset IFS

builtin_miners="cpuOPT LOLMINER PhoenixMiner TPccminer"
for miner in $builtin_miners
do
  executable="ccminer"
  if [[ $miner == DSTM ]]
  then
    executable="miner"
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
    if [[ ! -d ${NVOC_MINERS}/${miner}/${!v8miner} || -z "$(ls -A ${NVOC_MINERS}/${miner}/recommended 2>/dev/null)" ]]
    then
      stop-if-needed "${miner}"
      mkdir -p ${NVOC_MINERS}/${miner}/${!v8miner}/
      tar -xvJf ${NVOC_MINERS}/${miner}/${!x8compiled_tarball} -C ${NVOC_MINERS}/$miner/${!v8miner}/ --strip 1
      chmod a+x ${NVOC_MINERS}/$miner/${!v8miner}/$executable
      update-symlink ${NVOC_MINERS}/${miner} recommended ${!v8miner}
      echo "${miner} updated to version ${!v8miner}"
      restart-if-needed
    else
      echo "${miner} already is on version ${!v8miner}"
    fi
  fi

  if [[ ${!v9miner} != "" ]]
  then
    echo "Checking ${miner} (cuda 9.2) version ${!v9miner}"
    if [[ ! -d ${NVOC_MINERS}/${miner}/${!v9miner} || -z "$(ls -A ${NVOC_MINERS}/${miner}/latest 2>/dev/null)" ]]
    then
      stop-if-needed "${miner}"
      mkdir -p ${NVOC_MINERS}/${miner}/${!v9miner}/
      tar -xvJf ${NVOC_MINERS}/${miner}/${!x9compiled_tarball} -C ${NVOC_MINERS}/$miner/${!v9miner}/ --strip 1
      chmod a+x ${NVOC_MINERS}/$miner/${!v9miner}/$executable
      if [[ $CUDA_VER == "9.2" ]]
      then
        update-symlink ${NVOC_MINERS}/${miner} recommended ${!v9miner}
      fi
      update-symlink ${NVOC_MINERS}/${miner} latest ${!v9miner}
      echo "${miner} updated to version ${!v9miner}"
      restart-if-needed
    else
      echo "${miner} already is on version ${!v9miner}"
    fi
  fi

  if [[ ${!vminer} != "" ]]
  then
    echo "Checking ${miner} version ${!vminer}"
    if [[ ! -d ${NVOC_MINERS}/${miner}/${!vminer} || -z "$(ls -A ${NVOC_MINERS}/${miner}/latest 2>/dev/null)" ]]
    then
      stop-if-needed "${miner}"
      mkdir -p ${NVOC_MINERS}/${miner}/${!vminer}/
      tar -xvJf ${NVOC_MINERS}/${miner}/${!xcompiled_tarball} -C ${NVOC_MINERS}/$miner/${!vminer}/ --strip 1
      chmod a+x ${NVOC_MINERS}/$miner/${!vminer}/$executable
      update-symlink ${NVOC_MINERS}/${miner} recommended ${!vminer}
      update-symlink ${NVOC_MINERS}/${miner} latest ${!vminer}
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
  pushd ~/Downloads
  wget -nv --no-check-certificate http://www.openssl.org/source/openssl-1.0.1e.tar.gz
  tar -xvzf openssl-1.0.1e.tar.gz
  cp /usr/local/include/openssl/bn.h ~/Downloads/openssl-1.0.1e/bn.h.backup
  sudo cp ~/Downloads/openssl-1.0.1e/crypto/bn/bn.h /usr/local/include/openssl/
  sleep 1
  echo
  echo "bn.h openssl fixed for compiling miners"
  echo
  popd
fi

if apt list --installed | grep -q "libcurl3/" 
then 
  sudo apt -y install cmake 
  sudo apt -y autoremove  
fi

echo "Miners to compile:"
echo
echo "A - Compile ALL opensouce miners"
echo "E - Exit and do not compile anything"
echo
echo "0 - TPccminer"
echo "1 - cpuminer"
echo
IFS=','
for pm_h in $(find "${NVOC_MINERS}"/*/ -name nvoc-miner.json -printf "%h,")
do
  pm_src="$(jq -r .compile.src_path "${pm_h}/nvoc-miner.json")"
  if [[ $pm_src != false ]]
  then
    pm_nv="$(realpath --relative-to="${NVOC_MINERS}" "${pm_h}")"
    echo -e "${pm_nv} \t- $(jq -r .friendlyname "${pm_h}/nvoc-miner.json")"

    # pick last found pm compiler as example
    pm_example=",${pm_nv}"
  fi
done
unset IFS
echo
echo "  (multiple comma separated values, example: 1,6,R${pm_example})"
echo
IFS=', '
read -p "Do your Choice: " -a array
for choice in "${array[@]}"; do
  case "$choice" in
    [Aa]* ) echo "ALL"
      compile-TPccminer
      echo
      echo
      compile-cpuminer
      echo
      echo
      IFS=','
      for pm in $(find "${NVOC_MINERS}"/*/ -name nvoc-miner.json -printf "%h/%f,")
      do
        pluggable-compiler "$pm"
        echo && echo
      done
      unset IFS
      ;;
    [0]* ) echo -e "$choice"
      compile-TPccminer
      ;;
    [1]* ) echo -e "$choice"
      compile-cpuminer
      ;;
    [Ee]* ) echo "exited by user"; break;;
    * ) echo -e "$choice"
      pms=$(find "${NVOC_MINERS}/$choice" -name nvoc-miner.json -printf "%h/%f,")
      if [[ $pms != "" ]]
      then
        IFS=','
        for pm in $pms
        do
          pluggable-compiler "$pm"
        done
        unset IFS
      else
        echo "Are you kidding me???"
      fi
      ;;
  esac
  
done
unset IFS
