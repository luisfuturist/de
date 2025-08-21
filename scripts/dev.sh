#!/bin/bash

# Determine the absolute path of the directory containing this script
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

# Define the project root as the parent directory of `dist`
PROJECT_ROOT=$(cd -- "$SCRIPT_DIR/.." &> /dev/null && pwd)

# Source all dependencies using the absolute project root path
# It's good practice to source the main project file first.
source "$PROJECT_ROOT/project.sh"
source "$PROJECT_ROOT/lib/errors.sh"
source "$PROJECT_ROOT/lib/log.sh"
source "$PROJECT_ROOT/lib/utils.sh"

handle_config_file_change() {
    local file="$1" # e.g. /home/luis/GitHub/luisfuturist/de/src/config/hypr/hyprland.conf
    local event="$2"
    
    # Skip if it's a directory or temp file
    if [[ -d "$file" ]] || [[ "$file" == *"~" ]] || [[ "$file" == *".tmp" ]]; then
        return
    fi
    
    local rel_path="${file#$SRC_CONFIG_DIR}" # e.g. /hypr/hyprland.conf
    local target_path="$DEST_CONFIG_DIR$rel_path" # e.g. ~/.config/hypr/hyprland.conf
    
    if [[ "$event" == "DELETE" ]]; then
        if [[ -f "$target_path" ]]; then
            remove_config "$rel_path" "$target_path"
            log_info "Removed: $target_path"
        fi
    elif [[ "$event" == "MOVED_FROM" ]]; then
        if [[ -f "$target_path" ]]; then
            remove_config "$rel_path" "$target_path"
            log_info "Removed (cause: moved): $target_path"
        fi
    elif [[ "$event" == "CREATE" ]]; then
        update_config "$rel_path" "$target_path"
        log_info "Created: $target_path"
        handle_special_config_file_change "$rel_path"
    elif [[ "$event" == "MODIFY" ]] || [[ "$event" == "MOVED_TO" ]]; then
        update_config "$rel_path" "$target_path"
        log_info "Modified: $target_path"
        handle_special_config_file_change "$rel_path"
    fi
}

update_config() {
    local rel_path="$1"
    local target_path="$2"
    # Create target directory if it doesn't exist
    mkdir -p "$(dirname "$target_path")"
    cp "$file" "$target_path"

    log_debug "Updated $target_path"
}

remove_config() {
    local rel_path="$1"
    local target_path="$2"
    
    # Remove the file
    rm "$target_path"
    
    # Remove empty parent directories up to ~/.config
    local parent_dir="$(dirname "$target_path")"
    while [[ "$parent_dir" != "$DEST_CONFIG_DIR" ]] && [[ -d "$parent_dir" ]] && [[ -z "$(ls -A "$parent_dir")" ]]; do
        rmdir "$parent_dir"
        log_debug "Removed empty directory: $parent_dir"
        parent_dir="$(dirname "$parent_dir")"
    done
}

handle_special_config_file_change() {
    local rel_path="$1"

    case "$rel_path" in
        /hypr/hyprland.conf)
            echo "Reloading Hyprland configuration..."
            hyprctl reload 2>/dev/null || echo "Note: Could not reload Hyprland (not running?)"
            ;;
        /waybar/*)
            echo "Restarting Waybar... (no-op)"
            # TODO: Implement waybar restart logic
            ;;
    esac
}

handle_bin_file_change() {
    local file="$1" # e.g. /home/luis/GitHub/luisfuturist/de/src/bin/yazi-x
    local event="$2"
    
    local rel_path="${file#$SRC_BIN_DIR}" # e.g. /yazi-x
    local target_path="$DEST_BIN_DIR$rel_path" # e.g. ~/.config/bin/yazi-x
    
    if [[ "$event" == "DELETE" ]] || [[ "$event" == "MOVED_FROM" ]]; then
        if [[ -f "$target_path" ]]; then
            sudo rm "$target_path"
            log_info "Removed: $target_path"
        fi
    elif [[ "$event" == "CREATE" ]] || [[ "$event" == "MOVED_TO" ]]; then
        # Create target directory if it doesn't exist
        mkdir -p "$(dirname "$target_path")"
        sudo cp "$file" "$target_path"
        # Make the script executable
        sudo chmod +x "$target_path"
        log_info "Created: $target_path"
    elif [[ "$event" == "MODIFY" ]]; then
        # Create target directory if it doesn't exist
        mkdir -p "$(dirname "$target_path")"
        sudo cp "$file" "$target_path"
        # Make the script executable
        sudo chmod +x "$target_path"
        log_info "Modified: $target_path"
    fi
}

handle_aliases_file_change() {
    local file="$1"
    local event="$2"
    log_debug "$file (event: $event) - NOT IMPLEMENTED"
    # TODO: apply aliases
}

handle_backgrounds_file_change() {
    local file="$1"
    local event="$2"
    log_debug "$file (event: $event) - NOT IMPLEMENTED"
    # TODO: apply backgrounds
}

handle_icons_file_change() {
    local file="$1"
    local event="$2"
    log_debug "$file (event: $event) - NOT IMPLEMENTED"
    # TODO: apply icons
}

handle_themes_file_change() {
    local file="$1"
    local event="$2"
    log_debug "$file (event: $event) - NOT IMPLEMENTED"
    # TODO: apply themes
}

handle_gitconfig_file_change() {
    local file="$1"
    local event="$2"

    log_debug "Gitconfig file changed: $file (event: $event)"

    case "$event" in
        DELETE|MOVED_FROM)
            if [[ -f "$DEST_GITCONFIG_FILE" ]]; then
                rm "$DEST_GITCONFIG_FILE"
                log_debug "Removed $DEST_GITCONFIG_FILE"
            fi
            ;;
        MODIFY|CREATE|MOVED_TO)
            if [[ -f "$file" ]]; then
                cp "$file" "$DEST_GITCONFIG_FILE"
                log_debug "Updated $DEST_GITCONFIG_FILE"
            else
                log_error "Source gitconfig file not found: $file"
            fi
            ;;
        *)
            log_debug "Unhandled gitconfig event: $event"
            ;;
    esac
}

route_file_change() {
    local file="$1"
    local event="$2"

    log_debug "File changed: $file (event: $event)"
    
    # Determine file type and route to appropriate handler
    if [[ "$file" == "$SRC_CONFIG_DIR"* ]]; then
        handle_config_file_change "$file" "$event"
    elif [[ "$file" == "$SRC_BIN_DIR"* ]]; then
        handle_bin_file_change "$file" "$event"
    elif [[ "$file" == "$SRC_GITCONFIG_FILE" ]]; then
        handle_gitconfig_file_change "$file" "$event"
    elif [[ "$file" == "$SRC_ALIASES_DIR"* ]]; then
        handle_aliases_file_change "$file" "$event"
    elif [[ "$file" == "$SRC_BACKGROUNDS_DIR"* ]]; then
        handle_backgrounds_file_change "$file" "$event"
    elif [[ "$file" == "$SRC_ICONS_DIR"* ]]; then
        handle_icons_file_change "$file" "$event"
    elif [[ "$file" == "$SRC_THEMES_DIR"* ]]; then
        handle_themes_file_change "$file" "$event"
    else
        log_debug "Unknown file type: $file (event: $event)"
    fi
}

check_required_software() {
    if ! command -v inotifywait &> /dev/null; then
        log_info "inotifywait is not installed. Installing inotify-tools package..."
        sudo pacman -S inotify-tools
        if ! command -v inotifywait &> /dev/null; then
            log_error "Failed to install inotify-tools package."
            exit 1
        fi
        log_success "inotify-tools installed successfully!"
    fi
}

check_required_software

echo "Watching for changes in project directories..."
echo "Press Ctrl+C to stop watching"

# Watch for file changes in all project directories
inotifywait -m -r -e create,modify,delete,moved_from,moved_to --format '%w%f %e' \
    "$SRC_CONFIG_DIR" "$SRC_BIN_DIR" "$SRC_GITCONFIG_FILE" "$SRC_ALIASES_DIR" "$SRC_BACKGROUNDS_DIR" "$SRC_ICONS_DIR" "$SRC_THEMES_DIR" |
while read file event; do
    route_file_change "$file" "$event"
done
