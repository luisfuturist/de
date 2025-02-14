# setup

sudo pacman-mirrors -c Brazil

setxkbmap -layout br -variant abnt2
sudo timedatectl set-timezone America/Sao_Paulo

yay -S google-chrome --noconfirm

# bin

# move ./bin/** into /usr/local/bin
cp -r ./bin/* /usr/local/bin

# update permissions
chmod +x /usr/local/bin/*

# reload bashrc
source ~/.bashrc

# alacritty

sudo pacman -S alacritty --noconfirm

# i3
# TODO: install i3

# tools

## dev

### git

# git config
su - luis -c '  
git config --global user.name "Luis Emidio" &&  
git config --global user.email "luisfuturist@gmail.com" &&  
git config --global core.editor "code --wait"  
'

# install git command aliases
# TODO: install git aliases file and source it in .bashrc

### tooling

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
nvm install node

curl -fsSL https://bun.sh/install | bash

curl -fsSL https://get.pnpm.io/install.sh | sh -

sudo pacman -S jdk21-openjdk jdk17-openjdk --noconfirm

sudo pamac install docker docker-compose --noconfirm

yay -S visual-studio-code-bin --noconfirm

## media

sudo pacman -S peek inkscape vlc qt6-multimedia-ffmpeg obs-studio kdenlive gimp --noconfirm

## docs

sudo pacman -Rns mupdf --noconfirm
sudo pacman -S evince --noconfirm
xdg-mime default org.gnome.Evince.desktop application/pdf

# theme

sudo pamac install ttf-roboto ttf-roboto-mono noto-fonts noto-fonts-emoji --no-confirm

## TODO: install oomox theme
