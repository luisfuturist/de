# Bin

# move ./bin/** into /usr/local/bin
cp -r ./bin/* /usr/local/bin

# update permissions
chmod +x /usr/local/bin/*

# reload bashrc
source ~/.bashrc