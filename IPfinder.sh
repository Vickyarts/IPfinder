#!/bin/bash
#Copyright (C) 2020 Vickyarts
#This script requires zenity
#Contact me github
#colours
green='\e[0;32m'
lightgreen='\e[1;32m'
red='\e[1;31m'
yellow='\e[1;33m'
blue='\e[1;34m'
Escape="\033";
RedF="${Escape}[31m";
LighGreenF="${Escape}[92m"

#banner
function banner()
{
  echo ""                
  echo -e $red "                   ___ ____     __ _           _                                    "
  echo -e $red "                  |_ _|  _ \   / _(_)_ __   __| | ___ _ __                          "            
  echo -e $red "                   | || |_) | | |_| | '_ \ / _  |/ _ \ '__|                         "
  echo -e $blue "                  | ||  __/  |  _| | | | | (_| |  __/ |                           "
  echo -e $blue "                 |___|_|     |_| |_|_| |_|\__,_|\___|_|                           "
  echo ""
  echo -e $blue "                          Created by Vickyarts                                    "  
  echo ""
  echo ""      
}

# detect ctrl+c exiting
trap ctrl_c INT
ctrl_c() {
clear
echo -e $red"[*] (Ctrl + C ) Detected, Trying To Exit... "
sleep 1
start=$(zenity --question --title="☢ IPfinder ☢" --text "Do you like IPfinder?" --width 270 2> /dev/null)
if [ "$?" -eq "0" ];then
  gio open https://github.com/Vickyarts
  sleep 5
  exit 	
else
  clear
fi
echo ""
echo -e $yellow"[*] Thanks For Using IPfinder :)"
sleep 2
exit
}    

# check internet 
function checkinternetermux() 
{
  clear
  ping -c 1 google.com > /dev/null 2>&1
  if [[ "$?" != 0 ]]
  then
	  echo -e $yellow " Checking For Internet: ${RedF}FAILED"
	  echo
	  echo -e $red "This Script Needs An Active Internet Connection"
	  echo
	  echo -e $yellow " IPfinder Exit"
	  echo && sleep 2
	  exit
  else
	  echo -e $yellow " Checking For Internet: ${LighGreenF}CONNECTED"
	  sleep 3
          clear
  fi
}
function checkinternet() 
{
  clear
  ping -c 1 google.com > /dev/null 2>&1
  if [[ "$?" != 0 ]]
  then
	  echo -e $yellow " Checking For Internet: ${RedF}FAILED"
	  echo
	  echo -e $red "This Script Needs An Active Internet Connection"
	  echo
	  echo -e $yellow " IPfinder Exit"
	  echo && sleep 2
	  exit
  else
	  echo -e $yellow " Checking For Internet: ${LighGreenF}CONNECTED"
          sleep 2
  fi
}
#check if zenity is installed
function is_zenity()
{
  which zenity > /dev/null 2>&1
  if [ "$?" -eq "0" ]; then
    echo -e $green "[ ✔ ] Zenity............................${LighGreenF}[ found ]"
    which zenity > /dev/null 2>&1
    sleep 2
    clear
  else
    echo ""
    echo -e $red "[ X ] Zenity -> ${RedF}not found! "
    sleep 2
    echo -e $yellow "[ ! ] Installing Zenity "
    sleep 2
    echo -e $green ""
    sudo apt-get install zenity -y
    clear
    echo -e $blue "[ ✔ ] Done installing .... "
    which zenity > /dev/null 2>&1
    clear
  fi
}
function termuxinput()
{
  echo -e $yellow"Enter the website:"
  read website
}
function desinput()
{
  website=$(zenity --title="☢ SET WEBSITE ☢" --text "Enter the website:" --entry-text "www.google.com" --entry --width 300 2> /dev/null)
}
#Finding IP
function find_ip()
{
  ip=`ping -c 1 -q $website | egrep -o '[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}'`
}
function termuxoutput()
{
  echo -e $yellow "$website IP address = $ip"
  echo ""
  echo ""
  sleep 3
  exit
}
function desoutput()
{
  echo -e $yellow "$website IP address = $ip"
  zenity --info --title="Info" --text "IP Address Found!" --width=150
  echo ""
  echo ""
  echo ""
  sleep 5
  exit
}
function termuxnot_found()
{
  if [[ "$ip" = "" ]];
  then
    echo -e $red "IP address not found"
    echo ""
    echo ""
    sleep 2
    exit
  else
    termuxoutput
  fi
}
function desnot_found()
{
  if [[ "$ip" = "" ]];
  then
    echo -e $red "IP address not found"
    zenity --warning --text "IP not found" --width=150
    echo ""
    echo ""
    sleep 2
    exit
  else
    desoutput
  fi
}
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)
arch3=$(uname -a | grep -o 'aarch64' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] || [[ $arch3 == *'aarch64'* ]];
then
  checkinternetermux
  banner
  termuxinput
  find_ip
  clear
  sleep 2
  banner
  termuxnot_found
else
  checkinternet
  is_zenity
  banner
  desinput
  find_ip
  clear
  sleep 2
  banner
  desnot_found
fi
