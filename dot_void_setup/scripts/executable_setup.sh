#!/bin/bash

# Copy YAML configuration files
cp ~/.yaml/winapps-compose.yaml ~/winapps/compose.yaml
cp ~/.yaml/Stirling-compose.yml ~/Stirling-PDF/compose.yml

# Copy the start script to the service directory and set permissions
sudo cp ~/.void_setup/services/start_stirling-pdf /etc/sv/start_stirling-pdf

sudo chmod +x /etc/sv/start_stirling-pdf/run
sudo chmod +x /etc/sv/start_stirling-pdf/finish

# Create a symbolic link to services
sudo ln -s /etc/sv/start_stirling-pdf /var/service/

# Bootstrap the void-packages binary
cd ~/void-packages
sudo ./xbps-src binary-bootstrap
cd ~

# Append the vpm path to .bash_profile
echo 'export PATH=$PATH:home/thomas/vpm-posix/vpm' | sudo tee -a ~/.bash_profile

# Reconfigure the Linux system
sudo xbps-reconfigure -f linux

# Reboot the system
sudo reboot

