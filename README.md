# 💻 DE - Desktop Environment

An opinionated, automated desktop environment installer for Arch Linux that delivers a cohesive developer workstation with curated applications, streamlined workflows, and consistent configurations deployable through effortless automation.

> [!CAUTION]
> This project is a work in progress and may not be fully functional.

> [!NOTE]
> This project is meant to be personal and extremely opinionated. It is not meant to be a general purpose desktop environment. If you find this project useful to your own needs, it is recommended to fork it and make it your own adjustments.

## Quick Start

 ```bash
 # Apply files and install packages
 ~/GitHub/9aia/salmo/src/scripts/salmo/salmo prepare
 ```

## Goals

- 🎯 **Opinionated**: Curated choices, not user-configurable
- 🎨 **Aesthetic Excellence**: Cohesive and pleasing user experience
- ⚡ **Developer Productivity**: Streamlined tooling and workflows
- 🔧 **Consistent Experience**: Uniform across installations
- 🔄 **Effortless Deployment**: Quick system setup and recovery
- 🚀 **Automated Setup**: Fully reproducible desktop environment

## Scope

This project includes:

- **Curation of the Desktop Environment**:
  - Assets (fonts, wallpapers, icons, themes)
  - Complete system configuration: window manager, terminal, lock screen, status bar, notification daemon, application launcher, etc.
  - Essential development tools and productivity applications
  - Custom utility scripts and binaries for enhanced workflow
- **CLI Installation Tool** with comprehensive automation:
  - `de setup_usb` - Downloads dependencies, Arch ISO, sets up USB drive, copies ISO to USB drive, and reboots automatically
  - `de install` - Complete automated desktop environment deployment including all the curated desktop environment mentioned above
- **Development Environment for This Project**:
  - Live synchronization between the local repository and the active system for rapid testing

**Out of scope:**

- Multi-distribution support (Arch Linux only)
- GUI-based configuration tools
- Windows or macOS compatibility
- Legacy hardware support
- Production server configurations

## Features

### Components

| Component | Technology |
|-----------|------------|
| Window Manager | [Hyprland](https://hyprland.org/) |
| Terminal | [Alacritty](https://alacritty.org/) |
| Multiplexer | [Tmux](https://github.com/tmux/tmux) |
| Application Launcher | [bemenu](https://github.com/Cloudef/bemenu) |
| Code Editor | [Cursor](https://cursor.sh/), [Neovim](https://neovim.io/) |
| Image Viewer | [Imv](https://github.com/eXeC64/imv) |
| GTK Theme | [Oomox](https://github.com/themix-project/oomox) |
| Icon Theme | Archdroid (Android Material Design) |
| Font | Roboto |

#### Must have software

| Software | Technology |
|-----------|------------|
| Notification Daemon | [Dunst](https://github.com/dunst-project/dunst) |

#### Utilities

| Software | Technology |
|-----------|------------|
| Status Bar | [Waybar](https://github.com/Alexays/Waybar) |
| Clipboard | [wl-clipboard](https://github.com/bugaevc/wl-clipboard) |
| Clipboard Manager | [cliphist](https://github.com/sentriz/cliphist) |
| Wallpaper | [hyprpaper](https://wiki.hypr.land/Hypr-Ecosystem/hyprpaper/) |
| File Manager | [pcmanfm](https://github.com/lxde/pcmanfm) (GUI), [yazi](https://github.com/sxyazi/yazi) (TUI) |
| Idle Management | [hypridle](https://github.com/hyprwm/hypridle) |
| Audio Mixer | [wiremix](https://github.com/tsowell/wiremix) |
| Wifi Manager | [impala](https://github.com/pythops/impala) |

### Settings

- **Keyboard Layout:** Brazilian ABNT2 (`br-abnt2`)
- **Timezone:** São Paulo, Brazil (`America/Sao_Paulo`)
- **Locale:** English US with UTF-8 encoding (`en_US.UTF-8`)
- **System Language:** English US (`en_US`)
- **Package Mirror:** Brazil region

### Customizations

- Set `$mod` as `Mod4`;
- Open application launcher by pressing `$mod+d`;
- Custom wallpaper;
- Custom [Hyprland](https://hyprland.org/) appearence;
- Custom notification appearence powered by [dunst](https://github.com/dunst-project/dunst);
- Custom application launcher appearence powered by [bemenu](https://github.com/Cloudef/bemenu);
- Custom [Alacritty](https://alacritty.org/) appearence;
- Custom GTK theme based on Oomox theme style;
- Custom icon theme based on Android Lollipop's material design icons.

## Documentation

### Prerequisites

Before starting the installation, ensure you have:

- A computer with UEFI firmware (legacy BIOS not supported)
- At least 8GB of RAM and 128GB of free storage
- A USB drive with at least 2GB capacity (will be formatted)
- Stable internet connection for downloading packages
- [Curl](https://curl.se/) installed on your current system

### Installation Guide

> [!IMPORTANT]
> **Read this documentation on a separate device** (phone, tablet, or another computer) as you'll need to reboot during installation and won't have access to this documentation.

> [!CAUTION]
> This installation will completely replace your current system. **Back up all important data before proceeding.**

#### Phase 1: Prepare Installation Media

1. **Download and prepare the installation:**

   ```bash
   curl -fsSL https://de.luisfuturist.com | bash setup_usb
   ```

   This script will:
   - Download Arch Linux ISO
   - Install Ventoy USB tool
   - Format your USB drive
   - Copy the ISO to the USB drive
   - Reboot the system

2. **Configure BIOS/UEFI settings:**
   - Before the computer is about to boot, enter BIOS/UEFI setup (usually F2, F12, or Del key)
   - Ensure that the USB drive is set as the first boot device
   - Disable Secure Boot if enabled
   - Save settings and exit

#### Phase 2: Install Base System

1. **Connect to the internet:** e.g. using WiFi or Ethernet cable

2. **Boot from USB and install Arch Linux:**

   After booting from the USB drive, run:

   ```bash
   archinstall
   ```

3. **Configure installation with these specific settings:**

   Follow the `archinstall` prompts and use these **required** configurations:

   - **Profile Type:** `desktop`
   - **Desktop Environment:** Select `Hyprland` from the window manager options
   - **Audio:** `pipewire`
   - **Kernel:** `linux`, `linux-zen`
   - **Network configuration:** `NetworkManager`
   - **Graphics driver:** `nvidia (proprietary drivers)`
   - **Additional packages:** Leave default or add any specific packages you need

   > [!TIP]
   > For all other settings, the defaults are generally appropriate, but ensure you:
   > - Set a strong root password
   > - Create a user account with sudo privileges
   > - Configure your disk partitioning carefully

4. **Complete base installation:**
   - Wait for the installation to complete (this may take 10-30 minutes)
   - Remove the USB drive when prompted
   - Reboot the system

#### Phase 3: Install Desktop Environment

1. **Complete the desktop environment setup:**

   After rebooting into your new Arch system, log in and run:

   ```bash
   curl -fsSL https://de.luisfuturist.com | bash install
   ```

   This will install and configure:
   - All desktop environment components (Hyprland, Waybar, etc.)
   - Development tools (Cursor, Neovim, Git, Docker, etc.)
   - Essential applications (Chrome, Alacritty, VLC, etc.)
   - Custom themes and configurations
   - System utilities and scripts

2. **Post-installation:**
   - The script will automatically configure your shell
   - Restart your system to apply all changes
   - Your new desktop environment is ready to use!

### How It Works

#### CLI

- `src/scripts/install-de.sh` - Downloads and installs all the software
- `src/scripts/config-de.sh` - Create or update the configuration files

As the configuration files creation are not dependent on the installation, the `src/scripts/install-de.sh` & `src/scripts/config-de.sh` can be run in parallel for faster execution

### Development

// TODO: add development documentation

---

[Contribute](CONTRIBUTING.md) | [Security](SECURITY.md) | [License](LICENSE)
