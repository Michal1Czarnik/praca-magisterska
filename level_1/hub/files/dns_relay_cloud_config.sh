#!/bin/bash

# Remove the existing /etc/resolv.conf
rm -rf /etc/resolv.conf

# Add nameserver 168.63.129.16 to /etc/resolv.conf
echo "nameserver 168.63.129.16" > /etc/resolv.conf

# Update the package repository
apt-get update

# Create the dnsmasq.conf file
echo 'interface=eth0' > /etc/dnsmasq.conf
echo 'conf-dir=/etc/dnsmasq.d' >> /etc/dnsmasq.conf
chmod 0644 /etc/dnsmasq.conf
chown root:root /etc/dnsmasq.conf

# Install dnsmasq
DEBIAN_FRONTEND=noninteractive apt-get install -y dnsmasq

# Disable and stop systemd-resolved
systemctl disable systemd-resolved
systemctl stop systemd-resolved

# Reload systemd daemons
systemctl daemon-reload

# Enable and restart dnsmasq service
systemctl enable dnsmasq.service
systemctl restart dnsmasq.service
