#!/bin/bash


IFS=$'\n'
for i in $(cat /etc/passwd | awk -F: '{print $1, $6}'); do

user=$(echo $i | awk '{print $1}')
group=$(groups ${user} | awk -F: '{print $2}' )
sudouser=$(getent group sudo | awk -F: '{print $4}')
homedir=$(echo $i | awk '{print $2}')
weight=$(if [[ -e ${homedir} ]] ; then du -s -h ${homedir} | awk '{print $1}' ; else echo "no data." ; fi)

echo " USR ${user}| SUDO ${sudouser}| Group${group}| HomeDIR ${homedir}| Size ${weight}"

done
