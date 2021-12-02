#!/bin/bash

warning="80"
critical="90"

cpu () {
cpuuse=$(cat /proc/loadavg | awk '{print $3}'|cut -f 1 -d ".")
    if [[ "${cpuuse}" > "${warning}" ]]; then
        echo "Server cpu warning"

    elif [[ "${cpuuse}" > "${critical}" ]]; then
        echo "Server cpu critical" 

    else
        echo "Server cpu usage is in under threshold"
    fi
}

ram () {
musage=$(free | awk '/Mem/{printf("RAM Usage: %.2f%\n"), $3/$2*100}' |  awk '{print $3}' | cut -d"." -f1)
    if [[ "${musage}" > "${warning}" ]]; then
        echo "Server ram warning"

    elif [[ "${musage}" > "${critical}" ]]; then
        echo "Server ram critical"

    else
        echo "Server ram usage is in under threshold"
    fi
}

hdd () {
result=$(df -kh |grep -v "Filesystem" | awk '{ print $5 }' | sed 's/%//g')
    for percent in $result; do
       if [[ "${percent}" > "${warning}" ]]; then
            echo "Server hdd warning"

        elif [[ "${percent}" > "${critical}" ]]; then
            echo "Server hdd critical"

        else
            echo "Server hdd usage is in under threshold"
       fi
    done
}

