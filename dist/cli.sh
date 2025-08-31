#!/bin/bash

source "$(dirname "$0")/../salmo/lib/errors.sh"
source "$(dirname "$0")/../salmo/lib/log.sh"
source "$(dirname "$0")/../salmo/lib/utils.sh"
source "$(dirname "$0")/../project.sh"

# Constants
USERNAME="${SUDO_USER:-$USER}"
HOME_DIR="/home/$USERNAME"

setup_basic_system_config() {
    log_info "Setting up basic system configuration..."
    
    # Set keyboard layout
    log_info "Setting keyboard layout to br-abnt2..."
    setxkbmap -layout br -variant abnt2
    
    # Set timezone
    log_info "Setting timezone to America/Sao_Paulo..."
    sudo timedatectl set-timezone America/Sao_Paulo

    # Locale
    # TODO: check if this is working
    log_info "Setting locale to en_US.UTF-8..."
    sudo sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
    sudo locale-gen
    echo "LANG=en_US.UTF-8" | sudo tee /etc/locale.conf > /dev/null

    # System language
    log_info "Setting system language to en_US..."
    localectl set-locale LANG=en_US.UTF-8
    
    log_success "Basic system configuration completed"
}

setup_usb() {
    log_info "Initializing bootable USB setup..."
    
    log_info "Installing dependencies..."
    sudo pacman -S git curl transmission-cli
    yay -S ventoy-bin --noconfirm
    log_success "Dependencies installed"

    transmission-cli "$(curl --silent '[url]https://archlinux.org/feeds/releases/[/url]' | xml sel -t -v '//channel/item[1]/link' ; printf '%s\n' 'torrent')"

    log_info "Downloading Arch Linux torrent..."
    curl https://archlinux.org/releng/releases/2025.08.01/torrent/archlinux-2025.08.01-x86_64.iso.torrent -O archlinux.iso.torrent
    log_success "Arch Linux torrent downloaded"

    log_info "Downloading Arch Linux ISO..."
    transmission-cli https://archlinux.org/releng/releases/2025.08.01/torrent/archlinux-2025.08.01-x86_64.iso.torrent -O archlinux.iso

    # Check if USB drives are available
    log_info "Checking for available USB drives..."
    usb_drives=$(lsblk -o NAME,SIZE,TYPE,MOUNTPOINT | grep -E "disk|part" | grep -v "loop")
    
    if [ -z "$usb_drives" ]; then
        log_error "No USB drives found. Please insert a USB drive and try again."
        exit 1
    fi
    
    echo "Available storage devices:"
    echo "$usb_drives"
    
    # Prompt user to select USB drive
    read -p "Enter the USB drive device (e.g., /dev/sdb): " usb_device
    
    # Validate USB device exists
    if [ ! -b "$usb_device" ]; then
        log_error "Device $usb_device does not exist or is not a block device."
        exit 1
    fi
    
    # Check if USB is mounted and unmount if necessary
    mounted_partitions=$(mount | grep "$usb_device" | awk '{print $1}')
    if [ -n "$mounted_partitions" ]; then
        log_info "USB drive is mounted. Unmounting partitions..."
        for partition in $mounted_partitions; do
            sudo umount "$partition"
            log_info "Unmounted $partition"
        done
    fi
    
    # Check if USB is writable
    if [ ! -w "$usb_device" ]; then
        log_info "USB drive is not writable by current user. Will use sudo for operations."
    fi

    # TODO: inform if the USB drive is already setup with Ventoy
    log_info "Setting up USB drive with Ventoy..."
    # TODO: finish this
    # TODO: add a option to select the USB drive
    sudo ventoy -i /dev/sdX

    log_info "Copying Arch Linux ISO to USB drive..."
    # TODO: add a option to select the USB drive
    sudo cp archlinux.iso /dev/sdX1

    log_success "Bootable USB setup completed."

    # Confirm if the user wants to reboot
    read -p "Do you want to reboot now? (y/n): " confirm
    if [[ $confirm == "y" ]]; then
        reboot
    fi
}

install() {    
    assert_not_root
    check_system_requirements
    update_system

    # Download this repo
    git clone https://github.com/luisfuturist/de.git
    cd de

    # Run the install and config scripts
    bash src/scripts/install-de.sh
    bash src/scripts/config-de.sh

    # TODO: run scripts/prepare.sh

    log_success "Installation and configuration completed"

    # Ask if the user wants to reboot
    read -p "Do you want to reboot now? (y/n): " confirm
    if [[ $confirm == "y" ]]; then
        reboot
    fi
}

show_help() {
    echo "Usage: $0 [COMMAND] [OPTIONS]"
    echo ""
    echo "Commands:"
    echo "  setup_usb     Setup bootable USB drive with Arch Linux"
    echo "  install        Install complete desktop environment"
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 setup_usb     # Setup bootable USB drive with Arch Linux"
    echo "  $0 install     # Install desktop environment"
}

echo "DE - Desktop Environment"
echo "https://github.com/luisfuturist/de"
echo ""

echo "User: $USERNAME"
echo "Home directory: $HOME_DIR"
echo ""

# Parse command line arguments
case "${1:-}" in
    -h|--help)
        show_help
        exit 0
        ;;
    setup_usb)
        setup_usb
        ;;
    install)
        install
        ;;
    "")
        log_error "No command specified. Use 'setup_bootable_usb' or 'install'"
        show_help
        exit 1
        ;;
    *)
        log_error "Unknown command: $1"
        show_help
        exit 1
        ;;
esac
