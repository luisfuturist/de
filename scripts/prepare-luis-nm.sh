# Create user with home directory
sudo useradd -m luis-nm

# Set password for user
sudo passwd luis-nm

# Add user permissions: sudo access, audio, video, storage, network
sudo usermod -aG wheel,audio,video,storage,network luis-nm

# Configure sudoers file
sudo visudo

# Add the following line to the sudoers file:
luis-nm ALL=(ALL) ALL
# Uncomment the following line:
# %wheel ALL=(ALL:ALL) ALL

# Save and exit with :wq

# Copy configs
sudo cp -r /home/luis/GitHub/luisfuturist/de/src/files/home/luis/.themes /home/luis-nm/.themes
sudo cp -r /home/luis/GitHub/luisfuturist/de/src/files/home/luis/.icons /home/luis-nm/.icons
sudo cp -r /home/luis/GitHub/luisfuturist/de/src/files/home/luis/.config/alacritty /home/luis-nm/.config/alacritty
sudo cp -r /home/luis/GitHub/luisfuturist/de/src/files/home/luis/.config/Cursor /home/luis-nm/.config/Cursor
sudo cp -r /home/luis/GitHub/luisfuturist/de/src/files/home/luis/.config/dunst /home/luis-nm/.config/dunst
sudo mkdir -p /home/luis-nm/.config/hypr
sudo cp -r /home/luis/GitHub/luisfuturist/de/src/files/home/luis/.config/hypr/hyprland.conf /home/luis-nm/.config/hypr/hyprland.conf
sudo cp -r /home/luis/GitHub/luisfuturist/de/src/files/home/luis/.config/waybar /home/luis-nm/.config/waybar
sudo cp -r /home/luis/GitHub/luisfuturist/de/src/files/home/luis/.config/yazi /home/luis-nm/.config/yazi

