#!/bin/bash

# Remove defualt yaml
cd ~/winapps
rm compose.yaml
cd ~

# Move YAML configuration files
cp ~/.yaml/winapps-compose.yaml ~/winapps/compose.yaml
cp ~/.yaml/Stirling-compose.yml ~/Stirling-PDF/compose.yml

# Move the start script to the service directory and set permissions
sudo cp ~/.void_setup/services/start_stirling-pdf /etc/sv/start_stirling-pdf

sudo chmod +x /etc/sv/start_stirling-pdf/run
sudo chmod +x /etc/sv/start_stirling-pdf/finish

# Start services
sudo ln -s /etc/sv/start_stirling-pdf /var/service/
sudo ln -s /etc/sv/chronyd /var/service

cd ~/void-packages
git clone https://github.com/soanvig/brave-bin ./srcpkgs/brave-bin

# Bootstrap the void-packages binary
sudo ./xbps-src binary-bootstrap
sudo ./xbps-src pkg brave-bin
sudo xi brave-bin
cd ~


cd ~/distrobox 
./install
cd ~

cd Downloads
curl -O https://download.anydesk.com/linux/anydesk_6.3.2-1_amd64.deb
cd ~


curl -LO github.com/xdeb-org/xdeb/releases/latest/download/xdeb
sudo chmod 0744 xdeb
sudo mv xdeb /usr/local/bin/ 


# Append path to bash
#echo 'export PATH="home/thomas/vpm-posix/vpm:$PATH"' >> ~/.bash_profile
echo 'export XDEB_PKGROOT="${HOME}/.config/xdeb"' >> ~/.bash_profile

cd Downloads
sudo xdeb -Sedf anydesk_6.3.2-1_amd64.deb
cd ~


# Reconfigure the Linux system
sudo xbps-reconfigure -f linux

echo "Reboot system for booster to take effect"

