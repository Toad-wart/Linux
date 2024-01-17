apt-get install ntp -y
systemctl enable ntp || update-rc.d ntp defaults
systemctl start ntp || service ntp start || 
cp /usr/share/zoneinfo/Asia/Vladivostok /etc/localtime
