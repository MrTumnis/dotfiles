#!/bin/bash

# Move YAML configuration files
cp ~/.yaml/winapps-compose.yaml ~/winapps/compose.yaml
cp ~/.yaml/Stirling-compose.yml ~/Stirling-PDF/compose.yml

# Move the start script to the service directory and set permissions
sudo cp ~/.void_setup/services/start_stirling-pdf /etc/sv/start_stirling-pdf

sudo chmod +x /etc/sv/start_stirling-pdf/run
sudo chmod +x /etc/sv/start_stirling-pdf/finish

# Create a symbolic link to services
sudo ln -s /etc/sv/start_stirling-pdf /var/service/

# Bootstrap the void-packages binary
cd ~/void-packages
sudo ./xbps-src binary-bootstrap
cd ~

cd ~/distrobox 
./install
cd ~

#curl -O https://download.anydesk.com/linux/anydesk_6.3.2-1_amd64.deb

curl -LO github.com/xdeb-org/xdeb/releases/latest/download/xdeb
sudo chmod 0744 xdeb

cd Downloads
./xdeb -Sedf anydesk_6.3.2-1_amd64.deb
cd ~

# Append path to bash
echo 'export PATH="home/thomas/vpm-posix/vpm:$PATH"' >> ~/.bash_profile
echo 'export XDEB_PKGROOT="${HOME}/.config/xdeb"' >> ~/.bash_profile


# Reconfigure the Linux system
sudo xbps-reconfigure -f linux

# Reboot the system
sudo reboot

