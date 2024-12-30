#!/bin/bash

# Function that detects the Linux distro being used and sends the appropriate message to the user.
suggest_install_command() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case $ID in
            ubuntu|debian|zorin)
                INSTALL_CMD="sudo apt-get install xdotool"
                ;;
            fedora)
                INSTALL_CMD="sudo dnf install xdotool"
                ;;
            centos|rhel)
                INSTALL_CMD="sudo yum install xdotool"
                ;;
            arch|manjaro)
                INSTALL_CMD="sudo pacman -S xdotool"
                ;;
            *)
                echo -e "Sorry! I couldn't recognize your Linux Distro :( \nPlease install xdotool using your distro's package manager."
                return 1
                ;;
        esac
        echo -e "Error: xdotool isn't installed! \nYou can install it with the command: $INSTALL_CMD"
        return 0
    else
        echo -e "I couldn't check your distro because I couldn't find the /etc/os-release file... \nPlease install xdotool using your distro's package manager!"
        return 1
    fi
}

# Function to ask the user if they want to install xdotool.
ask_to_install_xdotool() {
    suggest_install_command
    if [ $? -eq 0 ]; then
        read -p "Would you like to install xdotool now? [y/N] " response
        if [[ $response =~ ^[Yy]$ ]]; then
            echo "Installing xdotool..."
            eval "$INSTALL_CMD"
            if [ $? -eq 0 ]; then
                echo "xdotool has been successfully installed!"
                return 0
            else
                echo "Failed to install xdotool. Please try installing it manually."
                return 1
            fi
        else
            echo "Installation skipped. xdotool is required to run this script."
            return 1
        fi
    fi
}

# Function to ask the user if they want to start the script.
ask_to_start_script() {
    read -p "Would you like to start the auto-clicker now? [y/N] " response
    if [[ $response =~ ^[Yy]$ ]]; then
        return 0
    else
        echo "Auto-clicker start skipped."
        return 1
    fi
}

click() {
    # Uncomment this to get slower clicks!
    # sleep 0.1
    xdotool click 1  # Using xdotool, this command emulates the mouse click
}

# Checking if xdotool is installed before starting. Program ends if it's not installed.
if ! command -v xdotool &> /dev/null; then
    ask_to_install_xdotool || exit 1
    ask_to_start_script || exit 0
fi

# Starting the auto-clicker
echo "Press 'x' to stop the loop!"

while true; do
    click
    read -n 1 -t 0.01 key  # Reads a char with a 0.01 second timeout.
    if [[ $key == "x" ]]; then
        echo -e "\nPoof! Auto-clicker has been stopped!"
        break
    fi
done
