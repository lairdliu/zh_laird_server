#!/bin/sh

/opt/uniway/script/startinit

nFlag=`cat /opt/uniway/conf/isFirstStart`
echo $nFlag

/usr/bin/systemctl start rpcbind.service
/usr/bin/systemctl start rpc-statd.service 

if [ "x$nFlag" = "xTRUE" ]; then
	echo "isFirstStart:$nFlag"
	/opt/uniway/etc/uniway_init.sh
	echo FALSE > /opt/uniway/conf/isFirstStart
elif [ "x$nFlag" = "xFALSE" ]; then
	echo "isFirstStart:$nFlag"
	exit 0
else
	echo "Invalid parameter"
	exit 2;
fi

echo "$?"
