#!/bin/bash

export APISERVER_PORT="38687" #35679

for i in $(seq 2 2)
do
    i_padded=$(printf "%02d" $i)
    # if i is 7, then rename i as "fs"
    if [ $i -eq 7 ]; then
        i="fs"
    fi
    ssh -NfR $APISERVER_PORT:localhost:$APISERVER_PORT ejfat-$i  
    scp -r $HOME/JIRIAF/demo/no-slurm/node-setup.sh ejfat-$i:~/
    # run node-setup.sh on each node
    ssh ejfat-$i "chmod +x node-setup.sh && ./node-setup.sh $i $(ping -c 1 ejfat-$i | awk -F'[()]' '/PING/{print $2}')" &
    sleep 3
done


wait