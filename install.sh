# setup

setxkbmap -layout br -variant abnt2

sudo pacman-mirrors -c Brazil

sudo timedatectl set-timezone America/Sao_Paulo

yay -S google-chrome --noconfirm

# bin

bash scripts/install-bin.sh

# hardware config

sudo pacman -S brightnessctl --noconfirm

# misc

yay -S google-chrome --noconfirm
sudo pamac install transmission-gtk --noconfirm

# alacritty

sudo pacman -S alacritty --noconfirm

# i3
# TODO: install i3

# file explorer

sed -i 's/show_hidden=0/show_hidden=1/' ~/.config/pcmanfm/default/pcmanfm.conf

# tools

## monitoring

sudo pacman -S htop glances --noconfirm

## screenshot

sudo pacman -S flameshot --noconfirm

## dev

### git

su - luis -c '  
git config --global user.name "Luis Emidio" &&  
git config --global user.email "luisfuturist@gmail.com" &&  
git config --global core.editor "code --wait"  
'

bash scripts/install-git-aliases.sh

sudo pacman -S github-cli --noconfirm

### tooling

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
nvm install node

curl -fsSL https://bun.sh/install | bash

curl -fsSL https://get.pnpm.io/install.sh | sh -

sudo pacman -S jdk21-openjdk jdk17-openjdk --noconfirm

sudo pamac install docker docker-compose --noconfirm

yay -S visual-studio-code-bin --noconfirm

## network

sudo pacman -S net-tools bind-tools nmap --noconfirm
curl -fsSL https://tailscale.com/install.sh | sh

## media

sudo pacman -S peek inkscape vlc qt6-multimedia-ffmpeg obs-studio kdenlive gimp --noconfirm

## docs

sudo pacman -Rns mupdf --noconfirm
sudo pacman -S evince --noconfirm
xdg-mime default org.gnome.Evince.desktop application/pdf

# theme

sudo pamac install ttf-roboto ttf-roboto-mono noto-fonts-emoji --no-confirm
sudo pacman -S noto-fonts --noconfirm

## TODO: install oomox theme

yay -S themix-full-git
