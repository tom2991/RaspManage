#!/bin/bash
HOME='/home/pi/getkion/'
echo `date`+"tmp get" >> /home/pi/shell/getTemp.log
sudo ${HOME}GetMessage
