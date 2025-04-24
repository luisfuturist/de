echo "Installing appearance editor..."

echo "Installing Oomox config..."
cp -r ./config/oomox/. ~/.config/oomox/

## Install appearance editor
echo "Installing dependencies..."
yay -S themix-theme-oomox-git --noconfirm
yay -S themix-icons-archdroid-git --noconfirm
yay -S themix-full-git --noconfirm

echo "Appearance editor installed."
