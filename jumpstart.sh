#!/bin/bash

# if [ $EUID -ne 0 ]
# 	then
# 		echo "Please run this as root!" 
# 		exit 1
# fi

echo "Installing dialog..."
pacaur -Syu dialog --needed
dialog --title 'Hello,' --msgbox 'This script is intended to increase the battery life of a linux computer.' 20 50
dialog --title 'WARNING!' --msgbox 'Ensure you are running Arch Linux with pacaur installed.' 20 50
dialog --msgbox 'This script will automatically set up your laptop to have a much higher battery life than before.' 20 50
clear
dialog --msgbox 'First we are going to install some needed programs.' 20 50
sleep 1s
dialog --msgbox  'TLP is a very popular battery life tool which makes optimization simple' 20 50
sleep 1s
pacaur -Sy tlp -y --needed
sleep 1s
sudo systemctl mask systemd-rfkill.service
sudo systemctl mask systemd-rfkill.socket
sudo systemctl enable tlp.service
sleep 1s
sudo systemctl start tlp.service
sleep 1s
clear
dialog --msgbox 'This will now automatically set up configurations...' 20 50
clear
sudo mv /etc/tlp.conf /etc/tlp.conf.old
sudo mv configs/tlp.conf /etc/tlp.conf
clear
dialog --msgbox 'TLP has been successfully configured!' 20 50
clear
dialog --msgbox 'Now its time to configure auto-cpufreq.' 20 50
dialog --msgbox 'Auto-cpufreq is a tool which governs, and configures your CPU to only use the ammount of power it actually needs on battery life.' 20 50
dialog --msgbox 'This will compile the program so it may take a while' 20 50
clear
runuser -l $USER -c 'pacaur -S auto-cpufreq --needed'
sleep 1s
sudo systemctl enable auto-cpufreq
sudo systemctl start autocpufreq
sleep 4s
clear
dialog --msgbox 'Renaming old auto-cpufreq config. This may return an error if there are no previous configurations.' 20 50
sudo mv /etc/auto-cpufreq.conf /etc/auto-cpufreq.conf.old
sleep 1s
sudo mv configs/auto-cpufreq.conf /etc/auto-cpufreq.conf
sleep 4s
clear
dialog --msgbox 'Battery life has been successfully configured!' 20 50
sleep 1s
chmod +x uninstall.sh
dialog --msgbox 'Run ./uninstall.sh to revert all changes.' 20 50
sleep 2s
clear
echo "A reboot is needed. Type 'y' to reboot now or 'n' to cancel."
read YN

if [ $YN = "y" ]
  then
    sudo reboot now
fi

done
