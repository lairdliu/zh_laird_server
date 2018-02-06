#!/bin/sh

nFlag=`cat /etc/hostname`
echo $nFlag

mkdir -p /root/sharememory

mv /etc/init.d/network /etc/init.d/network_org
cp /opt/uniway/conf/network /etc/init.d/network
chmod +x /etc/init.d/network

mv /etc/ssh/sshd_config /etc/ssh/sshd_config_org
cp /opt/uniway/conf/sshd_config /etc/ssh/sshd_config
systemctl restart sshd

install -p -m 0755 /root/.bash_profile /root/.bash_profile_org
cat /opt/uniway/conf/bash_profile >> /root/.bash_profile

install -p -m 0755 /etc/profile /etc/profile_org
echo "/usr/bin/echo 18446744073692774399 > /proc/sys/kernel/shmmax"  >> /etc/profile

echo -e "let &termencoding=&encoding\nset fileencodings=utf-8,gbk" > /root/.vimrc

install -p -m 0755 /etc/sysctl.conf /etc/sysctl.conf_org
cat /opt/uniway/conf/sysctl.conf >> /etc/sysctl.conf

#set xml
/bin/bash /opt/uniway/script/writeXml.sh 

#Setting environment variables
source /root/.bash_profile
source /etc/profile
/usr/sbin/sysctl -p > /dev/null 2>&1

echo $CODEROOTDIR

/usr/sbin/groupadd sftp

#install -p -m 0755 $CODEROOTDIR/conf/my.cnf /etc/my.cnf
install -p -m 0755 $CODEROOTDIR/conf/uniway.mysql.cnf /etc/my.cnf.d
#groupadd mysql
#useradd -g mysql mysql
systemctl enable mariadb
#systemctl stop mariadb
systemctl start mariadb
while [ ! -S /var/lib/mysql/mysql.sock ]; do 
    sleep 1
done
sh $CODEROOTDIR/etc/database_init.sh

tar -xzvf $CODEROOTDIR/clamav.tgz -C /usr/local
tar -xzvf $CODEROOTDIR/data.tgz -C /boot
mv -f $CODEROOTDIR/clamav.tgz $CODEROOTDIR/bacdir/init
mv -f $CODEROOTDIR/data.tgz $CODEROOTDIR/bacdir/init
cp -f /opt/jdwa/etc/sysSecurity.xml $CODEROOTDIR/bacdir/init

tar -xzvf $CODEROOTDIR/sendEmail-v1.56.tar.gz -C $CODEROOTDIR
mv -f $CODEROOTDIR/sendEmail-v1.56/sendEmail /usr/local/bin
rm -fr $CODEROOTDIR/sendEmail-v1.56.tar.gz
rm -fr $CODEROOTDIR/sendEmail-v1.56

cd $CODEROOTDIR
if [ "x$nFlag" = "xint" ]; then
	echo "inner:$nFlag"
	/usr/bin/mysql -uroot -pJdwa*2003 fydbconf < $CODEROOTDIR/conf/fydbconf_in.sql
	/usr/bin/mysql -uroot -pJdwa*2003 fydbaudit < $CODEROOTDIR/conf/fydbaudit_in.sql
	/usr/bin/mysql -uroot -pJdwa*2003 audit < $CODEROOTDIR/conf/audit.sql
	/usr/bin/mysql -uroot -pJdwa*2003 multilevel_inter < $CODEROOTDIR/conf/multilevel_inter.sql

    #mv $CODEROOTDIR/script/startfy_in $CODEROOTDIR/script/startfy
    #mv $CODEROOTDIR/script/stopfy_in $CODEROOTDIR/script/stopfy
    #mv $CODEROOTDIR/script/watchdog_in $CODEROOTDIR/script/watchdog
    #rm -f $CODEROOTDIR/script/startfy_out
    #rm -f $CODEROOTDIR/script/stopfy_out
    #rm -f $CODEROOTDIR/script/watchdog_out

    mv -f $CODEROOTDIR/conf/*_init.sql $CODEROOTDIR/bacdir/init

elif [ "x$nFlag" = "xext" ]; then
	echo "outer:$nFlag"
	/usr/bin/mysql -uroot -pJdwa*2003 fydbconf < $CODEROOTDIR/conf/fydbconf_out.sql
	/usr/bin/mysql -uroot -pJdwa*2003 fydbaudit < $CODEROOTDIR/conf/fydbaudit_out.sql
	/usr/bin/mysql -uroot -pJdwa*2003 audit < $CODEROOTDIR/conf/audit.sql
	/usr/bin/mysql -uroot -pJdwa*2003 multilevel_inter < $CODEROOTDIR/conf/multilevel_inter.sql

    #mv $CODEROOTDIR/script/startfy_out $CODEROOTDIR/script/startfy
    #mv $CODEROOTDIR/script/stopfy_out $CODEROOTDIR/script/stopfy
    #mv $CODEROOTDIR/script/watchdog_out $CODEROOTDIR/script/watchdog
    #rm -f $CODEROOTDIR/script/startfy_in
    #rm -f $CODEROOTDIR/script/stopfy_in
    #rm -f $CODEROOTDIR/script/watchdog_in

    mv -f $CODEROOTDIR/conf/*_init.sql $CODEROOTDIR/bacdir/init

elif [ "x$nFlag" = "xmid" ]; then
	echo "mid:$nFlag"
	/usr/bin/mysql -uroot -pJdwa*2003 fydbconf < $CODEROOTDIR/conf/fydbconf_in.sql
	/usr/bin/mysql -uroot -pJdwa*2003 fydbaudit < $CODEROOTDIR/conf/fydbaudit_in.sql
	/usr/bin/mysql -uroot -pJdwa*2003 audit < $CODEROOTDIR/conf/audit.sql
	/usr/bin/mysql -uroot -pJdwa*2003 multilevel_inter < $CODEROOTDIR/conf/multilevel_inter.sql

    #mv $CODEROOTDIR/script/startfy_in $CODEROOTDIR/script/startfy
    #mv $CODEROOTDIR/script/startfy_in $CODEROOTDIR/script/startfy
    #mv $CODEROOTDIR/script/stopfy_in $CODEROOTDIR/script/stopfy
    #mv $CODEROOTDIR/script/watchdog_in $CODEROOTDIR/script/watchdog
    #rm -f $CODEROOTDIR/script/startfy_out
    #rm -f $CODEROOTDIR/script/stopfy_out
    #rm -f $CODEROOTDIR/script/watchdog_out
	
    mv -f $CODEROOTDIR/conf/*_init.sql $CODEROOTDIR/bacdir/init

    echo "mid exit 1 success"
	exit 1;
else
	echo "Invalid parameter"
	exit 2;
fi

#Set crontab
sh $CODEROOTDIR/script/addcron

echo "Please reboot !"

echo "$?"

