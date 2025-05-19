#!/bin/bash

# Add MongoDB, OpenVPN, and Pritunl repo for Ubuntu 20.04 (focal)
sudo tee /etc/apt/sources.list.d/mongodb-org.list << EOF
deb [ signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/7.0 multiverse
EOF

sudo tee /etc/apt/sources.list.d/openvpn.list << EOF
deb [ signed-by=/usr/share/keyrings/openvpn-repo.gpg ] https://build.openvpn.net/debian/openvpn/stable focal main
EOF

sudo tee /etc/apt/sources.list.d/pritunl.list << EOF
deb [ signed-by=/usr/share/keyrings/pritunl.gpg ] https://repo.pritunl.com/stable/apt focal main
EOF

# Install gnupg
sudo apt-get update -y
sudo apt-get install -y gnupg curl

# Add GPG keys
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo gpg --dearmor -o /usr/share/keyrings/mongodb-server-7.0.gpg
curl -fsSL https://swupdate.openvpn.net/repos/repo-public.gpg | sudo gpg --dearmor -o /usr/share/keyrings/openvpn-repo.gpg
curl -fsSL https://raw.githubusercontent.com/pritunl/pgp/master/pritunl_repo_pub.asc | sudo gpg --dearmor -o /usr/share/keyrings/pritunl.gpg

# Update and install packages
sudo apt-get update -y
sudo apt-get install -y pritunl openvpn mongodb-org wireguard wireguard-tools

# Disable firewall and enable services
sudo ufw disable
sudo systemctl start pritunl mongod
sudo systemctl enable pritunl mongod
