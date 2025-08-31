source ./salmo/lib/log.sh

assert_not_root() {
    if [[ $EUID -eq 0 ]]; then
        log_error "This script should not be run as root. Use sudo for specific commands."
        exit 1
    fi
}

update_system() {
    log_info "Updating system packages..."
    sudo pacman -Syu --noconfirm
    log_success "System updated successfully"
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

configure_mirrors() {
    log_info "Configuring pacman mirrors for Brazil..."

    # Check if reflector is installed
    if ! command -v reflector &> /dev/null; then
        log_info "Reflector is not installed. Installing..."
        sudo pacman -S reflector --noconfirm
        log_success "Reflector installed"
    fi

    # Configure mirrors
    sudo reflector --country Brazil --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

    log_success "Pacman mirrors configured successfully"
}
