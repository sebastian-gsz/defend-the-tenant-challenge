#!/usr/bin/env bash
set -e
sudo apt-get update -qq
sudo apt-get install -y wget apt-transport-https ca-certificates gnupg 2>&1 | tail -5
wget -q https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O /tmp/pmp.deb
sudo dpkg -i /tmp/pmp.deb
sudo apt-get update -qq
sudo apt-get install -y powershell 2>&1 | tail -20
echo "PWsh version:"
pwsh --version