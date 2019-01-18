#!/bin/bash
my_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Remove nvidia.txt if cards count changed
if [[ -f ~/nvidia.txt ]]
then
    if [ "$(grep -c "// gpu:" ~/nvidia.txt)" != "$(nvidia-smi -i 0 --query-gpu=count --format=csv,noheader,nounits)" ]
    then
        rm ~/nvidia.txt
    fi
fi
# Change verbosity to show hashrate in output log
if [[ -f ~/config.txt ]]
then
    if grep -q '"verbose_level" : 3' ~/config.txt
    then
        sed -i 's/"verbose_level" : 3/"verbose_level" : 4/g' ~/config.txt
    fi
fi

$my_path/xmr-stak $@