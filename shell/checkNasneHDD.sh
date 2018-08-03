#!/bin/bash

nasne1Addr="192.168.0.3"
nasne2Addr="192.168.0.4"
# この値で割ると単位がGBになる
GBhenkan=1073741824
nasne1Hdd=`curl -s "http://$nasne1Addr:64210/status/HDDInfoGet?id=0" | sed -r 's/^.*freeVolumeSize\"\:\s(.*),.*$/\1/'`
nasne1Hdd_soto=`curl -s "http://$nasne1Addr:64210/status/HDDInfoGet?id=1" | sed -r 's/^.*freeVolumeSize\"\:\s(.*),.*$/\1/'`
nasne2Hdd=`curl -s "http://$nasne2Addr:64210/status/HDDInfoGet?id=0" | sed -r 's/^.*freeVolumeSize\"\:\s(.*),.*$/\1/'`

nasne1Hdd=`expr $nasne1Hdd / $GBhenkan`
nasne2Hdd=`expr $nasne2Hdd / $GBhenkan`
hddMin=50
if [ ${nasne1Hdd} -lt $hddMin ] ; then
	echo "nasne1がやばいよ のこり${nasne1Hdd}GB"
fi

if [ ${nasne1Hdd_soto} -lt $hddMin ] ; then
	echo "nasne1の外付けHDDがやばいよ のこり${nasne1Hdd_soto}GB"
fi

if [ ${nasne2Hdd} -lt $hddMin ] ; then
	echo "nasne2がやばいよ のこり${nasne2Hdd}GB"
fi
