#!/usr/bin/env bash
#to avoid the "dpkg-reconfigure: unable to re-open stdin: No file or directory"
export DEBIAN_FRONTEND=noninteractive
# install ansible (http://docs.ansible.com/intro_installation.html)
apt-get -y install software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get -y install ansible
apt-get -y install python python-dev
apt-get -y install python-pip
pip install boto
pip install awscli
cat <<EOT >> /home/vagrant/.bashrc
export AWS_ACCESS_KEY=abc123
export AWS_SECRET_KEY=abc123
EOT
mv /etc/ansible/hosts /etc/ansible/hosts.org
cd /etc/ansible
wget https://raw.github.com/ansible/ansible/devel/contrib/inventory/ec2.py
cp ec2.py hosts
chmod +x hosts
wget https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.ini
# we need to sed into /etc/ansible/ec2.ini regions = us-east-1,us-west-1 instead of 'all'
# copy examples into /home/vagrant (from inside the mgmt node)
cp -a /vagrant/* /home/vagrant
chown -R vagrant:vagrant /home/vagrant

# configure hosts file for our internal network defined by Vagrantfile
cat >> /etc/hosts <<EOL

# vagrant environment nodes
10.0.15.40  ansibmk
10.0.15.10  mgmt
10.0.15.11  lb
10.0.15.21  web1
10.0.15.22  web2
10.0.15.23  web3
10.0.15.24  web4
10.0.15.25  web5
10.0.15.26  web6
10.0.15.27  web7
10.0.15.28  web8
10.0.15.29  web9
EOL
