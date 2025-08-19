echo "Installing appearance..."

## Install dependencies
echo "Installing dependencies..."
sudo pacman -S ttf-roboto ttf-roboto-mono --noconfirm
sudo pacman -S noto-fonts noto-fonts-emoji --noconfirm

## Installing themes and icons
echo "Installing icons..."
cp -r ./icons/. ~/.icons 

echo "Installing themes..."
cp -r ./themes/. ~/.themes

## Apply theme
echo "Applying theme..."
sed -i -E \
  -e '/gtk-theme-name/ s|.*|gtk-theme-name="oomox-lfds-dark"|' \
  -e '/gtk-icon-theme-name/ s|.*|gtk-icon-theme-name="oomox-lfds-dark"|' \
  ~/.gtkrc-2.0
