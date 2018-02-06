#!/bin/bash

usrname=$1
pswd=$2
echo "$usrname:$pswd" | /usr/sbin/chpasswd

