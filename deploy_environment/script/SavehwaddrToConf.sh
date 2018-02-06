#!/bin/sh

. /opt/uniway/script/GetHwaddr.sh

devnamelist="eth0 eth1 eth2 eth3 eth4 eth5 eth6 eth7 eth8 eth9 eth10 man"

for devname in $devnamelist
do
	/sbin/ifdown $devname
done

for devname in $devnamelist
do

	confile="/etc/sysconfig/network-scripts/ifcfg-"
	flagO="FALSE"
	flagT="FALSE"
	
	hwaddreth=$(GetHwaddr_self $devname)
	#echo ${hwaddreth}
	
	while read line
	do
		#echo "line=$line"
		ret=`echo $line |awk -F= '{print $1}'`
		
		if [ "x$ret" == "xHWADDR" ]; then
			flagO="TRUE"
			#echo "ret=${ret}"
			ret=`echo $line |awk -F= '{print $2}'`
			#echo "ret=${ret}"
			
			if [ "x${ret}" != "x$hwaddreth" ]; then
				#echo "false"
				flagT="TRUE"
			#else
				#echo "true"
			fi	
		fi
	done < ${confile}$devname
	
	#echo "flagT=$flagT"
	if [ "x$flagT" == "xTRUE" ]; then
		#echo "DELTE"
		sed -i '/HWADDR/d' ${confile}$devname
		
		flagO="FALSE"
	fi
	
	#echo "flagO=$flagO -----"
	if [ "x$flagO" == "xFALSE" ]; then
		#echo "Add"
		echo HWADDR=${hwaddreth} >> ${confile}$devname
	fi
done

for devname in $devnamelist
do
	/sbin/ifup $devname
done
