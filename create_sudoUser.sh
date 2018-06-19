#!/bin/bash
username=$1
publickey=$2
sshdir=/home/$username/.ssh
authorizedfile=$sshdir/authorized_keys
useradd $username
mkdir $sshdir
touch $authorizedfile
touch $username
chown -R $username:$username $sshdir
echo $publickey > $authorizedfile
chmod 700 $sshdir
chmod 600 $authorizedfile
echo $username" ALL=(ALL) NOPASSWD:ALL">$username
mv $username /etc/sudoers.d/
