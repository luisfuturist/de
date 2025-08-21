#!/bin/bash

source "$(dirname "$0")/../lib/errors.sh"
source "$(dirname "$0")/../lib/log.sh"
source "$(dirname "$0")/../project.sh"

prepare_config() {
    log_info "Copying all configuration files..."

    # Create destination config directory if it doesn't exist
    mkdir -p "$DEST_CONFIG_DIR"

    # Copy all configuration files from source to destination
    # This copies directories recursively and overwrites existing files
    # Existing files in destination not present in source are preserved
    cp -r "$SRC_CONFIG_DIR"/* "$DEST_CONFIG_DIR"/

    log_success "Configuration files copied successfully!"
}

prepare_bin() {
    log_info "Installing bin scripts..."

    # Move ./bin/* into /usr/local/bin
    sudo cp -r ./bin/* /usr/local/bin

    # Update permissions
    sudo chmod +x /usr/local/bin/*

    # Reload bashrc to apply changes
    source ~/.bashrc

    log_success "Installed bin scripts!"
}

prepare_aliases() {
    log_info "Applying aliases..."

    # Create aliases directory if it doesn't exist
    sudo mkdir -p "$DEST_ALIASES_DIR"

    # Copy all alias files to the destination directory
    sudo cp -r "$SRC_ALIASES_DIR"/* "$DEST_ALIASES_DIR"/

    # Update permissions
    sudo chmod +x "$DEST_ALIASES_DIR"/*

    # Ensure the aliases are sourced only once in ~/.bashrc
    for alias_file in "$DEST_ALIASES_DIR"/*.sh; do
        if [[ -f "$alias_file" ]]; then
            alias_source_line="source $alias_file"

            if ! grep -qxF "$alias_source_line" ~/.bashrc; then
                echo "$alias_source_line" >> ~/.bashrc
            fi
        fi
    done

    # Reload bashrc to apply changes
    source ~/.bashrc

    log_success "Aliases applied successfully!"
}

prepare_backgrounds() {
    log_info "Copying backgrounds..."

    # Create backgrounds directory if it doesn't exist
    sudo mkdir -p "$DEST_BACKGROUNDS_DIR"

    # Copy all background files to the destination directory
    sudo cp -r "$SRC_BACKGROUNDS_DIR"/* "$DEST_BACKGROUNDS_DIR"/

    log_success "Backgrounds copied successfully!"
}

prepare_icons() {
    log_info "Copying icons..."

    # Create icons directory if it doesn't exist
    sudo mkdir -p "$DEST_ICONS_DIR"

    # Copy all icon files to the destination directory
    sudo cp -r "$SRC_ICONS_DIR"/* "$DEST_ICONS_DIR"/

    log_success "Icons copied successfully!"
}

prepare_themes() {
    log_info "Copying themes..."

    # Create themes directory if it doesn't exist
    sudo mkdir -p "$DEST_THEMES_DIR"

    # Copy all theme files to the destination directory
    sudo cp -r "$SRC_THEMES_DIR"/* "$DEST_THEMES_DIR"/

    log_success "Themes copied successfully!"
}

prepare_git_config() {
    log_info "Copying Git configuration..."

    # Copy .gitconfig to ~/.gitconfig
    cp .gitconfig ~/.gitconfig

    log_success "Git configuration copied successfully!"
}

prepare() {
    prepare_config
    prepare_bin
    prepare_aliases
    prepare_backgrounds
    prepare_icons
    prepare_themes
    prepare_git_config
}

prepare
