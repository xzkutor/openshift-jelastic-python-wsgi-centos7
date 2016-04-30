#!/bin/bash

SED=`which sed`;
GREP=`which grep`;
DEFAULT_HTTPD_CONFIG="${OPENSHIFT_PYTHON_DIR}/versions/2.4/etc/conf/httpd_nolog.conf";
#TOTALMEM=`free -m | grep Mem | awk '{print $2}'`;
MAX_CLIENTS=$(grep -i "physical id" /proc/cpuinfo -c);
START_SERVERS=$(grep -i "physical id" /proc/cpuinfo -c);

backupConfig() {
    cp -f $1 $1.autobackup
}


applyOptimizations(){
        backupConfig $DEFAULT_HTTPD_CONFIG;
        $SED -i "/ServerLimit/c\ServerLimit     $MAX_CLIENTS" $DEFAULT_HTTPD_CONFIG;
        $SED -i "/MaxClients/c\MaxClients     $MAX_CLIENTS" $DEFAULT_HTTPD_CONFIG;
        $SED -i "/StartServers/c\StartServers     $START_SERVERS" $DEFAULT_HTTPD_CONFIG;
}

applyOptimizations
