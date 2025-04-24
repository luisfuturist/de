echo "Applying alacritty config..."
mkdir -p ~/.config/alacritty
cp -r ./config/alacritty/alacritty.toml ~/.config/alacritty
echo "Alacritty config applied successfully!"

echo "Applying i3 config..."
mkdir -p ~/.config/i3
cp -r ./config/i3/config ~/.config/i3
echo "i3 config applied successfully!"

echo "Applying i3status config..."
mkdir -p ~/.config/i3status
cp -r ./config/i3status/i3status.conf ~/.config/i3status/i3status.conf
echo "i3 config applied successfully!"

echo "Applying nitrogen config..."
mkdir -p ~/.config/nitrogen
cp -r ./config/nitrogen/bg-saved.cfg ~/.config/nitrogen/bg-saved.cfg
echo "nitrogen config applied successfully!"

echo "Applying oomox config..."
cp -r ./config/oomox/. ~/.config/oomox/
echo "Oomox applied successfully!"

echo "Applying wallpaper..."
sudo cp ./images/SkinEmerging_08-30-2014_01-1.jpg /usr/share/backgrounds
nitrogen --restore
echo "Wallpaper applied successfully!"

bash ./scripts/install-git-aliases.sh
