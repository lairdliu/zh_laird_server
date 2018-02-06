
usrname=$1
taskname=$2

/usr/bin/mkdir -p /opt/uniway/workpath/sftp_root_dir
/usr/bin/chmod 755 /opt/uniway/workpath/sftp_root_dir

/usr/bin/mkdir -p $taskname
/usr/bin/chmod 755 $taskname
/usr/sbin/usermod -d $taskname $usrname 
/usr/bin/chown root:sftp $taskname  
/usr/bin/chmod 755 $taskname  

dir=$taskname/tmp
/usr/bin/mkdir -p $dir
/usr/bin/chmod 755 $dir
/usr/bin/chown $usrname:sftp $dir

