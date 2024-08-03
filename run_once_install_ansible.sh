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
        elif grep -q 'Void' /etc/os-release; then
            install_on_void
        else
            echo "Unsupported Linux distribution"
            exit 1
        fi
        ;;
    *)
        echo "Unsupported OS"
        exit 1
        ;;
esac

# Run the Ansible playbook if Ansible was installed successfully
if command -v ansible-playbook > /dev/null; then
    ansible-playbook ~/.void_setup/bootstrap/setup.yml --ask-become-pass
    if [ $? -eq 0 ]; then
        echo "Ansible playbook executed successfully."
    else
        echo "Failed to execute Ansible playbook."
        exit 1
    fi
else
    echo "Ansible installation failed."
    exit 1
fi
