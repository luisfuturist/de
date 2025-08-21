source "$(dirname "$0")/../../lib/errors.sh"
source "$(dirname "$0")/../../lib/log.sh"
source "$(dirname "$0")/../../lib/utils.sh"
source "$(dirname "$0")/../../project.sh"

# region Useful utilities

install_must_have_software() {
    log_info "Installing must have software..."

    # Notification daemon
    log_info "Installing Dunst..."
    sudo pacman -S dunst --noconfirm
    log_success "Dunst installed"

    # Pipewire
    log_info "Installing Pipewire..."
    sudo pacman -S pipewire wireplumber --noconfirm
    log_success "Pipewire installed"

    # XDG Desktop Portal
    log_info "Installing XDG Desktop Portal..."
    sudo pacman -S xdg-desktop-portal-hyprland --noconfirm
    log_success "XDG Desktop Portal installed"

    # Authentication Agent 
    # TODO: check if this is working

    # Qt Wayland Support 
    log_info "Installing Qt Wayland Support..."
    sudo pacman -S qt5-wayland qt6-wayland --noconfirm
    log_success "Qt Wayland Support installed"

    log_success "Must-have software installed"
}

install_fonts() {
    log_info "Installing fonts..."
    
    sudo pacman -S ttf-roboto ttf-roboto-mono --noconfirm
    sudo pacman -S noto-fonts noto-fonts-emoji --noconfirm
    sudo pacman -S nerd-fonts --noconfirm

    log_success "Fonts installed"
}

install_status_bar() {
    log_info "Installing status bar..."
    sudo pacman -S waybar --noconfirm
    log_success "Status bar installed"
}

install_wallpaper_software() {
    log_info "Installing wallpaper software..."
    
    log_info "Installing hyprpaper..."
    sudo pacman -S hyprpaper --noconfirm
    log_success "Hyprpaper installed"

    log_success "Wallpaper software installed"
}

install_app_launcher() {
    log_info "Installing application launcher..."
    sudo pacman -S bemenu --noconfirm
    log_success "Application launcher installed"
}

install_color_picker() {
    log_info "Installing color picker..."
    sudo pacman -S hyprpicker --noconfirm
    log_success "Color picker installed"
}

install_clipboard_manager() {
    log_info "Installing clipboard manager..."

    sudo pacman -S wl-clipboard --noconfirm
    sudo pacman -S cliphist --noconfirm

    log_success "Clipboard manager installed"
}

install_file_management_software() {
    log_info "Installing file management software..."

    # File tools
    log_info "Installing file tools..."
    sudo pacman -S 7zip --noconfirm # for archive extraction and preview
    sudo pacman -S unzip --noconfirm # for archive extraction (required by Bun)
    sudo pacman -S jq --noconfirm  # for json preview
    sudo pacman -S poppler --noconfirm # for pdf preview
    sudo pacman -S resvg --noconfirm # for svg preview
    sudo pacman -S imagemagick --noconfirm # for image and font preview
    sudo pacman -S zoxide --noconfirm # for for historical directory navigation
    sudo pacman -S fzf --noconfirm # for quikc file subtree navigation
    sudo pacman -S fd --noconfirm # for file searching
    sudo pacman -S ripgrep --noconfirm # for file content searching
    log_success "File tools installed"

    # File managers
    log_info "Installing file managers..."
    sudo pacman -S yazi --noconfirm
    # Check and uninstall dolphin
    if pacman -Qi dolphin &> /dev/null; then
        log_info "Dolphin is installed. Uninstalling..."
        sudo pacman -Rns dolphin --noconfirm
        log_success "Dolphin uninstalled successfully"
    fi
    sudo pacman -S pcmanfm --noconfirm
    log_success "File managers installed"

    # Torrent client
    log_info "Installing torrent client..."
    sudo pacman -S transmission-gtk --noconfirm
    log_success "Torrent client installed"

    log_success "File management software installed"
}

# endregion

# region Environments

install_art_creation_software() {
    log_info "Installing art creation software..."

    sudo pacman -S inkscape --noconfirm
    sudo pacman -S kdenlive --noconfirm
    sudo pacman -S gimp --noconfirm

    log_success "Art creation software installed"
}

install_system_appearance_edition_software() {
    log_info "Installing system appearance edition software..."

    yay -S themix-theme-oomox-git --noconfirm
    yay -S themix-icons-archdroid-git --noconfirm
    yay -S themix-full-git --noconfirm   

    log_success "System appearance edition software installed"
}

install_docker() {
    log_info "Installing Docker and docker tools..."

    sudo pacman -S docker --noconfirm
    sudo pacman -S docker-compose --noconfirm
    sudo yay -S lazydocker --noconfirm

    log_success "Docker and docker tools installed"
}

install_javascript_software() {
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

    log_success "JavaScript runtimes and package managers installed"
}

install_java_software() {
    log_info "Installing Java development software..."
    
    log_info "Installing Java runtimes..."
    sudo pacman -S jdk17-openjdk --noconfirm
    sudo pacman -S jdk21-openjdk  --noconfirm
    log_success "Java runtimes installed"

    log_info "Installing Gradle..."
    sudo pacman -S gradle --noconfirm
    log_success "Gradle installed"

    log_success "Java development software installed"
}

install_nvim() {
    log_info "Installing Neovim..."

    sudo pacman -S neovim --noconfirm

    log_info "Installing LazyVim..."

    log_info "Installing extra lazyvim dependencies..."
    sudo pacman -S fish --noconfirm
    sudo pacman -S ast-grep --noconfirm
    log_success "Extra lazyvim dependencies installed"

    git clone https://github.com/LazyVim/starter ~/.config/nvim
    rm -rf ~/.config/nvim/.git
    nvim --headless +q
    log_success "LazyVim installed"
    
    log_success "Neovim installed"
}

install_cursor() {
    log_info "Installing Cursor..."
    yay -S cursor-bin --noconfirm
    # TODO: install cursor extensions automatically
    log_success "Cursor installed"
}

install_dev_software() {
    log_info "Installing software for development..."

    install_docker
    install_javascript_software
    install_java_software

    install_cursor
    install_nvim

    # Lazygit
    log_info "Installing Lazygit..."
    sudo pacman -S lazygit --noconfirm
    log_success "Lazygit installed"

    # GitHub CLI
    log_info "Installing GitHub CLI..."
    sudo pacman -S github-cli --noconfirm
    log_success "GitHub CLI installed"
    
    log_success "Software for development installed"
}

install_games() {
    log_info "Installing games..."
    
    log_info "Installing Prism Launcher..."
    sudo pacman -S prismlauncher --noconfirm
    # TODO: config prismlauncher
    log_success "Prism Launcher installed"

    log_success "Games installation completed"
}

# endregion

install_misc_software() {
    # TODO: organize this
    log_info "Installing miscellaneous software..."
    
    sudo pacman -S ffmpeg --noconfirm

    # Managers
    sudo pacman -S wiremix
    sudo pacman -S impala
    sudo pacman -S gdu

    # Web browser
    log_info "Installing Google Chrome..."
    yay -S google-chrome --noconfirm
    
    # Terminal
    log_info "Installing terminal tools..."
    sudo pacman -S alacritty --noconfirm
    if pacman -Qi kitty &> /dev/null; then
        log_info "Kitty is installed. Uninstalling..."
        sudo pacman -Rns kitty --noconfirm
        log_success "Kitty uninstalled successfully"
    fi
    sudo pacman -S tmux --noconfirm
    log_success "Terminal installed"

    # Document tools
    log_info "Installing document tools..."
    sudo pacman -S evince --noconfirm
    xdg-mime default org.gnome.Evince.desktop application/pdf

    # Media tools
    log_info "Installing media tools..."
    sudo pacman -S vlc --noconfirm
    sudo pacman -S qt6-multimedia-ffmpeg --noconfirm
    # Image viewer
    sudo pacman -S imv --noconfirm
    xdg-mime default imv.desktop image/png
    xdg-mime default imv.desktop image/jpeg
    xdg-mime default imv.desktop image/gif
    xdg-mime default imv.desktop image/webp
    xdg-mime default imv.desktop image/svg+xml
    xdg-mime default imv.desktop image/tiff
    xdg-mime default imv.desktop image/bmp

    # Networking tools
    log_info "Installing networking tools..."
    curl -fsSL https://tailscale.com/install.sh | sh
    
    # Hardware control
    sudo pacman -S brightnessctl --noconfirm
    
    # Monitoring tools
    sudo pacman -S htop btop --noconfirm

    # Screenshot tool
    sudo pacman -S hyprshot --noconfirm
    
    # Network tools
    sudo pacman -S net-tools bind-tools nmap --noconfirm
    
    # Media tools
    log_info "Installing media tools..."
    # TODO: check if this is working
    sudo pacman -S peek --noconfirm

    log_success "Core applications installed"
}

install() {
    assert_not_root
    update_system
    check_system_requirements
    configure_mirrors

    # Utilities
    install_must_have_software
    install_fonts
    install_status_bar
    install_wallpaper_software
    install_app_launcher
    install_color_picker
    install_clipboard_manager
    install_file_management_software

    # Environments
    install_art_creation_software
    install_system_appearance_edition_software
    install_dev_software
    install_games
    install_misc_software
}

install
