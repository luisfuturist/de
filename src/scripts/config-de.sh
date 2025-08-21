source "$(dirname "$0")/../../lib/errors.sh"
source "$(dirname "$0")/../../lib/log.sh"
source "$(dirname "$0")/../../project.sh"

# region Must-have software

config_screen_sharing() {
    # TODO: do this
}

config_must_have_software() {
    log_info "Configuring must-have software..."

    config_screen_sharing

    log_success "Must-have software configured successfully!"
}

config_file_management_software() {
    log_info "Configuring file management software..."

    # TODO: check if this is working
    log_info "Configuring pcmanfm to show hidden files..."
    mkdir -p "$DEST_CONFIG_DIR/pcmanfm/default"
    sudo sed -i 's/show_hidden=0/show_hidden=1/' "$DEST_CONFIG_DIR/pcmanfm/default/pcmanfm.conf"
    log_success "pcmanfm configured to show hidden files"

    log_success "File management software configured successfully!"
}

# endregion

# region Utilities

config_wallpaper_software() {
    log_info "Applying wallpaper..."
    hyprpaper &
    log_success "Wallpaper applied successfully!"
}

config_theme() {
    log_info "Configuring theme..."

    sed -i -E \
        -e '/gtk-theme-name/ s|.*|gtk-theme-name="oomox-lfds-dark"|' \
        ~/.gtkrc-2.0

    log_success "Theme configured successfully!"
}

config_icons() {
    log_info "Configuring icons..."

    sed -i -E \
        -e '/gtk-icon-theme-name/ s|.*|gtk-icon-theme-name="oomox-lfds-dark"|' \
        ~/.gtkrc-2.0

    log_success "Icons configured successfully!"
}

# endregion

# region Dev environment

config_docker() {
    log_info "Configuring docker..."

    # Check if the docker group exists, if not, create it
    if ! getent group docker > /dev/null 2>&1; then
        echo "Creating docker group..."
        sudo groupadd docker
    else
        echo "Docker group already exists."
    fi

    # Add current user to the docker group
    echo "Adding $USER to the docker group..."
    sudo usermod -aG docker $USER

    # Inform the user to log out and log back in
    echo "User $USER added to docker group."

    log_info "Applying docker..."
    newgrp docker
    log_success "Docker applied successfully!"
    
    log_success "Docker configured successfully!"
}

config_dev_environment() {
    log_info "Configuring dev environment..."
    
    config_docker
    
    log_success "Dev environment configured successfully!"
}

# endregion

config() {
    # Utilitites
    config_must_have_software
    config_wallpaper_software
    config_theme
    config_icons

    config_dev_environment
}

config
