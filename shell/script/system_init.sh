#!/bin/sh

source /root/.bash_profile 

cd $CODEROOTDIR/bacdir/init

nFlag=`cat /etc/hostname`
echo $nFlag

#init database
#if [ "x$nFlag" = "xint" ]; then
    #echo "inner:$nFlag"
    #/usr/bin/mysql -uroot -pJdwa*2003 fydbconf < $CODEROOTDIR/bacdir/init/fydbconf_in_init.sql
    #/usr/bin/mysql -uroot -pJdwa*2003 fydbaudit < $CODEROOTDIR/bacdir/init/fydbaudit_in.sql
    #/usr/bin/mysql -uroot -pJdwa*2003 audit < $CODEROOTDIR/bacdir/init/audit.sql

#elif [ "x$nFlag" = "xext" ]; then
    #echo "outer:$nFlag"
    #/usr/bin/mysql -uroot -pJdwa*2003 fydbconf < $CODEROOTDIR/bacdir/init/fydbconf_out_init.sql
    #/usr/bin/mysql -uroot -pJdwa*2003 fydbaudit < $CODEROOTDIR/bacdir/init/fydbaudit_out.sql
    #/usr/bin/mysql -uroot -pJdwa*2003 audit < $CODEROOTDIR/bacdir/init/audit.sql

#elif [ "x$nFlag" = "xmid" ]; then
    #echo "mid:$nFlag"
    #/usr/bin/mysql -uroot -pJdwa*2003 fydbconf < $CODEROOTDIR/bacdir/init/fydbconf_in_init.sql
    #/usr/bin/mysql -uroot -pJdwa*2003 fydbaudit < $CODEROOTDIR/bacdir/init/fydbaudit_in.sql
    #/usr/bin/mysql -uroot -pJdwa*2003 audit < $CODEROOTDIR/bacdir/init/audit.sql

#else
    #echo "Invalid parameter"
    #exit 2;
#fi

tar -xzf $CODEROOTDIR/bacdir/init/data.tgz -C /boot
# \cp  -f is-enabled
\cp -f $CODEROOTDIR/bacdir/init/sysSecurity.xml /opt/jdwa/etc

echo "$?"

