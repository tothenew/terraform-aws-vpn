#!/bin/bash
echo "==================installing pritunl================="
apt-get update -y
apt-get install curl gnupg2 wget unzip -y

echo "deb http://repo.pritunl.com/stable/apt focal main" | tee /etc/apt/sources.list.d/pritunl.list
# Import signing key from keyserver
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
# Alternative import from download if keyserver offline
curl https://raw.githubusercontent.com/pritunl/pgp/master/pritunl_repo_pub.asc | apt-key add -

echo "deb https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-5.0.list
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | apt-key add -

apt update

# WireGuard server support
apt -y install wireguard wireguard-tools

ufw disable

apt -y install pritunl mongodb-org
systemctl enable mongod pritunl
systemctl start mongod pritunl

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# cat <<<'{
#     "debug": false,
#     "bind_addr": "0.0.0.0",
#     "port": 443,
#     "log_path": "/var/log/pritunl.log",
#     "temp_path": "/tmp/pritunl_%r",
#     "local_address_interface": "auto",
#     "mongodb_uri": "mongodb://localhost:27017/pritunl"
# }' > /etc/pritunl.conf
pritunl set-mongodb "mongodb://localhost:27017/pritunl"

systemctl restart pritunl

# username=`sudo pritunl default-password | grep username | cut -d ":" -f2 |tr -d '"'|tr '\n' ' ' | tr -d ' '`
# password=`sudo pritunl default-password | grep password: | cut -d ":" -f2 |  tr -d '"'|tr '\n' ' ' | tr -d ' '`

# echo "export username=$username" >> .bashrc
# echo "export password=$password" >> .bashrc

# source .bashrc
# echo "username = $username" > /home/ubuntu/creds.txt
# echo "password = $password" >> /home/ubuntu/creds.txt
# aws ssm put-parameter \
#     --name "pritunl-username" \
#     --value $username \
#     --type SecureString

# aws ssm put-parameter \
#     --name "pritunl-password" \
#     --value $password \
#     --type SecureString