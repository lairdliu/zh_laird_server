#!/bin/sh

source /root/.bash_profile 

cd $CODEROOTDIR/bacdir/rollback

#openssl des3 -d -k Jdwa*2003 -salt -in $1 | tar -xzf - -C $CODEROOTDIR/bacdir/rollback

#/usr/bin/mysql -uroot -pJdwa*2003 fydbconf < $CODEROOTDIR/bacdir/rollback/tchannelinfo.sql
#/usr/bin/mysql -uroot -pJdwa*2003 fydbconf < $CODEROOTDIR/bacdir/rollback/tcsconfig.sql
#/usr/bin/mysql -uroot -pJdwa*2003 fydbconf < $CODEROOTDIR/bacdir/rollback/tfiletransuser.sql
#/usr/bin/mysql -uroot -pJdwa*2003 fydbconf < $CODEROOTDIR/bacdir/rollback/tfiletypemag.sql
#/usr/bin/mysql -uroot -pJdwa*2003 fydbconf < $CODEROOTDIR/bacdir/rollback/tfiletypepaper.sql
#/usr/bin/mysql -uroot -pJdwa*2003 fydbconf < $CODEROOTDIR/bacdir/rollback/tfileupload.sql
#/usr/bin/mysql -uroot -pJdwa*2003 fydbconf < $CODEROOTDIR/bacdir/rollback/tsysconfig.sql

#/usr/bin/mysql -uroot -pJdwa*2003 multilevel_inter < $CODEROOTDIR/bacdir/rollback/ip_confine.sql

rm -f *.sql

mv -f $CODEROOTDIR/bacdir/rollback/sysSecurity.xml /opt/jdwa/etc

tar -xzf data.tgz -C /boot
rm -f data.tgz

echo "$?"

