#!/bin/bash

nasne1Addr="192.168.0.3"
nasne2Addr="192.168.0.4"
# この値で割ると単位がGBになる
GBhenkan=1073741824
nasne1Hdd=`curl -s "http://$nasne1Addr:64210/status/HDDInfoGet?id=0" | sed -r 's/^.*freeVolumeSize\"\:\s(.*),.*$/\1/'`
nasne1Hdd_soto=`curl -s "http://$nasne1Addr:64210/status/HDDInfoGet?id=1" | sed -r 's/^.*freeVolumeSize\"\:\s(.*),.*$/\1/'`
nasne2Hdd=`curl -s "http://$nasne2Addr:64210/status/HDDInfoGet?id=0" | sed -r 's/^.*freeVolumeSize\"\:\s(.*),.*$/\1/'`

nasne1Hdd=`expr $nasne1Hdd / $GBhenkan`
nasne1Hdd_soto=`expr $nasne1Hdd_soto / $GBhenkan`
nasne2Hdd=`expr $nasne2Hdd / $GBhenkan`
echo "nasne1 : ${nasne1Hdd}GB"
echo "nasne1 外付け : ${nasne1Hdd_soto}GB"
echo "nasne2 : ${nasne2Hdd}GB"
