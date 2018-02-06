#!/bin/bash

usrname=$1
/usr/sbin/userdel $usrname
/usr/bin/rm -fr /home/$usrname
/usr/bin/rm -fr /opt/uniway/workpath/sftp_root_dir/$usrname

/usr/bin/mysql -uroot -pJdwa*2003 << EOF

use fydbconf
delete from tsshkeys where username='$usrname';
flush privileges;

EOF

