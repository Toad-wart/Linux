sudo apt install lsb-release software-properties-common apt-transport-https ca-certificates curl -y

curl -fSsL https://pkgs.zabbly.com/key.asc | gpg --dearmor | sudo tee /usr/share/keyrings/linux-zabbly.gpg > /dev/null

codename=$(lsb_release -sc) && echo deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/linux-zabbly.gpg] https://pkgs.zabbly.com/kernel/stable $codename main | sudo tee /etc/apt/sources.list.d/linux-zabbly.list

sudo apt update
sudo apt install linux-zabbly -y
