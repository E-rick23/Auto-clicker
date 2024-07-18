#!/bin/bash

# Function that detects the linux distro being used, sending the proper message to the user.
suggest_install_command() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case $ID in
            ubuntu|debian)
                echo -e "Error: xdotool isn't installed! \nInstall it with the command: sudo apt-get install xdotool"
                ;;
            fedora)
                echo -e "Error: xdotool isn't installed! \nInstall it with the command: sudo dnf install xdotool"
                ;;
            centos|rhel)
                echo -e "Error: xdotool isn't installed! \nInstall it with the command: sudo yum install xdotool"
                ;;
            arch|manjaro)
                echo -e "Error: xdotool isn't installed! \nInstall it with the command: sudo pacman -S xdotool"
                ;;
            *)
                echo -e "Sorry! I couldn't recognize your Linux Distro :( \nPlease install xdotool using your distro's package manager!."
                ;;
        esac
    else
        echo -e "I couldn't check your distro, because I couldn't find the /etc/os-release file... \nPlease install xdotool using your distro's package manager!"
    fi
}

click() {
    sleep 0.1
    xdotool click 1  # Using xdotool, this command emulates the mouse click
}

#Checking if xdotool is installed before starting, program ends if it's not installed.
if ! command -v xdotool &> /dev/null; then
 suggest_install_command
 exit 1
fi

#Starting the auto-clicker
echo "Press 'x' to stop the loop!"

while true; do
    click
    read -n 1 -t 0.01 key  # Reads a char with a 0.01 second timeout.
    if [[ $key == "x" ]]; then
        echo -e "\nPoof! Auto-clicker has been stopped!"
        break
    fi
done
