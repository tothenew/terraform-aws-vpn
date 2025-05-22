#!/bin/bash

set -e

echo "[+] Updating and installing dependencies..."
sudo apt-get update -y
sudo apt-get install -y gnupg curl lsb-release

echo "[+] Adding MongoDB 7.0 repository and GPG key..."
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo gpg --dearmor -o /usr/share/keyrings/mongodb-server-7.0.gpg
echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org.list

echo "[+] Installing MongoDB..."
sudo apt-get update -y
sudo apt-get install -y mongodb-org

echo "[+] Disabling firewall (if enabled)..."
sudo ufw disable || true

echo "[+] Downloading Pritunl 1.32.4258.38 package for Debian Bookworm (Ubuntu 24.04 compatible)..."
cd /tmp
wget https://github.com/pritunl/pritunl/releases/download/1.32.4258.38/pritunl_1.32.4258.38-0debian1.bookworm_amd64.deb

echo "[+] Installing Pritunl..."
sudo dpkg -i pritunl_1.32.4258.38-0debian1.bookworm_amd64.deb || sudo apt-get install -f -y

echo "[+] Installing VPN dependencies..."
sudo apt-get install -y openvpn wireguard wireguard-tools

echo "[+] Enabling and starting MongoDB and Pritunl services..."
sudo systemctl enable mongod pritunl
sudo systemctl start mongod pritunl

echo "[✓] Installation complete!"
pritunl version
mongod --version
