#!/bin/bash

GIT="/home/sergii/TEAMinternational_Learning/mysql"

install_mysql () {
    sudo apt install mysql-server -y
    sudo systemctl enable mysql.service   
}

stop_mysql () {
    sudo systemctl stop mysql.service
}

replace_configs () {
    cp $GIT/mysql.cnf           /etc/mysql/
    cp $GIT/mysqldump.cnf	/etc/mysql/
    cp $GIT/mysql.conf.d/*	/etc/mysql/mysql.conf.d/
    cp $GIT/conf.d/*		/etc/mysql/conf.d/

}

start_mysql () {
    sudo systemctl start mysql.service
}
