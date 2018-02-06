#!/bin/bash

usrname=$1
pswd=$2

#/usr/sbin/groupadd sftp
/usr/sbin/useradd -g sftp -s /bin/false $usrname
#passwd $usrname
echo "$usrname:$pswd" | /usr/sbin/chpasswd

