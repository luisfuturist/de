echo "Installing bin scripts..."
# move ./bin/** into /usr/local/bin
sudo cp -r ./bin/* /usr/local/bin

# update permissions
sudo chmod +x /usr/local/bin/*

# reload bashrc
source ~/.bashrc

echo "Installed bin scripts!"
