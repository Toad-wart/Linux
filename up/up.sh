#zabbix-agent up
wget -P /tmp/ https://repo.zabbix.com/zabbix/6.0/debian/pool/main/z/zabbix-release/zabbix-release_6.0-5+debian12_all.deb
dpkg -i /tmp/zabbix-release_6.0-5+debian12_all.deb

apt update

apt install zabbix-agent curl nano htop nmap sudo net-tools tmux open-vm-tools ncdu ntp mc unattended-upgrades -y

sudo dpkg-reconfigure --priority=low unattended-upgrades


sed -i "s/127.0.0.1/192.168.10.209/g" /etc/zabbix/zabbix_agentd.conf
sed -i "s/Hostname=/#Hostname=/g" /etc/zabbix/zabbix_agentd.conf
sed -i "s/# HostMetadata=/HostMetadata=OSLinux/g" /etc/zabbix/zabbix_agentd.conf
systemctl restart zabbix-agent || systemctl enable zabbix-agent

#ntp up
systemctl enable ntp || update-rc.d ntp defaults
systemctl start ntp || service ntp start 
cp /usr/share/zoneinfo/Asia/Vladivostok /etc/localtime

#pbis up
sh pbis-open-9.1.0.551.linux.x86_64.deb.sh
/opt/pbis/bin/domainjoin-cli join --ou OU=LINUX,OU=Srv,DC=SEVEROTORG,DC=LOCAL SEVEROTORG.LOCAL
/opt/pbis/bin/config RequireMembershipOf "SEVEROTORG.LOCAL\\Linux_administrators"
/opt/pbis/bin/config UserDomainPrefix SEVEROTORG.LOCAL
/opt/pbis/bin/config AssumeDefaultDomain true
/opt/pbis/bin/config LoginShellTemplate /bin/bash
/opt/pbis/bin/config HomeDirTemplate %H/%U
echo "%SEVEROTORG\\Linux_administrators ALL=NOPASSWD: ALL" >> /etc/sudoers

#zabbly up  WARNING!!! REBOOT !!!
#sh zabbly.sh
