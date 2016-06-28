#!/bin/bash -v

# Usage :: ./puppetmaster.sh <puppetmaster_hostname>

# HOSTNAME
sudo bash -c "echo \"127.0.0.1 $1\" >> /etc/hosts"
sudo hostname $1
sudo bash -c "echo \"$1\" > /etc/hostname"


# NTP
sudo ntpdate pool.ntp.org

# Install PuppetMaster
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
sudo dpkg -i puppetlabs-release-trusty.deb
sudo apt-get update -y
sudo apt-get install puppetmaster-passenger -y

# Stop Apache service
sudo service apache2 stop

# Create PuppetMaster Version Locking file
sudo bash -c "echo Package: puppet puppet-common puppetmaster-passenger > /etc/apt/preferences.d/00-puppet.pref"
sudo bash -c "echo Pin: version 3.8.6 >> /etc/apt/preferences.d/00-puppet.pref"
sudo bash -c "echo Pin-Priority: 501 >> /etc/apt/preferences.d/00-puppet.pref"

# Delete Old Certs
sudo rm -rf /var/lib/puppet/ssl

# Modifying puppet.conf
sudo sed -i '7 s/^/#/' /etc/puppet/puppet.conf
sudo sed -i '8i certname = $1' /etc/puppet/puppet.conf
sudo sed -i '9i dns_alt_names = puppet,$1' /etc/puppet/puppet.conf

# Generating new Certs
sudo bash -c "timeout 30 puppet master --verbose --no-daemonize"

# Create main Manifest file
sudo touch /etc/puppet/manifests/site.pp

# Start Apache
sudo service apache2 start
