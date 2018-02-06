#!/bin/sh

username=$1
pubkeys=$2


if [ ! -d /opt/uniway/workpath/sftp_root_dir/$username/.ssh ];then
	mkdir -p /opt/uniway/workpath/sftp_root_dir/$username/.ssh
fi

chmod 755 /opt/uniway/workpath/sftp_root_dir/$username/.ssh
chown $username:sftp /opt/uniway/workpath/sftp_root_dir/$username/.ssh

file=/opt/uniway/workpath/sftp_root_dir/$username/.ssh/authorized_keys

echo $2 >> $file

chown $username:sftp $file
chmod 600 $file

