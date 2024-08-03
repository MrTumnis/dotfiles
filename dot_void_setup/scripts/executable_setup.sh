#!/bin/bash

# Remove defualt yaml
cd /home/thomas/winapps
rm compose.yaml
cd ~

# Move YAML configuration files
cd /home/thomas/.yaml 
cp winapps-compose.yaml ~/winapps/compose.yaml
cp Stirling-compose.yml ~/Stirling-PDF/compose.yml
cd ~ 

# Move the start script to the service directory and set permissions
sudo cp /home/thomas/.void_setup/services/start_stirling-pdf /etc/sv/start_stirling-pdf

sudo chmod +x /etc/sv/start_stirling-pdf/run
sudo chmod +x /etc/sv/start_stirling-pdf/finish

# Start services
sudo ln -s /etc/sv/start_stirling-pdf /var/service/
sudo ln -s /etc/sv/chronyd /var/service

cd /home/thomas/void-packages
git clone https://github.com/soanvig/brave-bin ./srcpkgs/brave-bin

# Bootstrap the void-packages binary
./xbps-src binary-bootstrap
./xbps-src pkg brave-bin
sudo xi brave-bin
cd ~

cd /home/thomas/Stirling-PDF 
sudo podman-compose up

cd /home/thomas/distrobox 
./install
cd ~

cd /home/thomas/Downloads
curl -O https://download.anydesk.com/linux/anydesk_6.3.2-1_amd64.deb
cd ~


curl -LO github.com/xdeb-org/xdeb/releases/latest/download/xdeb
sudo chmod 0744 xdeb
sudo mv xdeb /usr/local/bin/ 


# Append path to bash
#echo 'export PATH="home/thomas/vpm-posix/vpm:$PATH"' >> ~/.bash_profile
echo 'export XDEB_PKGROOT="${HOME}/.config/xdeb"' >> ~/.bash_profile

cd /home/thomas/Downloads
sudo xdeb -Sedf anydesk_6.3.2-1_amd64.deb
cd ~


# Reconfigure the Linux system
sudo xbps-reconfigure -f linux

sudo reboot
