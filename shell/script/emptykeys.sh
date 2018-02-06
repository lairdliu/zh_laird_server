#!/bin/sh

username=$1
pubkeys=$2


if [ ! -d /opt/uniway/workpath/sftp_root_dir/$username/.ssh ];then
	mkdir -p /opt/uniway/workpath/sftp_root_dir/$username/.ssh
	chown $username:sftp /opt/uniway/workpath/sftp_root_dir/$username/.ssh
fi

file=/opt/uniway/workpath/sftp_root_dir/$username/.ssh/authorized_keys

echo -n > $file

