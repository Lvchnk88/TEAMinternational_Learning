#!/bin/bash

install_mysql () {
    sudo apt install mysql-server -y
    if [ $? -eq 0 ];
      then
            info "install mysql-server complete"
      else
            tail -n20 $log_path/tmp.log
            error "install mysql-server failed"
      exit 1
    fi

    sudo systemctl enable mysql.service
    if [ $? -eq 0 ];
      then
            info "enable mysql.service complete"
      else
            tail -n20 $log_path/tmp.log
            error "enable mysql.service failed"
      exit 1
    fi
}

stop_mysql () {
    sudo systemctl stop mysql.service
    if [ $? -eq 0 ];
      then
            info "stop mysql complete"
      else
            tail -n20 $log_path/tmp.log
            error "stop mysql failed"
      exit 1
    fi
}

replace_configs () {
    cp /home/sergii/TEAMinternational_Learning/mysql/mysql.cnf       /etc/mysql/
    if [ $? -eq 0 ];
      then
            info "replace mysql.cnf complete"
      else
            tail -n20 $log_path/tmp.log
            error "replace mysql.cnf failed"
      exit 1
    fi
    cp /home/sergii/TEAMinternational_Learning/mysql/mysqldump.cnf   /etc/mysql/
    if [ $? -eq 0 ];
      then
            info "replace mysqldump.cnf complete"
      else
            tail -n20 $log_path/tmp.log
            error "replace mysqldump.cnf failed"
      exit 1
    fi
    cp /home/sergii/TEAMinternational_Learning/mysql/mysql.conf.d/*  /etc/mysql/mysql.conf.d/
    if [ $? -eq 0 ];
      then
            info "replace mysql.conf.d/ complete"
      else
            tail -n20 $log_path/tmp.log
            error "replace mysql.conf.d/ failed"
      exit 1
    fi
    cp /home/sergii/TEAMinternational_Learning/mysql/conf.d/*        /etc/mysql/conf.d/
    if [ $? -eq 0 ];
      then
            info "replace conf.d/ complete"
      else
            tail -n20 $log_path/tmp.log
            error "replace conf.d/ failed"
      exit 1
    fi

}

start_mysql () {
    sudo systemctl start mysql.service
    if [ $? -eq 0 ];
      then
            info "start mysql.service complete"
      else
            tail -n20 $log_path/tmp.log
            error "start mysql.service failed"
      exit 1
    fi
}


main () {

install_mysql
sleep 5

stop_mysql
sleep 5

replace_configs
sleep 5

start_mysql

}

main
