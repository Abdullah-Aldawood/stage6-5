#!/bin/bash
set -e

date
echo "Updating Python application on VM..."

GITHUB_TOKEN= $GITHUB_TOKEN
APP_DIR="/home/azureuser/stage6-5-1"
GIT_REPO="https://github.com/Abdullah-Aldawood/stage6-5.git"
BRANCH="main"

# Update code
if [ -d "\$APP_DIR" ]; then
    sudo -u azureuser bash -c "cd \$APP_DIR && git pull origin \$BRANCH"
else
    sudo -u azureuser git clone -b \$BRANCH "https://\$GITHUB_TOKEN@\$GIT_REPO" "\$APP_DIR"
    sudo -u azureuser bash -c "cd \$APP_DIR"
fi

# Install dependencies
sudo -u azureuser /home/azureuser/stage6-5-1/venv/bin/pip install --upgrade pip
sudo -u azureuser /home/azureuser/stage6-5-1/venv/bin/pip install -r "\$APP_DIR/requirements.txt"

# Restart the service
sudo systemctl restart backend
sudo systemctl restart frontend

echo "Python application update completed!"


