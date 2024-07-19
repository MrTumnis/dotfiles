#!/bin/bash

install_on_fedora() {
    sudo dnf install -y ansible
}

install_on_void() {
    sudo xbps-install -Suv
    sudo xbps-install -S ansible
}

install_on_mac() {
    homebrew install ansible
}

OS="$(uname -s)"
case "${OS}" in
    Linux*)
        if [ -f /etc/fedora-release ]; then
            install_on_fedora
        elif [ -f /etc/lsb-release ]; then
            install_on_void
        else
            echo "Unsupported Linux distribution"
            exit 1
        fi
        ;;
    Darwin*)
        install_on_mac
        ;;
    *)
        echo "Unsupported operating system: ${OS}"
        exit 1
        ;;
esac


ansible-playbook ~/.bootstrap/setup.yml --ask-become-pass

echo "Ansible installation complete."

