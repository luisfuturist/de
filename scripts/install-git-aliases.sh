echo "Applying git aliases..."

# Copy the script to a proper location
sudo cp git-aliases.sh /usr/local/bin/git-aliases.sh
sudo chmod +x /usr/local/bin/git-aliases.sh

# Ensure the script is sourced only once in ~/.bashrc
if ! grep -qxF 'source /usr/local/bin/git-aliases.sh' ~/.bashrc; then
    echo 'source /usr/local/bin/git-aliases.sh' >> ~/.bashrc
fi

# Reload bashrc to apply changes
source ~/.bashrc

echo "Git aliases applied successfully!"
