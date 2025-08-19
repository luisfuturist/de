#!/bin/bash

# Exit on error, undefined vars, pipe failures
set -euo pipefail

# region Help functions

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Error handling
handle_error() {
    log_error "An error occurred on line $1"
    exit 1
}

# endregion

trap 'handle_error $LINENO' ERR

# Constants
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
USERNAME="${SUDO_USER:-$USER}"
HOME_DIR="/home/$USERNAME"

assert_not_root() {
    if [[ $EUID -eq 0 ]]; then
        log_error "This script should not be run as root. Use sudo for specific commands."
        exit 1
    fi
}

check_system_requirements() {
    log_info "Checking system requirements..."
    
    # Check if running on Arch
    if ! command -v pacman &> /dev/null; then
        log_error "This script is designed for Arch Linux systems"
        exit 1
    fi
    
    # Check if yay is installed
    if ! command -v yay &> /dev/null; then
        log_warning "yay is not installed. Installing yay..."
        sudo pacman -S --needed git base-devel --noconfirm
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay
        makepkg -si --noconfirm
        cd "$SCRIPT_DIR"
    fi
    
    log_success "System requirements check completed"
}

update_system() {
    log_info "Updating system packages..."
    sudo pacman -Syu --noconfirm
    log_success "System updated successfully"
}

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
    
    # Configure pacman mirrors for Brazil
    log_info "Configuring pacman mirrors for Brazil..."
    sudo pacman-mirrors -c Brazil
    
    log_success "Basic system configuration completed"
}

install_core_apps() {
    log_info "Installing core applications..."
    
    # Web browser
    log_info "Installing Google Chrome..."
    yay -S google-chrome --noconfirm
    
    # Terminal
    log_info "Installing Alacritty..."
    sudo pacman -S alacritty --noconfirm
    if pacman -Qi kitty &> /dev/null; then
        log_info "Kitty is installed. Uninstalling..."
        sudo pacman -Rns kitty --noconfirm
        log_success "Kitty uninstalled successfully"
    fi
    
    # File tools
    log_info "Installing and configuring file tools..."
    # File manager
    sudo pacman -S dolphin --noconfirm
    # Configure Dolphin to show hidden files
    # TODO: check if this is working
    log_info "Configuring Dolphin to show hidden files..."
    mkdir -p "$HOME_DIR/.config"
    kwriteconfig5 --file "$HOME_DIR/.config/dolphinrc" --group "General" --key "ShowHiddenFiles" true
    log_success "Dolphin configured to show hidden files"
    # Torrent client
    sudo pacman install transmission-gtk --noconfirm
    sudo pacman -S unzip --noconfirm

    # Document tools
    log_info "Installing document tools..."
    sudo pacman -S evince --noconfirm
    xdg-mime default org.gnome.Evince.desktop application/pdf

    # Media tools
    log_info "Installing media tools..."
    sudo pacman -S vlc --noconfirm
    sudo pacman -S qt6-multimedia-ffmpeg --noconfirm

    # Networking tools
    log_info "Installing networking tools..."
    curl -fsSL https://tailscale.com/install.sh | sh
    
    log_success "Core applications installed"
}

install_system_tools() {
    log_info "Installing system tools..."
    
    # Hardware control
    sudo pacman -S brightnessctl --noconfirm
    
    # Monitoring tools
    sudo pacman -S htop glances --noconfirm
    
    # Screenshot tool
    # TODO: not working
    sudo pacman -S flameshot --noconfirm
    
    # Network tools
    sudo pacman -S net-tools bind-tools nmap --noconfirm
    
    # Media tools
    log_info "Installing media tools..."
    sudo pacman -S peek --noconfirm
    
    log_success "System tools installed"
}

setup_art_environment() {
    log_info "Setting up art environment..."

    sudo pacman -S inkscape --noconfirm
    sudo pacman -S kdenlive --noconfirm
    sudo pacman -S gimp --noconfirm
}

setup_dev_environment() {
    log_info "Setting up development environment..."

    # IDEs
    log_info "Installing IDEs..."
    # Cursor
    yay -S cursor-bin --noconfirm
    # TODO: install cursor extensions automatically
    # NeoVim
    sudo pacman -S neovim --noconfirm
    # TODO: install neovim plugins automatically

    # Git configuration
    log_info "Configuring Git and git tools..."
    git config --global user.name "Luis Emidio"
    git config --global user.email "luisfuturist@gmail.com"
    git config --global core.editor "cursor --wait"
    git config --global safe.directory "/delphis"
    # Install Git aliases
    log_info "Installing Git aliases..."
    bash scripts/install-git-aliases.sh
    # Lazygit
    sudo pacman -S lazygit --noconfirm
    # GitHub CLI
    log_info "Installing GitHub CLI..."
    sudo pacman -S github-cli --noconfirm

    # Docker
    log_info "Installing Docker and docker tools..."
    sudo pacman install docker docker-compose --noconfirm
    bash scripts/install-docker.sh
    sudo yay -S lazydocker --noconfirm
    
    # region JavaScript
    log_info "Installing JavaScript runtimes and package managers..."
    # nvm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    export NVM_DIR="$HOME_DIR/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    # Node.js
    nvm install node
    # Bun
    curl -fsSL https://bun.sh/install | bash
    # pnpm
    curl -fsSL https://get.pnpm.io/install.sh | sh -

    # Java
    log_info "Installing Java runtimes..."
    sudo pacman -S jdk17-openjdk --noconfirm
    sudo pacman -S jdk21-openjdk  --noconfirm
    
    log_success "Development environment setup completed"
}

install_games() {
    log_info "Installing games..."
    bash scripts/install-games.sh
    log_success "Games installation completed"
}

install_custom_scripts() {
    log_info "Installing custom scripts..."
    bash scripts/install-bin.sh
    log_success "Custom scripts installed"
}

setup_appearance() {
    log_info "Setting up appearance..."
    bash scripts/install-appearance.sh
    log_success "Appearance setup completed"
}

main() {
    log_info "Starting desktop environment installation script..."
    log_info "Script directory: $SCRIPT_DIR"
    log_info "User: $USERNAME"
    log_info "Home directory: $HOME_DIR"
    
    assert_not_root
    check_system_requirements
    update_system
    
    setup_basic_system_config
    
    install_core_apps
    install_system_tools
    
    setup_dev_environment
    setup_art_environment
    


    install_games
    
    install_custom_scripts
    
    setup_appearance



    log_info "Applying configuration to current shell..."
    source ~/.bashrc
    
    log_success "Desktop Environment installation completed successfully!"
    log_info "Please restart your system to apply all changes."
}

prepare_installation() {
    log_info "Preparing installation..."
    
    log_info "Installing dependencies..."
    sudo pacman -S git wget transmission-cli
    yay -S ventoy-bin --noconfirm

    log_info "Downloading Arch Linux torrent..."
    wget https://archlinux.org/releng/releases/2025.08.01/torrent/archlinux-2025.08.01-x86_64.iso.torrent -O archlinux.iso.torrent

    log_info "Downloading Arch Linux ISO..."
    transmission-cli https://archlinux.org/releng/releases/2025.08.01/torrent/archlinux-2025.08.01-x86_64.iso.torrent -O archlinux.iso

    # TODO: check if USB is available
    # TODO: check if USB is mounted
    # TODO: check if USB is writable

    # TODO: inform if the USB drive is already setup with Ventoy
    log_info "Setting up USB drive with Ventoy..."
    # TODO: finish this
    # TODO: add a option to select the USB drive
    sudo ventoy -i /dev/sdX

    log_info "Copying Arch Linux ISO to USB drive..."
    # TODO: add a option to select the USB drive
    sudo cp archlinux.iso /dev/sdX1

    log_success "Installation prepared"
}

show_help() {
    echo "Desktop Environment Installation Script"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo "  -v, --version  Show version information"
    echo ""
    echo "This script will install and configure your desktop environment"
    echo "with all necessary applications and customizations."
}

# Parse command line arguments
case "${1:-}" in
    -h|--help)
        show_help
        exit 0
        ;;
    -v|--version)
        show_version
        exit 0
        ;;
    "")
        main
        ;;
    *)
        log_error "Unknown option: $1"
        show_help
        exit 1
        ;;
esac
