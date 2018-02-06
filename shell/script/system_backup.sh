#!/bin/sh

source /root/.bash_profile 

cd $CODEROOTDIR/bacdir/backup

nFlag=`cat /etc/hostname`
echo $nFlag

filename=""

#backup database
if [ "x$nFlag" = "xint" ]; then
echo "inner:$nFlag"
    filename=`date +%Y%m%d%H%M%S`_int.backup
elif [ "x$nFlag" = "xext" ]; then
    echo "outer:$nFlag"
    filename=`date +%Y%m%d%H%M%S`_ext.backup
elif [ "x$nFlag" = "xmid" ]; then
    echo "mid:$nFlag"
    filename=`date +%Y%m%d%H%M%S`_mid.backup
else
    echo "Invalid parameter"
    exit 2;
fi

    /usr/bin/mysqldump -uroot -pJdwa*2003 fydbconf tchannelinfo -t --skip-add-locks > $CODEROOTDIR/bacdir/backup/tchannelinfo.sql
    /usr/bin/mysqldump -uroot -pJdwa*2003 fydbconf tcsconfig -t --skip-add-locks > $CODEROOTDIR/bacdir/backup/tcsconfig.sql
    /usr/bin/mysqldump -uroot -pJdwa*2003 fydbconf tfiletransuser -t --skip-add-locks > $CODEROOTDIR/bacdir/backup/tfiletransuser.sql
    /usr/bin/mysqldump -uroot -pJdwa*2003 fydbconf tfiletypemag -t --skip-add-locks > $CODEROOTDIR/bacdir/backup/tfiletypemag.sql
    /usr/bin/mysqldump -uroot -pJdwa*2003 fydbconf tfiletypepaper -t --skip-add-locks > $CODEROOTDIR/bacdir/backup/tfiletypepaper.sql
    /usr/bin/mysqldump -uroot -pJdwa*2003 fydbconf tfileupload -t --skip-add-locks > $CODEROOTDIR/bacdir/backup/tfileupload.sql
    /usr/bin/mysqldump -uroot -pJdwa*2003 fydbconf tsysconfig -t --skip-add-locks > $CODEROOTDIR/bacdir/backup/tsysconfig.sql
    /usr/bin/mysqldump -uroot -pJdwa*2003 fydbconf tearwaring -t --skip-add-locks > $CODEROOTDIR/bacdir/backup/tearwaring.sql
    /usr/bin/mysqldump -uroot -pJdwa*2003 fydbconf tsshkeys -t --skip-add-locks > $CODEROOTDIR/bacdir/backup/tsshkeys.sql

    /usr/bin/mysqldump -uroot -pJdwa*2003 multilevel_inter ip_confine -t --skip-add-locks > $CODEROOTDIR/bacdir/backup/ip_confine.sql

\cp -f  /opt/jdwa/etc/sysSecurity.xml $CODEROOTDIR/bacdir/backup

\cp -fr /boot/data .
tar -czf data.tgz data --remove-files

tar -czf - * --remove-files | openssl des3 -salt -k Jdwa*2003 -out ${filename}

echo "$?"

