#!/bin/bash

install_on_fedora() {
    sudo dnf install -y ansible
}

install_on_void() {
   sudo xbps-install -Suv && sudo xbps-install -S ansible
}

OS="$(uname -s)"
case "${OS}" in
    Linux*)
        if [ -f /etc/fedora-release ]; then
            install_on_fedora
        elif [ -f /etc/os-release ]; then
            install_on_void
        else
            echo "Unsupported Linux distribution"
            exit 1
	fi
	exit 1

	;;
esac


ansible-playbook ~/.void_setup/bootstrap/setup.yml --ask-become-pass

echo "Ansible installation complete."

