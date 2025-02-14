# Bin

# move ./bin/** into /usr/local/bin
cp -r ./bin/* /usr/local/bin

# update permissions
chmod +x /usr/local/bin/*

# reload bashrc
source ~/.bashrc

# Git

su - luis -c '  
git config --global user.name "Luis Emidio" &&  
git config --global user.email "luisfuturist@gmail.com" &&  
git config --global core.editor "code --wait"  
'
