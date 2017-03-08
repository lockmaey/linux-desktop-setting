#!/bin/bash

#sleep 20

DIR=~/.config/conky/

writeToKernel() {
    echo "<1>[Conky] $1" | sudo tee /dev/kmsg
}

launch() {
    RUN=`ps aux | grep conky | grep $1`

    if [ -z "$RUN" ]; then
        conky -c $DIR$1 &
        writeToKernel "started $1"
    else
        writeToKernel "$1 is already running"
    fi
}

main() {
    launch "systemrc"
    launch "cpurc" 
    launch "gpurc"
    launch "memoryrc"
    launch "diskrc"
    launch "networkrc"
    launch "clockrc"
    #launch "calrc"
    launch "emailrc"
    #conky -c ~/1d_accuweather_rss/.conkyrc_1d
    #launch "syslogrc"
    #conky -c ~/1_accuweather/.conkyrc_1_images_wind_2016
    
    # launch "cal9morc"

}

writeToKernel "Called by $USER@$HOSTNAME"
main
