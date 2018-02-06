#!/bin/sh

. /opt/uniway/script/GetHwaddr.sh

hwaddreth4=""
hwaddreth5=""
hwaddreth6=""
hwaddrman=""
hwaddreth8=""
hwaddreth9=""
hwaddreth10=""
hwaddreth7=""
hwaddreth0=""
hwaddreth1=""
hwaddreth2=""
hwaddreth3=""

if [ ! -d /sys/class/net/man ]; then
	hwaddreth4=$(GetHwaddr eth0)
	echo ${hwaddreth4} > /opt/uniway/mac/eth4/address
	hwaddreth5=$(GetHwaddr eth1)
	echo ${hwaddreth5} > /opt/uniway/mac/eth5/address
	hwaddreth6=$(GetHwaddr eth2)
	echo ${hwaddreth6} > /opt/uniway/mac/eth6/address
	hwaddrman=$(GetHwaddr eth3)
	echo ${hwaddrman} > /opt/uniway/mac/man/address
	hwaddreth8=$(GetHwaddr eth4)
	echo ${hwaddreth8} > /opt/uniway/mac/eth8/address
	hwaddreth9=$(GetHwaddr eth5)
	echo ${hwaddreth9} > /opt/uniway/mac/eth9/address
	hwaddreth10=$(GetHwaddr eth6)
	echo ${hwaddreth10} > /opt/uniway/mac/eth10/address
	hwaddreth7=$(GetHwaddr eth7)
	echo ${hwaddreth7} > /opt/uniway/mac/eth7/address
	hwaddreth0=$(GetHwaddr eth8)
	echo ${hwaddreth0} > /opt/uniway/mac/eth0/address
	hwaddreth1=$(GetHwaddr eth9)
	echo ${hwaddreth1} > /opt/uniway/mac/eth1/address
	hwaddreth2=$(GetHwaddr eth10)
	echo ${hwaddreth2} > /opt/uniway/mac/eth2/address
	hwaddreth3=$(GetHwaddr eth11)
	echo ${hwaddreth3} > /opt/uniway/mac/eth3/address
fi

