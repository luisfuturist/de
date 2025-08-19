#!/bin/bash

# Check if the docker group exists, if not, create it
if ! getent group docker > /dev/null 2>&1; then
    echo "Creating docker group..."
    sudo groupadd docker
else
    echo "Docker group already exists."
fi

# Add current user to the docker group
echo "Adding $USER to the docker group..."
sudo usermod -aG docker $USER

# Inform the user to log out and log back in
echo "User $USER added to docker group."

echo "Applying changes..."
newgrp docker

# Test Docker without sudo (optional)
# echo "Testing Docker without sudo..."
# docker run hello-world
