#!/bin/bash
HOME='/home/pi'
echo `date`+"tmp get" >> /home/pi/shell/getTemp.log
sudo ${HOME}/getkion/Decision
if [ $? -eq 1 ]; then
	sudo ${HOME}/irc/sendir ${HOME}/irc/dan22.data 3 0
fi
