# 💻 Desktop Environment

This repository contains my personal workstation files for my Linux system, showcasing various customizations across different components such as the window manager, terminal, notification daemon, status bar, and desktop environment. These customizations are designed to enhance my overall user experience and workflow.

## Scope

* **Window Manager:** Custom keybindings, layouts, and appearance.
* **Terminal:** Custom colors and fonts.
* **Notification Daemon:** Custom appearance and behavior.
* **Status Bar:** System information display and custom formatting.
* **Lock Screen** 
* **Desktop Environment:** 
  * Custom wallpaper
  * Custom Oomox GTK+ Theme
  * Custom Archdroid icon theme
* **Installation of Essential Programs**

## Features

General config
- Set `$mod` as `Mod4`;
- Keyboard layout to `br-abnt2`;

Key bindings powered by [i3wm](https://i3wm.org/):
- Resize and notification modes;
- Layout bindings: fullscreen, split, floating/tiling, tabs, and more;
- Screenshot using `gnome-screenshot` by pressing `Print`;
- Start a new terminal by pressing `$mod+Return`;
- Open application launcher by pressing `$mod+d`;
- Adjust volume;
- Bindings for restarting and reloading i3;
- Bindings for workspace management.

Statusbar powered by [i3status](https://github.com/i3/i3status):
- Hardware info: disk, RAM, CPU and battery usage;
- Network;
- Date time;

Appearence
- Font: Roboto;
- Custom wallpaper;
- Custom [i3wm](https://i3wm.org/) appearence;
- Custom notification appearence powered by [dunst](https://github.com/dunst-project/dunst);
- Custom application launcher appearence powered by [dmenu](https://wiki.archlinux.org/title/Dmenu);
- Custom `alacritty` appearence;
- Custom GTK theme based on Oomox theme style;
- Custom icon theme based on Android Lollipop's material design icons.

## Getting Started

### Prerequisites

- Manjaro with i3 Window Manager
- Git

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/luisfuturist/de.git
   cd de
   ```

2. Install:
    ```bash
   bash install.sh
   ```

### Development

If you're editing the configuration files in this repo, don’t forget to apply the changes to see the effects:

```bash
bash scripts/apply-config.sh
```

To customize the appearance using Themix, install the editor with:

```bash
bash scripts/install-appearance-editor.sh
```

To test LightDM, run:

```bash
bash scripts/test-lightdm.sh
```

After making changes to the config, remember to extract them back into this repo:

```bash
bash scripts/extract-config.sh
```

## Note

- This configuration is specific to my own preferences and may require adjustments to work optimally on your system.
- Some of the scripts and configurations may require root privileges to install or modify system settings.
