#!/bin/bash

install_default_jdk() {
    sudo apt install default-jdk &> $log_path/tmp.log
if [ $? -eq 0 ];
    then
        info "nstall_default_jdk complete"
    else
        tail -n20 $log_path/tmp.log
        error "nstall_default_jdk failed"
    exit 1
fi
}

add_user () {
    sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat &> $log_path/tmp.log
if [ $? -eq 0 ];
    then
        info "add_user complete"
    else
        tail -n20 $log_path/tmp.log
        error "add_user failed"
    exit 1
fi
}

get_tomcat () {
    cd /tmp
    wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.0.20/bin/apache-tomcat-8.0.20.zip &> $log_path/tmp.log
if [ $? -eq 0 ];
    then
        info "get_tomcat complete"
    else
        tail -n20 $log_path/tmp.log
        error "get_tomcat failed"
    exit 1
fi
}

unzip_tomcat () {
    unzip apache-tomcat-8.0.20.zip &> $log_path/tmp.log
if [ $? -eq 0 ];
    then
        info "unzip_tomcat complete"
    else
        tail -n20 $log_path/tmp.log
        error "unzip_tomcat failed"
    exit 1
fi
}

move_tomcat () {
    sudo mkdir -p /opt/tomcat
    sudo mv apache-tomcat-8.0.20/*  /opt/tomcat/ &> $log_path/tmp.log
if [ $? -eq 0 ];
    then
        info "move_tomcat complete"
    else
        tail -n20 $log_path/tmp.log
        error "move_tomcat failed"
    exit 1
fi
}

hard_link () {
    sudo ln -s /opt/tomcat/apache-tomcat-8.0.20 /opt/tomcat/latest &> $log_path/tmp.log
if [ $? -eq 0 ];
    then
        info "hard_link complete"
    else
        tail -n20 $log_path/tmp.log
        error "hard_link failed"
    exit 1
fi
}

add_owner () {
    sudo chown -R tomcat.tomcat /opt/tomcat &> $log_path/tmp.log
if [ $? -eq 0 ];
    then
        info "add_owner complete"
    else
        tail -n20 $log_path/tmp.log
        error "add_owner failed"
    exit 1
fi
}

add_permission () {
    sudo sh -c 'chmod +x /opt/tomcat/latest/bin/*.sh' &> $log_path/tmp.log
if [ $? -eq 0 ];
    then
        info "add_permission complete"
    else
        tail -n20 $log_path/tmp.log
        error "add_permission failed"
    exit 1
fi
}

add_service () {
    cat << EOF > /etc/systemd/system/tomcat.service &> $log_path/tmp.log
[Unit]
Description=Tomcat 8.0.20 servlet container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/default-java"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom"

Environment="CATALINA_BASE=/opt/tomcat/latest"
Environment="CATALINA_HOME=/opt/tomcat/latest"
Environment="CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/opt/tomcat/latest/bin/startup.sh
ExecStop=/opt/tomcat/latest/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
EOF
if [ $? -eq 0 ];
    then
        info "add_service complete"
    else
        tail -n20 $log_path/tmp.log
        error "add_service failed"
    exit 1
fi
}

daemon_reload () {
sudo systemctl daemon-reload
if [ $? -eq 0 ];
    then
        info "add_service complete"
    else
        tail -n20 $log_path/tmp.log
        error "add_service failed"
    exit 1
fi
}

start_tomcat () {
sudo systemctl start tomcat
if [ $? -eq 0 ];
    then
        info "start_tomcat complete"
    else
        tail -n20 $log_path/tmp.log
        error "start_tomcat failed"
    exit 1
fi
}

stop_tomcat () {
sudo systemctl stop tomcat
if [ $? -eq 0 ];
    then
        info "stop_tomcat complete"
    else
        tail -n20 $log_path/tmp.log
        error "stop_tomcat failed"
    exit 1
fi
}

enable_tomcat () {
sudo systemctl enable tomcat
if [ $? -eq 0 ];
    then
        info "enable_tomcat complete"
    else
        tail -n20 $log_path/tmp.log
        error "enable_tomcat failed"
    exit 1
fi
}

allow_8080 () {
sudo ufw allow 8080
if [ $? -eq 0 ];
    then
        info "allow_8080 complete"
    else
        tail -n20 $log_path/tmp.log
        error "allow_8080 failed"
    exit 1
fi
}

main. () {

install_default_jdk

add_user

get_tomcat

unzip_tomcat

move_tomcat

hard_link

add_owner

add_permission

add_service

daemon_reload

start_tomcat
sleep 5

stop_tomcat

enable_tomcat

allow_8080
}

main
