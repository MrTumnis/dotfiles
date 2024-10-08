#!/home/linuxbrew/.linuxbrew/bin/bash

USERNAME=docker
PASS=dockerwinapps
ADDR=127.0.0.1
 
cd ~/winapps

switch() {
	if ! sudo podman ps | grep -q "windows"; then
    	echo "Container 'windows' is not running. Running 'podman-compose start'"
    	sudo podman-compose start
	else
	echo "Container 'windows' is running. Running 'podman-compose stop'"
    	sudo podman-compose stop
	fi 
}

display() {
    # If no arguments are passed, provide default values
    if [ $# -eq 0 ]; then
        echo "No additional RDP arguments provided. Using default values."
        xfreerdp /u:$USERNAME /p:$PASS /v:$ADDR +dynamic-resolution +clipboard -wallpaper +unmap-buttons
    else
        xfreerdp /u:$USERNAME /p:$PASS /v:$ADDR +dynamic-resolution +clipboard -wallpaper +unmap-buttons "$@"
    fi
}

OPTIND=1

while getopts ":sd" opt; do
    case ${opt} in
        s )
            echo "Option -s detected: Toggling VM on/off"
            switch
            ;;
        d )
            echo "Option -d detected: Displaying via RDP"
            shift $((OPTIND -1))
            display "$@"
            ;;
        \? )
            echo "Usage: $0 [-s toggle vm on/off] [-d display via rdp]"
            exit 1
            ;;
    esac
done

# Check if no options were passed
if [ $OPTIND -eq 1 ]; then
    echo "No options were passed. Usage: $0 [-s toggle vm on/off] [-d display via rdp]"
fi
